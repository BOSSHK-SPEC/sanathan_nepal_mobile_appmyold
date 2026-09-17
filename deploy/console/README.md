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
scp deploy/console/nginx.conf   root@2.25.163.51:/tmp/console-nginx.conf
scp deploy/console/headers.conf root@2.25.163.51:/tmp/console-headers.conf
```

On the server:

```bash
# Find the config that serves the console today, and back it up.
grep -rl "console.yashwanthhk.com" /etc/nginx/sites-enabled /etc/nginx/conf.d
cp <that file> /root/console-nginx.backup

# Confirm the certificate paths used in nginx.conf exist.
ls /etc/letsencrypt/live/console.yashwanthhk.com/ /etc/letsencrypt/options-ssl-nginx.conf

cp /tmp/console-headers.conf /etc/nginx/snippets/sanatan-console-headers.conf
cp /tmp/console-nginx.conf   /etc/nginx/sites-available/console.yashwanthhk.com
# If the old file (from grep) is a DIFFERENT file, remove it from sites-enabled
# so two blocks don't claim the same server_name:
#   rm /etc/nginx/sites-enabled/<old file>
ln -sfn /etc/nginx/sites-available/console.yashwanthhk.com /etc/nginx/sites-enabled/

nginx -t && systemctl reload nginx
```

`nginx -t` must say *syntax is ok / test is successful* before the reload. If
it fails, restore the backup and reload.

Check from the Mac — `cache-control` must now be `no-cache`, not `max-age=2592000`:

```bash
curl -sI https://console.yashwanthhk.com/main.dart.js | grep -i cache-control
```

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

### Step 5 — First deploy

Commit and push to `master` (or Actions → **deploy-console** → *Run workflow*).
Watch the run: `build` (analyze, test, build, verify) → `deploy` (upload,
release, smoke test).

```bash
curl -s https://console.yashwanthhk.com/build-info.json
# {"app":"console","sha":"<the commit you pushed>","release":"…","flutter":"3.44.9"}
```

Open the site in a normal browser window — it should be the Sanatan Console
login, not the mobile app. Once that works, `releases/legacy` and the old
`/var/www/sanathan-web` can be deleted.

## Rollback

Instant (no rebuild) — point `current` at the previous release:

```bash
ssh deploy@2.25.163.51
cd /var/www/sanatan-console
ls -1 releases | sort -r                # newest first
ln -sfn releases/<previous> current.next && mv -Tf current.next current
```

Or re-run the workflow with `ref` = the older commit.
