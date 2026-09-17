import {
  AdditiveBlending,
  AmbientLight,
  BufferAttribute,
  BufferGeometry,
  Color,
  DirectionalLight,
  DoubleSide,
  Float32BufferAttribute,
  Group,
  LineBasicMaterial,
  LineSegments,
  Mesh,
  MeshBasicMaterial,
  MeshStandardMaterial,
  PerspectiveCamera,
  Points,
  PointsMaterial,
  RingGeometry,
  Scene,
  SphereGeometry,
  Sprite,
  SpriteMaterial,
  Vector3,
} from 'three';
import { lerp } from '../../math';
import type { Act, ActFrame, SceneCopy } from '../act';
import { aspectFactor, circlePoints, disposeScene, frameCamera, glowTexture, ribbonGeometry, textSprite } from '../helpers';

const BRASS = 0xc9a25a;

interface Graha {
  key: string;
  radius: number;
  size: number;
  color: number;
  speed: number;
  phase: number;
  mesh: Mesh;
  orbit: Mesh<BufferGeometry, MeshBasicMaterial> | null;
}

/** Views: the whole orrery, Chandra, Guru. */
const FOCUS: readonly (string | null)[] = [null, 'chandra', 'guru'];

/**
 * Act II · Navagraha Orrery. Geocentric, as jyotish sees the sky: Bhu at the
 * centre, grahas in Chaldean order, Rahu and Ketu opposite each other and
 * retrograde, and a zodiac band of 12 rashis, 27 nakshatras and 108 charanas
 * that turns one rashi per view.
 */
