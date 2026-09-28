# Workflow

Actual, completed procedure, broken into phases matching the task's steps.
Real mistakes are included and explained, not cleaned up, since they're part
of the genuine learning record.

---

## Phase 1 - User Creation

**Run as:** `governor` (sudo)

```bash
sudo useradd -m -s /bin/bash student01
sudo passwd student01
su - student01
whoami
```

`-G sudo` was deliberately **not** included at this point, since nothing in
the task appeared to need root access from inside `student01`'s shell. This
decision was revisited later (see Phase 6).

**Verification:** `whoami` → `student01`.

**Evidence:** `evidence/screenshots/01-user-created-and-switched.png`

---

## Phase 2 - Directory & File Management

**Run as:** `student01`

Built the structure in two explicit steps rather than one combined
`mkdir -p`, to keep each action separately verifiable:

```bash
mkdir ~/project
ls -la ~
mkdir ~/project/docs ~/project/scripts ~/project/bin
ls -la ~/project
```

```bash
cd ~/project/docs
echo "This is the initial report by student01." > report.txt
ls -la
echo "Top Secret." > .secret.txt
cat .secret.txt
```

`echo "text" > file` creates a file **with content** in a single step -
different from `touch`, which only creates an empty file.

**Evidence:** `evidence/screenshots/02-project-structure-created.png`

---

## Phase 3 - Edit and Move Files

**Run as:** `student01`

### Real mistake: wrong file opened in `nano`

```bash
nano ~/report.txt
```

This opened `/home/student01/report.txt` (a different, new file) instead of
the intended `~/project/docs/report.txt`, because `~/` always resolves to
the home directory regardless of the current working directory. Confirmed
via `cat report.txt` immediately after, which still showed only the
original single line.

### Correct edit

```bash
nano report.txt          # run while inside ~/project/docs
cat report.txt
```

Result: both lines present, correct file.

### Cleanup of the stray file

```bash
ls -la ~
rm ~/report.txt
```

Confirmed the stray file's removal and that the real `docs/report.txt` was
untouched.

**Evidence:** `evidence/screenshots/03-nano-append-mistake-and-fix.png`,
`evidence/screenshots/04-stray-file-cleanup.png`

### Copy, then move+rename

```bash
cp report.txt ~/project/scripts/
ls -la ~/project/scripts
cat ~/project/scripts/report.txt
```

`cp` leaves the original in place - confirmed deliberately in anticipation
of the contrast with `mv` below.

```bash
mv .secret.txt ~/project/bin/classified.txt
ls -la ~/project/docs      # .secret.txt is gone - mv removes the source
ls -la ~/project/bin       # classified.txt now present
cat ~/project/bin/classified.txt
```

`mv` moves **and** renames in a single command.

**Evidence:** `evidence/screenshots/05-copy-report-to-scripts.png`,
`evidence/screenshots/06-move-rename-classified.png`

### Multi-line file via `nano`

```bash
cd ~/project/scripts
nano install.sh
cat install.sh
```

`echo >` can't produce multi-line content in one call, so `nano` was used
instead to write both required lines (`#!/bin/bash` and the `echo` command).

**Evidence:** `evidence/screenshots/07-install-sh-created.png`

---

## Phase 4 - Permissions with `chmod`

**Run as:** `student01`

### `install.sh` - executable by all users

Starting permission: `664` (`rw-rw-r--`). Task: add execute for everyone.
Reasoned per-slot rather than jumping to `777`:

| Slot | Before | + execute | Value |
|---|---|---|---|
| Owner | rw- | rwx | 7 |
| Group | rw- | rwx | 7 |
| Others | r-- | r-x | 5 |

```bash
ls -l install.sh
chmod 775 install.sh
ls -l install.sh
```

Result: `-rwxrwxr-x`. `777` was explicitly rejected as over-granting, since
"others" never had write access to begin with.

**Evidence:** `evidence/screenshots/08-install-sh-chmod-775.png`

### `classified.txt` - remove read for others

Starting permission: `664`. Only the "others" slot changes:

```bash
cd ~/project/bin
ls -l
chmod 660 classified.txt
ls -l
```

Result: `-rw-rw----`.

**Evidence:** `evidence/screenshots/09-classified-chmod-660.png`

### `admin_notes.txt` - owner-only read/write

```bash
cd ~/project/docs
touch admin_notes.txt
ls -l
chmod 644 admin_notes.txt   # first attempt - incorrect
```

**Real mistake:** `644` still leaves group and others with read access
(`rw-r--r--`). The task specifically wants only the owner to have any
access at all.

```bash
chmod 600 admin_notes.txt   # corrected
ls -l
```

Result: `-rw-------`, matching "only the owner can read and write."

**Evidence:** `evidence/screenshots/10-admin-notes-chmod-600.png`

---

## Phase 5 - Clean-Up and Final Touches

**Run as:** `student01`

```bash
rm admin_notes.txt
ls -la
```

**Evidence:** `evidence/screenshots/11-admin-notes-deleted.png`

### Real mistake: copying directories

```bash
cp ~/project/docs ~/project/scripts > ~/project/backup   # incorrect
```

Two problems: `cp` needs `-r` to copy directories at all, and `>` is a text
redirection operator, not a way to specify a `cp` destination.

### Corrected

```bash
cp -r ~/project/docs ~/project/scripts ~/project/backup/
ls -la ~/project/backup
ls -la ~/project/backup/docs
```

Result: `backup/` correctly contains full copies of both `docs/` and
`scripts/`. Absolute paths were used deliberately so the command works
regardless of current directory.

**Evidence:** `evidence/screenshots/12-backup-copy-complete.png`

---

## Phase 6 - Final Checks & sudo Troubleshooting

**Run as:** `student01`, then `governor`, then `student01` again

```bash
cd ~
sudo apt install tree
```

Failed: `student01 is not in the sudoers file` - a direct consequence of
skipping `-G sudo` back in Phase 1.

**Real mistake:** attempted to self-grant sudo from within `student01`'s
own shell (`sudo usermod -aG sudo student01`) - circular, since `sudo`
itself isn't available yet to run that command. Also ran `usermod -aG`
missing the group name argument at one point, which printed usage help
instead of a meaningful error.

**Fix:**

```bash
su governor
sudo usermod -aG sudo student01
exit
exit
su - student01
groups
```

Group membership changes don't apply retroactively to an already-open
shell - a full re-login was required for the new `sudo` membership to take
effect.

```bash
sudo apt install tree
tree project
ls -la
tree -p project      # -p: show permissions
tree -a project      # -a: show hidden files
tree -apug project   # combined: hidden files + permissions + owner + group
```

Combinable single-letter flags (`-a`, `-p`, `-u`, `-g`) work in any order,
same as `ls`'s flags - they're independent on/off switches, not a
meaningful sequence.

**Evidence:** `evidence/screenshots/13-sudo-fix-and-tree-install.png`,
`evidence/screenshots/14-tree-with-permissions.png`

---

## Bonus - Command History

```bash
history > ~/commands_used.txt
```

**Real issue:** `history` only reflected the current shell session, not the
full Phase 1-5 work, due to the `student01` → `governor` → `student01`
session switching in Phase 6 (Bash history is written per-session on shell
exit, and nested `su` switches can leave earlier sessions' history out of a
later `history` call, even though nothing was actually lost).

**Fix:** manually reconstructed the complete, accurate command history in
`nano ~/commands_used.txt`, merging the real historical commands (cross-
referenced against the screenshot record) with what the live `history`
output actually captured, fully renumbered 1-64.

**Evidence:** `evidence/screenshots/15-full-command-history-file.png`
