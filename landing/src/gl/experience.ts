import {
  HalfFloatType,
  Mesh,
  OrthographicCamera,
  PlaneGeometry,
  Scene,
  ShaderMaterial,
  SRGBColorSpace,
  UnsignedByteType,
  Vector2,
  WebGLRenderTarget,
  WebGLRenderer,
} from 'three';
import { VIEWS_PER_ACT, actOfView, beatAt } from '../story';
import type { Act, SceneCopy } from './act';
import { createRiver } from './acts/river';
import { createSky } from './acts/sky';
import { createTemple } from './acts/temple';
import { createYantra } from './acts/yantra';

/** Built on first use: only the act on screen is paid for up front. */
const ACT_FACTORIES: readonly ((copy: SceneCopy) => Act)[] = [createRiver, createSky, () => createTemple(), () => createYantra()];

const MAX_DPR_DESKTOP = 1.75;
const MAX_DPR_MOBILE = 1.25;

/**
 * Owns the renderer and the four acts. Every frame renders the current act
 * (or, across an act boundary, both) into float targets and composites them
 * with a noise dissolve, a vignette and a little grain.
 */
export class Experience {
  private readonly renderer: WebGLRenderer;
  private readonly acts: (Act | null)[] = ACT_FACTORIES.map(() => null);
  private readonly targets: [WebGLRenderTarget, WebGLRenderTarget];
  private readonly post: { scene: Scene; camera: OrthographicCamera; material: ShaderMaterial };

  private width = 0;
  private height = 0;
  private dpr: number;
  private readonly maxDpr: number;
  private slowFrames = 0;
  private lastTime = 0;
  private lost = false;
  private shown = false;

  private copy: SceneCopy;

  constructor(
    private readonly canvas: HTMLCanvasElement,
    copy: SceneCopy,
    onLost: () => void,
  ) {
    this.copy = copy;
    // Throws without WebGL2 or on a software renderer; the caller keeps the CSS backdrop.
    this.renderer = new WebGLRenderer({
      canvas,
      antialias: false,
      alpha: false,
      powerPreference: 'high-performance',
      failIfMajorPerformanceCaveat: true,
    });
    this.renderer.outputColorSpace = SRGBColorSpace;
    this.renderer.setClearColor(0x060a14, 1);

    this.maxDpr = window.matchMedia('(pointer: coarse)').matches ? MAX_DPR_MOBILE : MAX_DPR_DESKTOP;
    this.dpr = Math.min(window.devicePixelRatio || 1, this.maxDpr);

    const ext = this.renderer.extensions;
    const floatOk = ext.has('EXT_color_buffer_float') || ext.has('EXT_color_buffer_half_float');
    const makeTarget = (): WebGLRenderTarget =>
      new WebGLRenderTarget(1, 1, { type: floatOk ? HalfFloatType : UnsignedByteType, samples: 4, depthBuffer: true });
    this.targets = [makeTarget(), makeTarget()];

    this.post = createComposite(this.targets[0], this.targets[1]);

    canvas.addEventListener('webglcontextlost', (e) => {
      e.preventDefault();
      this.lost = true;
      canvas.classList.remove('is-ready');
      this.dispose();
      onLost();
    });

    this.resize();
  }

  resize(): void {
    if (this.lost) return;
    const w = window.innerWidth;
    const h = this.canvas.clientHeight || window.innerHeight;
    if (w === this.width && h === this.height && this.renderer.getPixelRatio() === this.dpr) return;
    this.width = w;
    this.height = h;
    this.renderer.setPixelRatio(this.dpr);
    this.renderer.setSize(w, h, false);
    const bw = Math.floor(w * this.dpr), bh = Math.floor(h * this.dpr);
    this.targets.forEach((t) => t.setSize(bw, bh));
    (this.post.material.uniforms.uRes!.value as Vector2).set(bw, bh);
    this.acts.forEach((act) => act?.resize(w, h, this.dpr));
  }

  /** New language: redraws the words inside the scene without rebuilding it. */
  setCopy(copy: SceneCopy): void {
    this.copy = copy;
    this.acts.forEach((act) => act?.setCopy?.(copy));
  }

  /** The act at [index], building it on first use. */
  private act(index: number): Act {
    let act = this.acts[index];
    if (!act) {
      act = ACT_FACTORIES[index]!(this.copy);
      act.resize(this.width, this.height, this.dpr);
      this.acts[index] = act;
    }
    return act;
  }

  /** Builds the remaining acts one per idle period, so scrolling into one never stalls. */
  private warmUp(): void {
    const idle = (cb: () => void): void => {
      if ('requestIdleCallback' in window) window.requestIdleCallback(cb, { timeout: 2000 });
      else setTimeout(cb, 120);
    };
    const next = (): void => {
      if (this.lost) return;
      const missing = this.acts.findIndex((a) => a === null);
      if (missing < 0) return;
      this.act(missing);
      idle(next);
    };
    idle(next);
  }

