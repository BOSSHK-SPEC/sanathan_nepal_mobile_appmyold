export const clamp = (x: number, lo: number, hi: number): number => Math.min(hi, Math.max(lo, x));

export const lerp = (a: number, b: number, t: number): number => a + (b - a) * t;

/** Hermite smoothstep of `x` between `edge0` and `edge1`. */
export const smooth = (edge0: number, edge1: number, x: number): number => {
  const t = clamp((x - edge0) / (edge1 - edge0), 0, 1);
  return t * t * (3 - 2 * t);
};
