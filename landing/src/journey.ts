import { clamp, smooth } from './math';
import { ACTS, VIEW_COUNT, VIEWS_PER_ACT, actOfView, type ActKey } from './story';

/**
 * The DOM half of the page: turns the scroll position into a continuous
 * `view` value and keeps captions and the progress rail in step with it.
 * It knows nothing about WebGL.
 */
export class Journey {
  readonly ok: boolean;

  private readonly main: HTMLElement;
  private readonly views: HTMLElement[];
  private readonly copies: HTMLElement[];
  private readonly rails: Map<ActKey, { root: HTMLElement; fill: HTMLElement }>;

  private top = 0;
  private step = 1;
  private lastView = Number.NaN;
  private lastAct = -1;

  constructor(doc: Document) {
    this.main = doc.querySelector<HTMLElement>('.journey')!;
    this.views = [...doc.querySelectorAll<HTMLElement>('.view')];
    this.copies = this.views.map((v) => v.querySelector<HTMLElement>('.copy')!);
    this.rails = new Map();
    for (const key of ACTS) {
      const root = doc.querySelector<HTMLElement>(`[data-rail="${key}"]`);
      const fill = root?.querySelector<HTMLElement>('b');
      if (root && fill) this.rails.set(key, { root, fill });
    }
    this.ok = Boolean(this.main) && this.views.length === VIEW_COUNT && this.copies.every(Boolean);
    this.measure();
  }

  /** Call on resize / layout change. */
  measure(): void {
    if (!this.ok) return;
    const first = this.views[0]!;
    this.top = first.getBoundingClientRect().top + window.scrollY;
    this.step = Math.max(1, first.offsetHeight);
    this.lastView = Number.NaN;
  }

  /** Current continuous view position, 0..VIEW_COUNT-1. */
  get view(): number {
    return clamp((window.scrollY - this.top) / this.step, 0, VIEW_COUNT - 1);
  }

  /** Writes caption/rail state for the current scroll position. Cheap when nothing moved. */
  update(): number {
    const view = this.view;
    if (!this.ok || Math.abs(view - this.lastView) < 1e-4) return view;
    this.lastView = view;

    this.copies.forEach((copy, i) => {
      let d = view - i;
      if (i === 0 && d < 0) d = 0;
      if (i === VIEW_COUNT - 1 && d > 0) d = 0;
      const o = 1 - smooth(0.25, 0.45, Math.abs(d));
      const visible = o > 0.01;
      copy.style.opacity = o.toFixed(3);
      copy.style.transform = visible ? `translate3d(0, ${(-d * 56).toFixed(1)}px, 0)` : '';
      copy.style.visibility = visible ? 'visible' : 'hidden';
      // Links in a fading caption must not take focus or clicks.
      copy.inert = o < 0.5;
    });

    const act = actOfView(Math.round(view));
    ACTS.forEach((key, a) => {
      const rail = this.rails.get(key);
      if (!rail) return;
      const local = clamp((view - a * VIEWS_PER_ACT) / (VIEWS_PER_ACT - 1), 0, 1);
      rail.fill.style.transform = `scaleX(${local.toFixed(3)})`;
      rail.root.classList.toggle('is-active', a === act);
    });

    if (act !== this.lastAct) {
      this.lastAct = act;
      document.documentElement.dataset.act = ACTS[act]!;
    }
    return view;
  }
}
