/**
 * The journey's shape: four acts of three views each. The DOM (index.html)
 * and the WebGL acts both read from here, and `main.ts` refuses to start the
 * scene if the markup disagrees.
 */
export const ACTS = ['river', 'sky', 'temple', 'yantra'] as const;
export type ActKey = (typeof ACTS)[number];

export const VIEWS_PER_ACT = 3;
export const VIEW_COUNT = ACTS.length * VIEWS_PER_ACT;

export const actOfView = (view: number): number => Math.floor(view / VIEWS_PER_ACT);

/**
 * Scroll position → where the camera is. `view` is continuous (0..VIEW_COUNT-1).
 * The camera holds for the first and last 20% of every view and moves in the
 * middle 60%, so a caption is never read over a moving scene.
 */
export interface Beat {
  /** Index of the view the transition starts from. */
  from: number;
  /** 0..1 eased progress towards `from + 1`. */
  ease: number;
}

export const beatAt = (view: number, reducedMotion: boolean): Beat => {
  const v = Math.min(Math.max(view, 0), VIEW_COUNT - 1);
  const from = Math.min(Math.floor(v), VIEW_COUNT - 2);
  const f = v - from;
  // Reduced motion: no flight, a short cut between held poses.
  const a = reducedMotion ? 0.46 : 0.2;
  const t = Math.min(Math.max((f - a) / (1 - 2 * a), 0), 1);
  return { from, ease: t * t * (3 - 2 * t) };
};
