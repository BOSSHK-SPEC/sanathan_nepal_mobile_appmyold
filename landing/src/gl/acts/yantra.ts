import {
  AdditiveBlending,
  BufferAttribute,
  BufferGeometry,
  Color,
  DoubleSide,
  Group,
  type Material,
  Mesh,
  MeshBasicMaterial,
  type Object3D,
  PerspectiveCamera,
  Points,
  PointsMaterial,
  Scene,
  Shape,
  ShapeGeometry,
  Sprite,
  SpriteMaterial,
  Vector3,
} from 'three';
import { lerp, smooth } from '../../math';
import type { Act, ActFrame } from '../act';
import { type Point2, aspectFactor, circlePoints, disposeScene, frameCamera, glowTexture, ribbonGeometry } from '../helpers';

const GOLD = 0xe8b04b;
const GOLD_LIGHT = 0xf0c170;
const SINDOOR = 0xc8352a;

/** Per view: the plane the camera frames and how far in front of it it sits. */
const FOCAL_Z = [0, -10, -32] as const;
const DISTANCE = [4.9, 3.4, 1.8] as const;

interface Layer {
  object: Object3D;
  z: number;
  spin: number;
  materials: { material: Material; base: number }[];
}

/**
 * Act IV · Yantra Descent. The Sri Yantra opens flat and complete; its layers
 * separate in depth and the camera flies through them — bhupura, three
 * circles, sixteen and eight petals, nine interlocking triangles — to the
 * bindu, which is where the staff console lives.
 */
