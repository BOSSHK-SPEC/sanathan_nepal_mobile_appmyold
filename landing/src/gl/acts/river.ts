import {
  AdditiveBlending,
  BufferAttribute,
  BufferGeometry,
  type CanvasTexture,
  Color,
  PerspectiveCamera,
  Points,
  Scene,
  ShaderMaterial,
} from 'three';
import { canvasFontStack, loadFontsFor } from '../../fonts';
import { clamp } from '../../math';
import type { Act, ActFrame, SceneCopy } from '../act';
import { aspectFactor, disposeScene, frameCamera, verticalGradient } from '../helpers';

/** View 0 is always ॐ; views 1 and 2 are words in the page's language. */
const wordsFor = (copy: SceneCopy): readonly string[] => ['ॐ', ...copy.words];
const VIEWS = 3;
const WATER = -1.35;
const WORD_Y = 0.6;
const WORD_WIDTH = 8.2;

/**
 * Act I · Diyo River. Lamps float on dark water and lift into a Devanagari
 * word per view. Formations are sampled from the real font once, uploaded as
 * attributes, and morphed in the vertex shader; on exit the lamps rise into
 * the sky of Act II.
 */
export function createRiver(copy: SceneCopy): Act {
  const scene = new Scene();
  scene.background = verticalGradient(['#060A14', '#08101E', '#0B1A2A']);
  const camera = new PerspectiveCamera(40, 1, 0.1, 200);

  const count = window.matchMedia('(pointer: coarse)').matches ? 3000 : 6000;
  const seeds = new Float32Array(count);
  const river = new Float32Array(count * 2);
  for (let i = 0; i < count; i++) {
    seeds[i] = Math.random();
    river[i * 2] = (Math.random() - 0.5) * 22;
    river[i * 2 + 1] = 4 - Math.random() * 18;
  }

  // Until the font arrives every formation is a halo of lamps.
  const halo = new Float32Array(count * 3);
  for (let i = 0; i < count; i++) {
    const a = Math.random() * Math.PI * 2, r = 1.55 + (Math.random() - 0.5) * 0.18;
    halo.set([Math.cos(a) * r, WORD_Y + Math.sin(a) * r, (Math.random() - 0.5) * 0.25], i * 3);
  }
  const formations: Float32Array[] = Array.from({ length: VIEWS }, () => halo);
  let generation = 0;
  // Sample the words from the real font once it has loaded. A newer language
  // wins over an older one still loading; until then the previous words stay.
  const sampleAll = (next: SceneCopy): void => {
    const words = wordsFor(next);
    const mine = ++generation;
    void loadFontsFor(words.join(' '), undefined, ['display']).then(() => {
      if (mine !== generation) return;
      words.forEach((word, i) => {
        const sampled = sampleWord(word, count);
        if (sampled) formations[i] = sampled;
      });
      uploaded = -1;
    });
  };
  sampleAll(copy);

  const geometry = new BufferGeometry();
  const from = new BufferAttribute(halo.slice(), 3);
  const to = new BufferAttribute(halo.slice(), 3);
  geometry.setAttribute('position', from);
  geometry.setAttribute('aB', to);
  geometry.setAttribute('aSeed', new BufferAttribute(seeds, 1));
  geometry.setAttribute('aRiver', new BufferAttribute(river, 2));
  let uploaded = -1;

  const lamps = new Points(geometry, lampMaterial(1, 0));
  const reflection = new Points(geometry, lampMaterial(0.22, 1));
  lamps.frustumCulled = reflection.frustumCulled = false;
  reflection.scale.y = -1;
  reflection.position.y = 2 * WATER;
  scene.add(lamps, reflection);

  let fac = 1;
  return {
    scene,
    camera,
    resize(w, h, dpr) {
      frameCamera(camera, w, h, 'up');
      fac = aspectFactor(w / h);
      const scale = (h * dpr) / (2 * Math.tan((camera.fov * Math.PI) / 360));
      lamps.material.uniforms.uScale!.value = scale;
      reflection.material.uniforms.uScale!.value = scale;
    },
    update({ k, edge, time, ambient, px, py }: ActFrame) {
      const i = Math.min(Math.floor(k), VIEWS - 2), f = k - i;
      if (uploaded !== i) {
        from.copyArray(formations[i]!);
        to.copyArray(formations[i + 1]!);
        from.needsUpdate = to.needsUpdate = true;
        uploaded = i;
      }
      const lift = clamp(edge, 0, 1);
      for (const m of [lamps.material, reflection.material]) {
        const u = m.uniforms;
        u.uF!.value = f;
        u.uTime!.value = time;
        u.uDrift!.value = (time * 0.18) % 22;
        u.uLift!.value = lift;
        u.uAmb!.value = ambient;
      }
      reflection.material.uniforms.uAlpha!.value = 0.22 * (1 - lift);

      const swell = Math.sin(Math.PI * f);
      camera.position.set(px * 0.3, 0.5 + swell * 0.9 - py * 0.2 + lift * 1.5, (9 + swell * 1.8) * fac);
      camera.lookAt(0, 0.25 + lift * 5, 0);
    },
    setCopy(next) {
      sampleAll(next);
    },
    dispose() {
      disposeScene(scene);
      (scene.background as CanvasTexture).dispose();
    },
  };
}

