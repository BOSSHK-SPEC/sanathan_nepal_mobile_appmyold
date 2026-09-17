# Staff console deploy — console.yashwanthhk.com

`.github/workflows/deploy-console.yml` builds **`lib/main_admin.dart`** (never
`lib/main.dart`) with `config/admin.json`, refuses the artifact unless it is the
console, and releases it atomically:

```
/var/www/sanatan-console/                        ← owned by deploy
  releases/20260917T101500Z-0e06229/             ← one directory per build, newest 5 kept
  current -> releases/20260917T101500Z-0e06229   ← nginx root; swapped with mv -T
```

The mobile app does not go to the VPS at all — it ships as an APK/AAB through
the stores.

## One-time setup — do the steps in this order

### Step 1 — Create the web root (server, as root)

```bash
ssh root@2.25.163.51

# The folder itself must be owned by deploy, not just releases/: the workflow
# creates the `current` symlink inside it.
install -d -o deploy -g deploy -m 755 /var/www/sanatan-console /var/www/sanatan-console/releases

# Seed `current` with the site that is live today, so nginx has something to
# serve the moment it is switched over (no 404 gap before the first deploy).
cp -a /var/www/sanathan-web /var/www/sanatan-console/releases/legacy
chown -R deploy:deploy /var/www/sanatan-console
ln -sfn releases/legacy /var/www/sanatan-console/current

ls -la /var/www/sanatan-console      # current -> releases/legacy
```

### Step 2 — Switch nginx to the new root (server, as root)

From the Mac, copy the two files up:

```bash
cd "/Users/yashwanthhk/projects /Sanathan App/sanathan_nepal_mobile_appmyold"
scp deploy/console/nginx.conf       root@2.25.163.51:/tmp/console-nginx.conf
scp deploy/console/headers.conf     root@2.25.163.51:/tmp/console-headers.conf
scp deploy/console/landing-csp.conf root@2.25.163.51:/tmp/landing-csp.conf
scp deploy/console/account-csp.conf root@2.25.163.51:/tmp/account-csp.conf
```

On the server:

```bash
# Back up the existing console site (sites-enabled only holds a symlink to it).
cp /etc/nginx/sites-available/console.yashwanthhk.com /root/console-nginx.backup

cp /tmp/console-headers.conf /etc/nginx/snippets/sanatan-console-headers.conf
cp /tmp/landing-csp.conf     /etc/nginx/snippets/sanatan-landing-csp.conf
cp /tmp/account-csp.conf     /etc/nginx/snippets/sanatan-account-csp.conf
cp /tmp/console-nginx.conf   /etc/nginx/sites-available/console.yashwanthhk.com

nginx -t && systemctl reload nginx
# If nginx -t fails: cp /root/console-nginx.backup /etc/nginx/sites-available/console.yashwanthhk.com
```

`nginx -t` must say *syntax is ok / test is successful* before the reload. If
it fails, restore the backup and reload.

Check from the Mac — `cache-control` must now be `no-cache`, not `max-age=2592000`:

```bash
curl -sI https://console.yashwanthhk.com/main.dart.js | grep -i cache-control
```

Once a release containing the landing site is live (any deploy after the
`landing/` folder was added), the bare domain must be the landing page with its
CSP, and sign-in must still be the console:

```bash
curl -s  https://console.yashwanthhk.com/ | grep -c 'class="journey"'          # 1
curl -sI https://console.yashwanthhk.com/ | grep -i content-security-policy     # present
curl -sI https://console.yashwanthhk.com/sign-in | grep -i '^HTTP'              # 200
curl -s -H 'Cookie: sanatan_lang=kn' https://console.yashwanthhk.com/ | grep -o '<html[^>]*lang="kn"'   # Kannada page
curl -s https://console.yashwanthhk.com/privacy        | grep -c 'data-page="privacy"'          # 1
curl -s https://console.yashwanthhk.com/delete-account | grep -c 'data-page="delete-account"'   # 1
curl -sI https://console.yashwanthhk.com/delete-account | grep -i content-security-policy | grep -c sanatan-api   # 1
curl -sI https://console.yashwanthhk.com/welcome/kn/privacy/ | grep -i '^content-type'       # text/html, not the console
```

Re-running this step is required whenever `nginx.conf`, `headers.conf`,
`landing-csp.conf` or `account-csp.conf` change — the workflow deploys files, not nginx config. Until
it is done, `/` still shows the landing page: the console boots, sees `/` and
replaces the page with `/welcome/index.html` — just a second slower, without the
strict CSP header, and with that path in the address bar (the smoke test warns).

### Step 3 — Let the API accept requests from the console (server)

```bash
grep CORS_ORIGINS /srv/sanatan-api/shared/.env
# edit the line and append the console origin to the comma-separated list:
#   CORS_ORIGINS=<existing values>,https://console.yashwanthhk.com
nano /srv/sanatan-api/shared/.env

su - deploy -c "pm2 reload sanatan-api --update-env"
```

Check from the Mac — must print `access-control-allow-origin: https://console.yashwanthhk.com`:

```bash
curl -s -D - -o /dev/null -H "Origin: https://console.yashwanthhk.com" \
  https://sanatan-api.yashwanthhk.com/api/v1/version | grep -i allow-origin
```

### Step 4 — GitHub environment and secrets

Repo → **Settings → Environments → New environment** → name it `production`.
Optionally tick *Required reviewers* and add yourself (each deploy then waits
for your click). Add these **environment secrets**:

| Secret | How to get the value (on the Mac) |
|---|---|
| `SSH_PRIVATE_KEY` | `pbcopy < ~/.ssh/sanatan_deploy` — paste the whole block incl. BEGIN/END lines |
| `SSH_KNOWN_HOSTS` | `ssh-keyscan 2.25.163.51 \| pbcopy` |
| `SERVER_HOST` | `2.25.163.51` |
| `SERVER_USER` | `deploy` |

Then **Settings → Secrets and variables → Actions** → delete `VPS_SSH_KEY` and
`VPS_HOST` (the old root key).

Deleting the secret does not disable the key — the server still accepts it.
After the first successful deploy, remove its line from
`/root/.ssh/authorized_keys` (compare with the public half of the key you
generated for GitHub; keep the line for your own login).

### Step 5 — First deploy

Commit and push to `master` (or Actions → **deploy-console** → *Run workflow*).
Watch the run: `build` (analyze, test, build, verify) → `deploy` (upload,
release, smoke test).

```bash
curl -s https://console.yashwanthhk.com/build-info.json
# {"app":"console","sha":"<the commit you pushed>","release":"…","flutter":"3.44.9"}
```

Open the site in a normal browser window — `/` should be the 3D landing page
(`landing/`), and its "Staff sign in" button the Sanatan Console sign-in, not
the mobile app. Once that works, `releases/legacy` and the old
`/var/www/sanathan-web` can be deleted.

## Rollback

Instant (no rebuild) — point `current` at the previous release:

```bash
ssh sanatan                  # = deploy@2.25.163.51 with ~/.ssh/sanatan_deploy
cd /var/www/sanatan-console
ls -1 releases | sort -r                # newest first
ln -sfn releases/<previous> current.next && mv -Tf current.next current
```

Or re-run the workflow with `ref` = the older commit.