export function createYantra(): Act {
  const scene = new Scene();
  scene.background = new Color(0x14060a);
  const camera = new PerspectiveCamera(45, 1, 0.05, 200);
  const layers: Layer[] = [];

  const line = (color = GOLD): MeshBasicMaterial =>
    new MeshBasicMaterial({ color, transparent: true, side: DoubleSide, depthWrite: false });
  const fill = (opacity: number): MeshBasicMaterial =>
    new MeshBasicMaterial({ color: SINDOOR, transparent: true, opacity, side: DoubleSide, depthWrite: false });

  function addLayer(object: Object3D, z: number, spin: number): void {
    const materials: Layer['materials'] = [];
    const seen = new Set<Material>();
    object.traverse((o) => {
      const m = (o as Mesh | Sprite).material as Material | undefined;
      if (m && !seen.has(m)) {
        seen.add(m);
        materials.push({ material: m, base: m.opacity });
      }
    });
    scene.add(object);
    layers.push({ object, z, spin, materials });
  }

  // Bhupura: three nested squares, each with four T-shaped gates.
  const gates = new Group();
  const gateMaterial = line();
  for (const inset of [0, 0.07, 0.14]) gates.add(new Mesh(ribbonGeometry(bhupura(1.62 - inset, 0.26 - inset), 0.018, true), gateMaterial));
  addLayer(gates, 0, 0);

  const circles = new Group();
  const circleMaterial = line();
  for (const r of [1.34, 1.28, 1.22]) circles.add(new Mesh(ribbonGeometry(circlePoints(r, 160), 0.013, true), circleMaterial));
  addLayer(circles, -5, 0.02);

  addLayer(lotus(16, 0.9, 1.17), -10, -0.03);
  addLayer(lotus(8, 0.66, 0.9), -15, 0.04);

  // Nine interlocking triangles, outer to inner — five downward (Shakti), four upward (Shiva).
  const triangles: readonly (readonly [baseY: number, apexY: number, halfWidth: number, up: boolean])[] = [
    [0.58, -1, 0.81, false], [-0.58, 1, 0.81, true], [0.4, -0.8, 0.7, false], [-0.44, 0.76, 0.68, true],
    [0.22, -0.58, 0.56, false], [-0.28, 0.52, 0.52, true], [0.08, -0.38, 0.4, false], [-0.16, 0.3, 0.36, true],
    [0.1, -0.14, 0.16, false],
  ];
  triangles.forEach(([base, apex, hw, up], i) => {
    const s = 0.64;
    const pts: Point2[] = [[-hw * s, base * s], [hw * s, base * s], [0, apex * s]];
    const group = new Group();
    group.add(new Mesh(ribbonGeometry(pts, 0.012, true), line(up ? GOLD : GOLD_LIGHT)));
    group.add(new Mesh(new ShapeGeometry(shape(pts)), fill(up ? 0.05 : 0.1)));
    addLayer(group, -19 - i * 1.25, (i % 2 ? 1 : -1) * 0.03);
  });

  const bindu = new Sprite(
    new SpriteMaterial({ map: glowTexture('rgba(255,248,226,1)', 'rgba(232,176,75,.6)'), blending: AdditiveBlending, depthWrite: false, transparent: true }),
  );
  bindu.scale.set(0.16, 0.16, 1);
  const binduLayer = new Group();
  binduLayer.add(bindu);
  addLayer(binduLayer, -32, 0);

  const dustCount = window.matchMedia('(pointer: coarse)').matches ? 400 : 900;
  const dust = new Float32Array(dustCount * 3);
  for (let i = 0; i < dustCount; i++) dust.set([(Math.random() - 0.5) * 5, (Math.random() - 0.5) * 5, 5 - Math.random() * 40], i * 3);
  const dustGeometry = new BufferGeometry();
  dustGeometry.setAttribute('position', new BufferAttribute(dust, 3));
  const dustPoints = new Points(
    dustGeometry,
    new PointsMaterial({ color: GOLD, size: 0.022, transparent: true, opacity: 0.55, depthWrite: false, blending: AdditiveBlending }),
  );
  scene.add(dustPoints);

  let fac = 1;
  const look = new Vector3();
  return {
    scene,
    camera,
    resize(w, h) {
      frameCamera(camera, w, h, 'side');
      fac = aspectFactor(w / h);
    },
    update({ k, edge, time, px, py }: ActFrame) {
      const i = Math.min(Math.floor(k), 1), f = k - i;
      const enter = Math.max(-edge, 0);
      // The bindu is a point: the portrait pull-back would park the camera among the triangles.
      const stand = (view: number): number => FOCAL_Z[view]! + DISTANCE[view]! * (view === FOCAL_Z.length - 1 ? 1 : fac);
      let camZ = lerp(stand(i), stand(i + 1), f);
      camZ += enter * 10; // arrives from far above the temple, the yantra growing into view

      // Flat and complete at rest; layers separate as the descent begins.
      const separation = smooth(0, 0.7, k);
      for (const layer of layers) {
        const z = layer.z * separation;
        layer.object.position.z = z;
        // Rotation only while the layers are apart: at rest the yantra is exact,
        // however long the page has been open.
        layer.object.rotation.z = layer.spin * separation * (k * 8 + Math.sin(time * 0.2) * 3) + enter * layer.spin * 20;
        const d = camZ - z;
        const opacity = smooth(0.15, 1.2, d) * (1 - 0.75 * smooth(10, 30, d));
        for (const { material, base } of layer.materials) material.opacity = base * opacity;
        layer.object.visible = opacity > 0.003;
      }
      // The bindu blooms behind the final caption — held back so the button stays legible.
      const bloom = 1 + smooth(1.4, 2, k) * 7;
      bindu.scale.set(0.16 * bloom, 0.16 * bloom, 1);
      dustPoints.rotation.z = time * 0.01;

      camera.position.set(px * 0.08, -py * 0.08, camZ);
      look.set(camera.position.x * 0.3, camera.position.y * 0.3, camZ - 10);
      camera.lookAt(look);
      camera.rotateZ(k * 0.08 - enter * 0.5);
    },
    dispose() {
      disposeScene(scene);
    },
  };

  function lotus(count: number, inner: number, outer: number): Group {
    const group = new Group();
    const stroke = line();
    const petalFill = fill(0.16);
    const half = (Math.PI / count) * 0.98;
    group.add(new Mesh(ribbonGeometry(circlePoints(inner, 128), 0.012, true), stroke));
    for (let i = 0; i < count; i++) {
      const th = (i / count) * Math.PI * 2 + Math.PI / 2;
      const mid = inner + (outer - inner) * 0.72;
      const pts: Point2[] = [];
      quadratic(polar(inner, th - half), polar(mid, th - half * 0.95), polar(outer, th), 10, pts);
      const right: Point2[] = [];
      quadratic(polar(outer, th), polar(mid, th + half * 0.95), polar(inner, th + half), 10, right);
      pts.push(...right.slice(1));
      group.add(new Mesh(ribbonGeometry(pts, 0.011, false), stroke));
      group.add(new Mesh(new ShapeGeometry(shape(pts)), petalFill));
    }
    return group;
  }
}

function bhupura(s: number, gate: number): Point2[] {
  const h = 0.12, e = 0.1, k = 0.12;
  const side: Point2[] = [
    [-s, s], [-gate, s], [-gate, s + h], [-gate - e, s + h], [-gate - e, s + h + k],
    [gate + e, s + h + k], [gate + e, s + h], [gate, s + h], [gate, s],
  ];
  const pts: Point2[] = [];
  for (let r = 0; r < 4; r++) {
    for (const [x, y] of side) {
      let X = x, Y = y;
      for (let j = 0; j < r; j++) [X, Y] = [Y, -X]; // quarter turn clockwise
      pts.push([X, Y]);
    }
  }
  return pts;
}

const polar = (r: number, a: number): Point2 => [Math.cos(a) * r, Math.sin(a) * r];

function quadratic(p0: Point2, c: Point2, p1: Point2, steps: number, out: Point2[]): void {
  for (let i = 0; i <= steps; i++) {
    const t = i / steps, u = 1 - t;
    out.push([u * u * p0[0] + 2 * u * t * c[0] + t * t * p1[0], u * u * p0[1] + 2 * u * t * c[1] + t * t * p1[1]]);
  }
}

function shape(pts: readonly Point2[]): Shape {
  const s = new Shape();
  s.moveTo(pts[0]![0], pts[0]![1]);
  for (let i = 1; i < pts.length; i++) s.lineTo(pts[i]![0], pts[i]![1]);
  return s;
}
