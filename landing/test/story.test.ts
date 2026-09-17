import { describe, expect, it } from 'vitest';
import { ACTS, VIEWS_PER_ACT, VIEW_COUNT, actOfView, beatAt } from '../src/story';

describe('beatAt', () => {
  it('holds the camera still for the first and last 20% of every view', () => {
    for (let view = 0; view < VIEW_COUNT - 1; view++) {
      expect(beatAt(view + 0.1, false)).toEqual({ from: view, ease: 0 });
      expect(beatAt(view + 0.9, false).ease).toBe(1);
    }
  });

  it('never moves backwards as the reader scrolls forwards', () => {
    let last = -1;
    for (let v = 0; v <= VIEW_COUNT - 1; v += 0.01) {
      const { from, ease } = beatAt(v, false);
      const position = from + ease;
      expect(position).toBeGreaterThanOrEqual(last - 1e-9);
      last = position;
    }
  });

  it('clamps outside the journey', () => {
    expect(beatAt(-3, false)).toEqual({ from: 0, ease: 0 });
    expect(beatAt(VIEW_COUNT + 5, false)).toEqual({ from: VIEW_COUNT - 2, ease: 1 });
  });

  it('under reduced motion, cuts instead of flying', () => {
    expect(beatAt(3.4, true).ease).toBe(0);
    expect(beatAt(3.6, true).ease).toBe(1);
  });
});

describe('acts', () => {
  it('are four, of three views each', () => {
    expect(ACTS).toEqual(['river', 'sky', 'temple', 'yantra']);
    expect(VIEW_COUNT).toBe(ACTS.length * VIEWS_PER_ACT);
  });

  it('map every view to its act', () => {
    expect([...Array(VIEW_COUNT).keys()].map(actOfView)).toEqual([0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3]);
  });
});
