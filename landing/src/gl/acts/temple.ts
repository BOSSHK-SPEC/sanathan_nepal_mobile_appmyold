import {
  AdditiveBlending,
  BoxGeometry,
  BufferAttribute,
  BufferGeometry,
  type CanvasTexture,
  ConeGeometry,
  CylinderGeometry,
  DirectionalLight,
  Fog,
  HemisphereLight,
  type Material,
  Mesh,
  MeshBasicMaterial,
  MeshStandardMaterial,
  PerspectiveCamera,
  PlaneGeometry,
  Points,
  PointsMaterial,
  Scene,
  SphereGeometry,
} from 'three';
import { mergeGeometries } from 'three/examples/jsm/utils/BufferGeometryUtils.js';
import { lerp } from '../../math';
import type { Act, ActFrame } from '../act';
import { aspectFactor, disposeScene, frameCamera, glowTexture, verticalGradient } from '../helpers';

const TERRACE_H = 0.72;
const TEMPLE_BASE = 5 * TERRACE_H;
const TIER_STEP = 1.25;

/** [orbit angle, radius, camera height, look-at height] per view: stairs, tiers, gajur. */
const KEYS: readonly (readonly [number, number, number, number])[] = [
  [0.35, 11, 3.0, 2.6],
  [-1.2, 10.5, 7.2, 5.8],
  [-2.6, 5.8, 12.4, 9.8],
];

/**
 * Act III · Nyatapola Ascent. Bhaktapur's five-tiered temple at dusk: five
 * brick terraces, a steep stair flanked by guardian pairs, five sal-wood tiers
 * and a gilded gajur. Geometry is merged per material, so the whole temple is
 * a handful of draw calls.
 */
