import { fileURLToPath } from 'node:url';
import { parseHTML } from 'linkedom';
import { type Plugin, defineConfig } from 'vite';
import { DEFAULT_LOCALE, LOCALES, PAGES, type Page } from './src/i18n/locales';
import { MESSAGES } from './src/i18n/messages';
import { applyPage } from './src/i18n/page';

/** Template file of each page, relative to this folder. */
const TEMPLATES: Record<Page, string> = {
  home: 'index.html',
  privacy: 'privacy/index.html',
  'delete-account': 'delete-account/index.html',
};

/**
 * Renders every built page once per locale: `/welcome/<code>/…` for every
 * language, and the unprefixed `/welcome/…` in the default one. Each page
 * arrives already in its language — no flash of English — and the same
 * applyPage() then switches languages in place in the browser.
 */
function localizedPages(): Plugin {
  return {
    name: 'sanatan:localized-pages',
    apply: 'build',
    enforce: 'post',
    generateBundle(_options, bundle) {
      for (const page of PAGES) {
        const file = TEMPLATES[page];
        const asset = bundle[file];
        if (!asset || asset.type !== 'asset') this.error(`${file} missing from the bundle`);
        const template = String(asset.source);

        for (const locale of LOCALES) {
          const { document } = parseHTML(template);
          applyPage(document as unknown as Document, locale, MESSAGES[locale.code], { initial: true });
          const html = `<!doctype html>\n${document.documentElement.outerHTML}\n`;
          if (locale.code === DEFAULT_LOCALE) asset.source = html;
          this.emitFile({ type: 'asset', fileName: `${locale.code}/${file}`, source: html });
        }
      }
    },
  };
}

/** Dev server: `/welcome/kn/privacy/` serves the privacy template; the page switches itself to Kannada. */
function localizedDevRoutes(): Plugin {
  const codes = LOCALES.map((l) => l.code).join('|');
  const pattern = new RegExp(`^/welcome/(?:${codes})/((?:privacy|delete-account)/)?(index\\.html)?(?=$|\\?)`);
  return {
    name: 'sanatan:localized-dev-routes',
    apply: 'serve',
    configureServer(server) {
      server.middlewares.use((req, _res, next) => {
        if (req.url) req.url = req.url.replace(pattern, (_m, page = '') => `/welcome/${page}`);
        next();
      });
    },
  };
}

// Built into the Flutter project's web/welcome/, so `flutter run` and
// `flutter build web` serve and ship it with the console at /welcome/. The
// console hands `/`, `/privacy` and `/delete-account` to it
// (lib/admin/platform/landing_site.dart); in production nginx serves them
// directly (deploy/console/nginx.conf).
export default defineConfig({
  base: '/welcome/',
  plugins: [localizedPages(), localizedDevRoutes()],
  build: {
    target: 'es2022',
    outDir: '../web/welcome',
    emptyOutDir: true,
    assetsInlineLimit: 0, // fonts and textures stay files, so the CSP needs no data: fonts
    modulePreload: { polyfill: false }, // no inline scripts: keeps script-src 'self'
    sourcemap: false,
    reportCompressedSize: true,
    // three.js lands in its own lazily-imported chunk (~150 KB gzip); that is expected.
    chunkSizeWarningLimit: 700,
    rolldownOptions: {
      input: Object.fromEntries(PAGES.map((page) => [page, fileURLToPath(new URL(TEMPLATES[page], import.meta.url))])),
    },
  },
});