  render(view: number, time: number, reducedMotion: boolean, px: number, py: number): void {
    if (this.lost) return;
    this.adaptQuality(time);

    const ambient = reducedMotion ? 0 : 1;
    const t = reducedMotion ? 0 : time;
    const { from, ease } = beatAt(view, reducedMotion);
    const actA = actOfView(from), actB = actOfView(from + 1);
    const pointerX = px * ambient, pointerY = py * ambient;

    const u = this.post.material.uniforms;
    u.uTime!.value = time;

    if (actA === actB || ease <= 0.001 || ease >= 0.999) {
      const index = actA === actB ? actA : ease >= 0.999 ? actB : actA;
      const k = actA === actB ? from - actA * VIEWS_PER_ACT + ease : index === actA ? VIEWS_PER_ACT - 1 : 0;
      this.draw(index, 0, k, 0, t, ambient, pointerX, pointerY);
      u.uMix!.value = 0;
    } else {
      this.draw(actA, 0, VIEWS_PER_ACT - 1, ease, t, ambient, pointerX, pointerY);
      this.draw(actB, 1, 0, -(1 - ease), t, ambient, pointerX, pointerY);
      u.uMix!.value = ease;
    }

    this.renderer.setRenderTarget(null);
    this.renderer.render(this.post.scene, this.post.camera);

    if (!this.shown) {
      this.shown = true;
      this.canvas.classList.add('is-ready');
      this.warmUp();
    }
  }

  private draw(index: number, slot: 0 | 1, k: number, edge: number, time: number, ambient: number, px: number, py: number): void {
    const act = this.act(index);
    act.update({ k, edge, time, ambient, px, py });
    this.renderer.setRenderTarget(this.targets[slot]);
    this.renderer.render(act.scene, act.camera);
  }

  /** Steps the pixel ratio down (never back up) if frames keep running long. */
  private adaptQuality(time: number): void {
    const dt = this.lastTime ? time - this.lastTime : 0;
    this.lastTime = time;
    if (dt <= 0 || dt > 0.25) return; // first frame, or the tab was hidden
    this.slowFrames = dt > 1 / 40 ? this.slowFrames + 1 : Math.max(0, this.slowFrames - 1);
    if (this.slowFrames > 90 && this.dpr > 1) {
      this.dpr = Math.max(1, this.dpr - 0.25);
      this.slowFrames = 0;
      this.width = 0; // force resize
      this.resize();
    }
  }

  dispose(): void {
    this.acts.forEach((act) => act?.dispose());
    this.targets.forEach((t) => t.dispose());
    this.post.material.dispose();
    this.renderer.dispose();
  }
}

function createComposite(a: WebGLRenderTarget, b: WebGLRenderTarget) {
  const material = new ShaderMaterial({
    uniforms: {
      tA: { value: a.texture },
      tB: { value: b.texture },
      uMix: { value: 0 },
      uTime: { value: 0 },
      uRes: { value: new Vector2(1, 1) },
    },
    vertexShader: /* glsl */ `
      varying vec2 vUv;
      void main() { vUv = uv; gl_Position = vec4(position.xy, 0.0, 1.0); }`,
    fragmentShader: /* glsl */ `
      uniform sampler2D tA, tB;
      uniform float uMix, uTime;
      uniform vec2 uRes;
      varying vec2 vUv;

      float hash(vec2 p) { return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453); }
      float noise(vec2 p) {
        vec2 i = floor(p), f = fract(p), u = f * f * (3.0 - 2.0 * f);
        return mix(mix(hash(i), hash(i + vec2(1.0, 0.0)), u.x), mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), u.x), u.y);
      }

      void main() {
        vec3 col = texture2D(tA, vUv).rgb;
        if (uMix > 0.0) {
          vec3 next = texture2D(tB, vUv).rgb;
          vec2 p = vUv * vec2(uRes.x / uRes.y, 1.0) * 3.0;
          float n = noise(p) * 0.6 + noise(p * 2.3) * 0.3 + noise(p * 5.1) * 0.1;
          n = n * 0.75 + vUv.y * 0.25;                 // the next act rises from below, like smoke
          float edge = uMix * 1.3 - 0.15;
          float keep = smoothstep(edge - 0.03, edge + 0.03, n);
          col = mix(next, col, keep);
          float rim = pow(1.0 - abs(keep * 2.0 - 1.0), 8.0); // thin ember line along the dissolve front
          col += vec3(1.0, 0.55, 0.18) * rim * 0.9 * (1.0 - abs(uMix * 2.0 - 1.0));
        }
        float vig = smoothstep(1.2, 0.3, length((vUv - 0.5) * vec2(1.1, 1.0)) * 1.35);
        col *= mix(0.7, 1.0, vig);
        col += (hash(vUv * uRes + fract(uTime) * 91.0) - 0.5) * 0.0035;
        gl_FragColor = vec4(max(col, 0.0), 1.0);
        #include <colorspace_fragment>
      }`,
    depthTest: false,
    depthWrite: false,
  });
  const scene = new Scene();
  const quad = new Mesh(new PlaneGeometry(2, 2), material);
  quad.frustumCulled = false;
  scene.add(quad);
  return { scene, camera: new OrthographicCamera(-1, 1, 1, -1, 0, 1), material };
}