export function createTemple(): Act {
  const scene = new Scene();
  scene.background = verticalGradient(['#1C1633', '#5E2C3E', '#C5664A', '#D9774A']);
  scene.fog = new Fog(0x4a2638, 28, 85);
  const camera = new PerspectiveCamera(42, 1, 0.1, 300);
  scene.add(new HemisphereLight(0xffd7a8, 0x2a1a22, 1.6));
  const sun = new DirectionalLight(0xffb074, 2.6);
  sun.position.set(-10, 12, 8);
  const fill = new DirectionalLight(0x8a7bd0, 0.8);
  fill.position.set(10, 6, -8);
  scene.add(sun, fill);

  const std = (color: number, extra: Partial<ConstructorParameters<typeof MeshStandardMaterial>[0]> = {}): MeshStandardMaterial =>
    new MeshStandardMaterial({ color, roughness: 0.9, ...extra });
  const materials = {
    brick: std(0x9a4a2e),
    stone: std(0xb89a7a),
    wood: std(0x5e3423),
    tile: std(0x3a2723, { roughness: 0.8 }),
    gilt: std(0xc8923a, { metalness: 0.6, roughness: 0.35, emissive: 0x3a2208 }),
    guard: std(0x5a4a42),
    dark: std(0x1a0e0a),
    window: new MeshBasicMaterial({ color: 0xe8a23a }),
  };
  type Part = keyof typeof materials;
  const parts = new Map<Part, BufferGeometry[]>();
  const add = (part: Part, geometry: BufferGeometry, x: number, y: number, z: number, rotY = 0): void => {
    if (rotY) geometry.rotateY(rotY);
    geometry.translate(x, y, z);
    const list = parts.get(part) ?? [];
    list.push(geometry.index ? geometry.toNonIndexed() : geometry);
    parts.set(part, list);
  };
  const box = (part: Part, w: number, h: number, d: number, x: number, y: number, z: number): void =>
    add(part, new BoxGeometry(w, h, d), x, y, z);

  const ground = new Mesh(new PlaneGeometry(220, 220), std(0x2b1b1a));
  ground.rotation.x = -Math.PI / 2;
  scene.add(ground);

  for (let k = 0; k < 5; k++) {
    const w = 9.6 - k * 1.2;
    box('brick', w, TERRACE_H, w, 0, TERRACE_H / 2 + k * TERRACE_H, 0);
    box('stone', w + 0.1, 0.06, w + 0.1, 0, (k + 1) * TERRACE_H, 0);
  }
  // The stair runs from the top terrace to the ground, steep as the real one.
  for (let j = 0; j < 30; j++) {
    const top = TEMPLE_BASE - j * 0.12;
    box('stone', 1.4, top, 0.1, 0, top / 2, 2.45 + j * 0.1);
  }
  // Guardian pairs at each terrace: wrestlers, elephants, lions, griffins, goddesses.
  for (let k = 0; k < 5; k++) {
    const z = (9.6 - k * 1.2) / 2 + 0.2, y = (k + 1) * TERRACE_H;
    for (const side of [-1, 1]) {
      box('stone', 0.36, 0.28, 0.36, side * 0.98, y + 0.14, z);
      box('guard', 0.24, 0.5, 0.22, side * 0.98, y + 0.53, z);
      add('guard', new SphereGeometry(0.1, 12, 8), side * 0.98, y + 0.88, z);
    }
  }
  for (let k = 0; k < 5; k++) {
    const ww = 3.3 - k * 0.52, wy = TEMPLE_BASE + k * TIER_STEP;
    box('wood', ww, 0.95, ww, 0, wy + 0.475, 0);
    box('dark', 0.42, 0.6, 0.05, 0, wy + 0.32, ww / 2 + 0.01);
    for (const side of [-1, 1]) box('window', 0.22, 0.2, 0.04, side * ww * 0.3, wy + 0.58, ww / 2 + 0.01);
    const hw = ww / 2 + 0.55;
    add(k === 4 ? 'gilt' : 'tile', new ConeGeometry(hw * Math.SQRT2, 0.7, 4), 0, wy + 1.15, 0, Math.PI / 4);
    for (const sx of [-1, 1]) for (const sz of [-1, 1]) add('gilt', new SphereGeometry(0.05, 8, 6), sx * (hw - 0.08), wy + 0.72, sz * (hw - 0.08));
  }
  const topY = TEMPLE_BASE + 4 * TIER_STEP + 1.5;
  add('gilt', new CylinderGeometry(0.08, 0.1, 0.3, 12), 0, topY + 0.15, 0);
  add('gilt', new SphereGeometry(0.15, 16, 12), 0, topY + 0.42, 0);
  add('gilt', new ConeGeometry(0.12, 0.55, 12), 0, topY + 0.82, 0);

  for (const [part, list] of parts) {
    const merged = mergeGeometries(list, false);
    list.forEach((g) => g.dispose());
    if (merged) scene.add(new Mesh(merged, materials[part] as Material));
  }

  // Butter-lamp embers spiralling up around the temple.
  const emberCount = window.matchMedia('(pointer: coarse)').matches ? 160 : 320;
  const embers = new Float32Array(emberCount * 3);
  const orbit = new Float32Array(emberCount * 3);
  for (let i = 0; i < emberCount; i++) orbit.set([2 + Math.random() * 5, Math.random() * 14, Math.random() * Math.PI * 2], i * 3);
  const emberGeometry = new BufferGeometry();
  const emberPositions = new BufferAttribute(embers, 3);
  emberGeometry.setAttribute('position', emberPositions);
  const emberPoints = new Points(
    emberGeometry,
    new PointsMaterial({
      map: glowTexture('rgba(255,236,190,1)', 'rgba(255,160,70,.5)'),
      color: 0xffb35c,
      size: 0.28,
      transparent: true,
      depthWrite: false,
      blending: AdditiveBlending,
    }),
  );
  emberPoints.frustumCulled = false;
  scene.add(emberPoints);

  let fac = 1;
  return {
    scene,
    camera,
    resize(w, h) {
      frameCamera(camera, w, h, 'side');
      fac = aspectFactor(w / h);
    },
    update({ k, edge, time, px, py }: ActFrame) {
      for (let i = 0; i < emberCount; i++) {
        const r = orbit[i * 3]!, a = orbit[i * 3 + 2]! + time * 0.05;
        embers[i * 3] = Math.cos(a) * r;
        embers[i * 3 + 1] = (orbit[i * 3 + 1]! + time * 0.35) % 14;
        embers[i * 3 + 2] = Math.sin(a) * r;
      }
      emberPositions.needsUpdate = true;

      const i = Math.min(Math.floor(k), KEYS.length - 2), f = k - i;
      const a = KEYS[i]!, b = KEYS[i + 1]!;
      const enter = Math.max(-edge, 0), leave = Math.max(edge, 0);
      const angle = lerp(a[0], b[0], f) + px * 0.05 + Math.sin(time * 0.1) * 0.03 + enter * 0.8;
      const radius = lerp(a[1], b[1], f) * fac * (1 + enter * 0.5);
      // Entering from the sky: come down onto the square. Leaving for the yantra:
      // rise past the gajur and look straight up.
      camera.position.set(
        Math.sin(angle) * radius * (1 - leave * 0.8),
        lerp(a[2], b[2], f) - py * 0.2 + enter * 14 + leave * 4,
        Math.cos(angle) * radius * (1 - leave * 0.8),
      );
      camera.lookAt(0, lerp(a[3], b[3], f) + leave * 14 - enter * 2, 0);
    },
    dispose() {
      disposeScene(scene);
      (scene.background as CanvasTexture).dispose();
    },
  };
}
