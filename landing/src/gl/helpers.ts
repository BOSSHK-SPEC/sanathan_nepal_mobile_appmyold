import {
  BufferAttribute,
  BufferGeometry,
  CanvasTexture,
  type PerspectiveCamera,
  SRGBColorSpace,
  Sprite,
  SpriteMaterial,
} from 'three';
import { canvasFontStack, loadFontsFor } from '../fonts';

export type Point2 = readonly [number, number];

export function circlePoints(radius: number, segments: number): Point2[] {
  const pts: Point2[] = [];
  for (let i = 0; i < segments; i++) {
    const a = (i / segments) * Math.PI * 2;
    pts.push([Math.cos(a) * radius, Math.sin(a) * radius]);
  }
  return pts;
}

/** A flat, thick polyline in the XY plane with mitred joints (GL lines are 1px everywhere). */
export function ribbonGeometry(pts: readonly Point2[], width: number, closed: boolean): BufferGeometry {
  const n = pts.length;
  const pos = new Float32Array(n * 6);
  const index: number[] = [];
  for (let i = 0; i < n; i++) {
    const p = pts[i]!;
    const prev = closed ? pts[(i - 1 + n) % n]! : pts[Math.max(i - 1, 0)]!;
    const next = closed ? pts[(i + 1) % n]! : pts[Math.min(i + 1, n - 1)]!;
    let d1x = p[0] - prev[0], d1y = p[1] - prev[1], d2x = next[0] - p[0], d2y = next[1] - p[1];
    let l1 = Math.hypot(d1x, d1y), l2 = Math.hypot(d2x, d2y);
    if (l1 < 1e-9) { d1x = d2x; d1y = d2y; l1 = l2; }
    if (l2 < 1e-9) { d2x = d1x; d2y = d1y; l2 = l1; }
    d1x /= l1; d1y /= l1; d2x /= l2; d2y /= l2;
    let tx = d1x + d2x, ty = d1y + d2y;
    const tl = Math.hypot(tx, ty);
    if (tl < 1e-6) { tx = d2x; ty = d2y; } else { tx /= tl; ty /= tl; }
    const nx = -ty, ny = tx;
    const miter = width / 2 / Math.max(Math.abs(nx * -d1y + ny * d1x), 0.35);
    pos.set([p[0] + nx * miter, p[1] + ny * miter, 0, p[0] - nx * miter, p[1] - ny * miter, 0], i * 6);
  }
  const segments = closed ? n : n - 1;
  for (let i = 0; i < segments; i++) {
    const a = i * 2, b = ((i + 1) % n) * 2;
    index.push(a, a + 1, b, a + 1, b + 1, b);
  }
  const geometry = new BufferGeometry();
  geometry.setAttribute('position', new BufferAttribute(pos, 3));
  geometry.setIndex(index);
  return geometry;
}

export function glowTexture(inner: string, mid: string): CanvasTexture {
  const c = document.createElement('canvas');
  c.width = c.height = 128;
  const g = c.getContext('2d')!;
  const grad = g.createRadialGradient(64, 64, 0, 64, 64, 64);
  grad.addColorStop(0, inner);
  grad.addColorStop(0.25, mid);
  grad.addColorStop(1, 'rgba(0,0,0,0)');
  g.fillStyle = grad;
  g.fillRect(0, 0, 128, 128);
  const tex = new CanvasTexture(c);
  tex.colorSpace = SRGBColorSpace;
  return tex;
}

/** A text label in the scene. `setText` redraws it once the face for that text has loaded. */
export function textSprite(text: string, color: string): { sprite: Sprite; setText(next: string): void } {
  const c = document.createElement('canvas');
  c.width = 256;
  c.height = 128;
  const g = c.getContext('2d')!;
  const tex = new CanvasTexture(c);
  tex.colorSpace = SRGBColorSpace;
  let current = text;
  const draw = (): void => {
    g.clearRect(0, 0, 256, 128);
    let size = 58;
    const stack = canvasFontStack();
    g.font = `${size}px ${stack}`;
    const width = g.measureText(current).width;
    if (width > 236) {
      size = Math.floor((size * 236) / width); // long names (Malayalam, Tamil) shrink to fit
      g.font = `${size}px ${stack}`;
    }
    g.fillStyle = color;
    g.textAlign = 'center';
    g.textBaseline = 'middle';
    g.fillText(current, 128, 70);
    tex.needsUpdate = true;
  };
  const setText = (next: string): void => {
    current = next;
    void loadFontsFor(next, undefined, ['display']).then(() => {
      if (current === next) draw();
    });
  };
  draw();
  setText(text);
  const sprite = new Sprite(new SpriteMaterial({ map: tex, transparent: true, depthWrite: false }));
  sprite.scale.set(0.84, 0.42, 1);
  return { sprite, setText };
}

/**
 * Pushes the subject away from the captions (bottom-left): right on wide
 * screens, up on tall ones.
 */
export function frameCamera(camera: PerspectiveCamera, width: number, height: number, mode: 'side' | 'up'): void {
  camera.aspect = width / height;
  if (mode === 'side' && width / height > 1.15) camera.setViewOffset(width, height, -width * 0.13, 0, width, height);
  else camera.setViewOffset(width, height, 0, height * (width / height < 0.8 ? 0.2 : 0.12), width, height);
  camera.updateProjectionMatrix();
}

/** Pulls the camera back on portrait screens so the subject still fits. */
export const aspectFactor = (aspect: number): number => Math.max(1, Math.pow(0.95 / aspect, 0.9));

export function disposeScene(root: { traverse(cb: (o: unknown) => void): void }): void {
  root.traverse((o) => {
    const obj = o as { geometry?: { dispose(): void }; material?: { dispose(): void; map?: { dispose(): void } | null } };
    obj.geometry?.dispose();
    obj.material?.map?.dispose();
    obj.material?.dispose();
  });
}

/** Screen-filling vertical gradient for `scene.background`. */
export function verticalGradient(stops: readonly string[]): CanvasTexture {
  const c = document.createElement('canvas');
  c.width = 4;
  c.height = 256;
  const g = c.getContext('2d')!;
  const grad = g.createLinearGradient(0, 0, 0, 256);
  stops.forEach((s, i) => grad.addColorStop(i / (stops.length - 1), s));
  g.fillStyle = grad;
  g.fillRect(0, 0, 4, 256);
  const tex = new CanvasTexture(c);
  tex.colorSpace = SRGBColorSpace;
  return tex;
}