function lampMaterial(alpha: number, mirror: number): ShaderMaterial {
  return new ShaderMaterial({
    uniforms: {
      uF: { value: 0 },
      uTime: { value: 0 },
      uDrift: { value: 0 },
      uLift: { value: 0 },
      uAmb: { value: 1 },
      uScale: { value: 1000 },
      uAlpha: { value: alpha },
      uMirror: { value: mirror },
      uWater: { value: WATER },
      uWarm: { value: new Color(0xf2731f) },
      uCore: { value: new Color(0xffe3a6) },
    },
    vertexShader: /* glsl */ `
      attribute vec3 aB;
      attribute vec2 aRiver;
      attribute float aSeed;
      uniform float uF, uTime, uDrift, uLift, uAmb, uScale, uMirror, uWater;
      varying float vFlicker, vFade;

      float ease(float x) { return x < 0.5 ? 4.0 * x * x * x : 1.0 - pow(-2.0 * x + 2.0, 3.0) / 2.0; }

      void main() {
        float shimmer = sin(uTime * 1.3 + aSeed * 30.0) * 0.012 * uAmb;
        vec3 onWater = vec3(
          mod(aRiver.x + uDrift + 11.0, 22.0) - 11.0,
          uWater + 0.03 + sin(uTime * 0.8 + aSeed * 20.0) * 0.02 * uAmb,
          aRiver.y);
        // Staggered by seed so a word assembles like lamps being lifted one by one.
        float local = clamp(uF * 1.35 - aSeed * 0.35, 0.0, 1.0);
        vec3 a = position + vec3(shimmer, shimmer, 0.0);
        vec3 b = aB + vec3(shimmer, shimmer, 0.0);
        vec3 p = local < 0.5 ? mix(a, onWater, ease(local * 2.0)) : mix(onWater, b, ease((local - 0.5) * 2.0));

        float rise = clamp(uLift * 1.4 - aSeed * 0.4, 0.0, 1.0);
        p.y += rise * rise * (3.0 + aSeed * 9.0);
        p.x += rise * (aSeed - 0.5) * 2.0;
        vFade = 1.0 - rise * 0.6;

        if (uMirror > 0.5) p.x += sin(p.y * 6.0 + uTime * 1.6 + aSeed * 6.0) * 0.05;
        vec4 mv = modelViewMatrix * vec4(p, 1.0);
        vFlicker = 0.78 + 0.22 * sin(uTime * (6.0 + aSeed * 5.0) + aSeed * 40.0);
        gl_PointSize = uScale * (0.05 + 0.035 * aSeed) * vFlicker / max(-mv.z, 0.1);
        gl_Position = projectionMatrix * mv;
      }`,
    fragmentShader: /* glsl */ `
      uniform float uAlpha;
      uniform vec3 uWarm, uCore;
      varying float vFlicker, vFade;
      void main() {
        float d = length(gl_PointCoord - 0.5) * 2.0;
        if (d > 1.0) discard;
        float core = pow(1.0 - d, 3.0), halo = pow(1.0 - d, 1.4) * 0.45;
        gl_FragColor = vec4(mix(uWarm, uCore, core) * (core + halo) * vFlicker, uAlpha * vFade);
        #include <colorspace_fragment>
      }`,
    transparent: true,
    depthWrite: false,
    blending: AdditiveBlending,
  });
}

/** Renders `word` to an offscreen canvas and returns `count` lamp positions inside its glyphs. */
function sampleWord(word: string, count: number): Float32Array | null {
  const W = 1400, H = 460;
  const canvas = document.createElement('canvas');
  canvas.width = W;
  canvas.height = H;
  const g = canvas.getContext('2d', { willReadFrequently: true });
  if (!g) return null;
  g.fillStyle = '#fff';
  g.textAlign = 'center';
  g.textBaseline = 'middle';
  const stack = canvasFontStack();
  let size = word === 'ॐ' ? 360 : 230;
  g.font = `${size}px ${stack}`;
  const width = g.measureText(word).width;
  if (width > W - 120) {
    size = Math.floor((size * (W - 120)) / width); // long words in some scripts shrink to fit
    g.font = `${size}px ${stack}`;
  }
  g.fillText(word, W / 2, 250);
  const data = g.getImageData(0, 0, W, H).data;
  const hits: number[] = [];
  for (let y = 0; y < H; y += 4) for (let x = 0; x < W; x += 4) if (data[(y * W + x) * 4 + 3]! > 140) hits.push(x, y);
  if (hits.length < 200) return null;

  const out = new Float32Array(count * 3);
  const n = hits.length / 2;
  for (let i = 0; i < count; i++) {
    const h = Math.floor(Math.random() * n) * 2;
    out[i * 3] = ((hits[h]! - W / 2) / W) * WORD_WIDTH + (Math.random() - 0.5) * 0.03;
    out[i * 3 + 1] = WORD_Y - ((hits[h + 1]! - 240) / W) * WORD_WIDTH + (Math.random() - 0.5) * 0.03;
    out[i * 3 + 2] = (Math.random() - 0.5) * 0.25;
  }
  return out;
}