export function createSky(copy: SceneCopy): Act {
  const scene = new Scene();
  scene.background = new Color(0x0a1230);
  const camera = new PerspectiveCamera(40, 1, 0.05, 300);
  scene.add(new AmbientLight(0x6a78b0, 0.9));
  const key = new DirectionalLight(0xffe2b8, 2.2);
  key.position.set(5, 9, 7);
  scene.add(key);

  const flatRing = (radius: number, width: number, opacity: number, segments = 180): Mesh<BufferGeometry, MeshBasicMaterial> => {
    const m = new Mesh(
      ribbonGeometry(circlePoints(radius, segments), width, true),
      new MeshBasicMaterial({ color: BRASS, transparent: true, opacity, side: DoubleSide, depthWrite: false }),
    );
    m.rotation.x = -Math.PI / 2;
    return m;
  };

  scene.add(new Mesh(new SphereGeometry(0.36, 32, 20), new MeshStandardMaterial({ color: 0x22346e, roughness: 0.7, metalness: 0.1 })));
  const cage = new Mesh(new SphereGeometry(0.47, 18, 10), new MeshBasicMaterial({ color: BRASS, wireframe: true, transparent: true, opacity: 0.35 }));
  scene.add(cage);

  const spec: Omit<Graha, 'mesh' | 'orbit'>[] = [
    { key: 'chandra', radius: 1.3, size: 0.15, color: 0xdde3f0, speed: 0.5, phase: 0.4 },
    { key: 'budha', radius: 1.8, size: 0.12, color: 0x86b98f, speed: 0.34, phase: 2.1 },
    { key: 'shukra', radius: 2.3, size: 0.17, color: 0xf2e6d0, speed: 0.27, phase: 3.3 },
    { key: 'surya', radius: 2.85, size: 0.3, color: 0xf08a24, speed: 0.2, phase: 5.2 },
    { key: 'mangal', radius: 3.4, size: 0.15, color: 0xc2412d, speed: 0.15, phase: 1.2 },
    { key: 'guru', radius: 3.95, size: 0.26, color: 0xe3b64f, speed: 0.1, phase: 4.1 },
    { key: 'shani', radius: 4.5, size: 0.22, color: 0x7d8fc4, speed: 0.07, phase: 0.9 },
    { key: 'rahu', radius: 5.0, size: 0.11, color: 0x3a3560, speed: -0.05, phase: 2.6 },
    { key: 'ketu', radius: 5.0, size: 0.11, color: 0x3a3560, speed: -0.05, phase: 2.6 + Math.PI },
  ];
  const grahas: Graha[] = spec.map((g) => {
    const material =
      g.key === 'surya' ? new MeshBasicMaterial({ color: g.color }) : new MeshStandardMaterial({ color: g.color, roughness: 0.55, metalness: 0.15 });
    const mesh = new Mesh(new SphereGeometry(g.size, 32, 20), material);
    scene.add(mesh);
    const orbit = g.key === 'ketu' ? null : flatRing(g.radius, 0.012, 0.24);
    if (orbit) scene.add(orbit);
    if (g.key === 'surya') {
      const glow = new Sprite(
        new SpriteMaterial({ map: glowTexture('rgba(255,220,160,1)', 'rgba(240,138,36,.45)'), blending: AdditiveBlending, depthWrite: false, transparent: true }),
      );
      glow.scale.set(1.7, 1.7, 1);
      mesh.add(glow);
    }
    if (g.key === 'shani') {
      const ring = new Mesh(
        new RingGeometry(g.size * 1.35, g.size * 1.9, 64),
        new MeshBasicMaterial({ color: BRASS, side: DoubleSide, transparent: true, opacity: 0.6 }),
      );
      ring.rotation.x = -Math.PI / 2 + 0.45;
      mesh.add(ring);
    }
    if (g.key === 'rahu' || g.key === 'ketu') mesh.add(flatRing(g.size * 1.7, 0.02, 0.9, 48));
    return { ...g, mesh, orbit };
  });
  const byKey = new Map(grahas.map((g) => [g.key, g]));

  const zodiac = new Group();
  scene.add(zodiac);
  zodiac.add(flatRing(5.6, 0.02, 0.8, 220), flatRing(6.5, 0.02, 0.8, 220));
  const ticks: number[] = [];
  for (let i = 0; i < 108; i++) {
    const a = (i / 108) * Math.PI * 2;
    const len = i % 9 === 0 ? 0.9 : i % 4 === 0 ? 0.26 : 0.12; // rashi · nakshatra · charana
    ticks.push(Math.cos(a) * 5.6, 0, Math.sin(a) * 5.6, Math.cos(a) * (5.6 + len), 0, Math.sin(a) * (5.6 + len));
  }
  const tickGeometry = new BufferGeometry();
  tickGeometry.setAttribute('position', new Float32BufferAttribute(ticks, 3));
  zodiac.add(new LineSegments(tickGeometry, new LineBasicMaterial({ color: BRASS, transparent: true, opacity: 0.7 })));
  const rashiLabels = copy.rashis.map((name, i) => {
    const a = ((i + 0.5) / 12) * Math.PI * 2;
    const label = textSprite(name, '#D4AE66');
    label.sprite.position.set(Math.cos(a) * 6.08, 0.05, Math.sin(a) * 6.08);
    zodiac.add(label.sprite);
    return label;
  });

  const starCount = 1400;
  const stars = new Float32Array(starCount * 3);
  for (let i = 0; i < starCount; i++) {
    const u = Math.random() * 2 - 1, th = Math.random() * Math.PI * 2, r = 60 + Math.random() * 30, q = Math.sqrt(1 - u * u);
    stars.set([q * Math.cos(th) * r, u * r, q * Math.sin(th) * r], i * 3);
  }
  const starGeometry = new BufferGeometry();
  starGeometry.setAttribute('position', new BufferAttribute(stars, 3));
  const starField = new Points(starGeometry, new PointsMaterial({ color: 0xc8d0f0, size: 0.25, transparent: true, opacity: 0.75, depthWrite: false }));
  scene.add(starField);

  let fac = 1;
  const p0 = { pos: new Vector3(), look: new Vector3() };
  const p1 = { pos: new Vector3(), look: new Vector3() };
  const look = new Vector3();

  function pose(view: number, out: typeof p0): void {
    const focus = FOCUS[view];
    const g = focus ? byKey.get(focus) : undefined;
    if (!g) {
      out.pos.set(0, 7.4 * fac, 10.8 * fac);
      out.look.set(0, -0.3, 0);
      return;
    }
    const gp = g.mesh.position;
    const len = Math.hypot(gp.x, gp.z) || 1, dx = gp.x / len, dz = gp.z / len;
    const d = (1.0 + g.size * 4.2) * fac;
    out.pos.set(gp.x + dx * d - dz * 0.55 * fac, (0.55 + g.size * 2) * fac, gp.z + dz * d + dx * 0.55 * fac);
    out.look.set(gp.x * 0.45, 0, gp.z * 0.45);
  }

  return {
    scene,
    camera,
    resize(w, h) {
      frameCamera(camera, w, h, 'side');
      fac = aspectFactor(w / h);
    },
    update({ k, edge, time, ambient, px, py }: ActFrame) {
      for (const g of grahas) {
        const a = g.phase + g.speed * (time * 0.35 + k * 1.6);
        g.mesh.position.set(Math.cos(a) * g.radius, 0, Math.sin(a) * g.radius);
        g.mesh.rotation.y = time * 0.2;
      }
      zodiac.rotation.y = (-k * Math.PI) / 6 + time * 0.004;
      cage.rotation.y = time * 0.05;
      starField.rotation.y = time * 0.003;

      const i = Math.min(Math.floor(k), FOCUS.length - 2), f = k - i;
      pose(i, p0);
      pose(i + 1, p1);
      camera.position.lerpVectors(p0.pos, p1.pos, f);
      look.lerpVectors(p0.look, p1.look, f);

      // Entering from the river: descend out of the risen lamps. Leaving for the
      // temple: dive toward the horizon.
      const enter = Math.max(-edge, 0), leave = Math.max(edge, 0);
      camera.position.y += Math.sin(Math.PI * f) * 1.4 * fac + enter * 9 - leave * 5 - py * 0.15;
      camera.position.x += px * 0.25;
      camera.position.multiplyScalar(1 + enter * 0.6);
      look.y -= leave * 4;
      camera.lookAt(look);

      const current = FOCUS[Math.round(k)];
      for (const g of grahas) {
        if (!g.orbit) continue;
        const target = g.key === current ? 0.8 : 0.22;
        g.orbit.material.opacity = lerp(g.orbit.material.opacity, target, ambient ? 0.08 : 1);
      }
    },
    setCopy(next) {
      next.rashis.forEach((name, i) => rashiLabels[i]?.setText(name));
    },
    dispose() {
      disposeScene(scene);
    },
  };
}
