import type { PerspectiveCamera, Scene } from 'three';
import type { Messages } from '../i18n/types';

/** The words drawn inside the 3D scene, in the page's language. */
export type SceneCopy = Messages['scene'];

export interface ActFrame {
  /** Position inside the act: 0..2, eased (holds on whole numbers). */
  k: number;
  /**
   * Hand-off with the neighbouring act: -1..0 while this act is dissolving in,
   * 0..1 while it dissolves out, 0 otherwise.
   */
  edge: number;
  /** Seconds. Frozen at 0 under reduced motion. */
  time: number;
  /** 1 normally, 0 under reduced motion: scales every ambient movement. */
  ambient: number;
  /** Eased pointer, -1..1. */
  px: number;
  py: number;
}

export interface Act {
  readonly scene: Scene;
  readonly camera: PerspectiveCamera;
  resize(width: number, height: number, pixelRatio: number): void;
  update(frame: ActFrame): void;
  /** Redraws any text in the scene for a new language. */
  setCopy?(copy: SceneCopy): void;
  dispose(): void;
}
