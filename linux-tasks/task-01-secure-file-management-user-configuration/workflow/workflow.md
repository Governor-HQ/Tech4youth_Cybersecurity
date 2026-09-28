# Workflow

This is the actual, completed procedure for the lab, broken into phases. Each
step lists the command, who runs it, what happened, how it was verified, and
which evidence file backs it up.

---

## Phase 1 - User Account Creation

**Run as:** `governor` (sudo)

### Step 1.1 - Create the user

```bash
sudo useradd -m -s /bin/bash -G sudo agent007
```

- `-m` creates the home directory `/home/agent007`
- `-s /bin/bash` sets the login shell
- `-G sudo` adds `agent007` to the `sudo` group as a supplementary group

**Note:** `adduser` (a different, higher-level command) was tried first by
mistake and rejected the flags with an "Unknown option" error, since it uses
a different argument style. `useradd` is the correct low-level command the
task specifies.

**Verification:**

```bash
id agent007
```

Result: `uid=1003(agent007) gid=1003(agent007) groups=1003(agent007),27(sudo)`

**Evidence:** `evidence/screenshots/01-user-created.png`

### Step 1.2 - Set password and switch user

```bash
sudo passwd agent007
su - agent007
whoami
```

Result: password set successfully; `whoami` returns `agent007` after `su -`.
The `-` flag on `su` starts a full login shell (correct working directory and
environment for the new user, rather than just changing identity).

**Evidence:** `evidence/screenshots/01-user-created.png`

---

## Phase 2 - Workspace Setup

**Run as:** `agent007`

### Step 2.1 - Build the directory tree

```bash
mkdir -p ~/mission/intel ~/mission/ops/backup
```

`-p` creates all missing parent directories in one call and does not error if
a directory already exists.

**Verification:**

```bash
ls -la ~/mission
ls -la ~/mission/ops
```

Result: `intel/` and `ops/` created under `mission/`; `backup/` created under
`ops/`.

**Evidence:** `evidence/screenshots/02-workspace-created.png`

---

## Phase 3 - File Creation & Listing Capture

**Run as:** `agent007`

### Step 3.1 - Create empty files

```bash
touch ~/mission/intel/targets.txt ~/mission/intel/routes.txt ~/mission/intel/keys.txt
```

`touch` creates an empty file if it does not already exist.

**Verification:**

```bash
ls -la ~/mission/intel
```

Result: three 0-byte regular files created.

**Evidence:** `evidence/screenshots/03-files-created.png`

### Step 3.2 - Capture listings into files

```bash
cd ~/mission/intel
ls > listing1.txt
ls -l > listing2.txt
ls -la > listing3.txt
```

`>` redirects a command's output into a file, overwriting it if it exists.
Because the listing files are created inside `intel/` while `ls` is run
against `intel/`, each successive listing includes the previous listing
file(s) - expected behavior, not an error.

**Verification:**

```bash
cat listing1.txt
cat listing2.txt
cat listing3.txt
```

**Evidence:** `evidence/screenshots/03-files-created.png`

---

## Phase 4 - Copy & Remove

**Run as:** `agent007`

### Step 4.1 - Copy `routes.txt` to backup

```bash
cp routes.txt ~/mission/ops/backup/
```

Trailing `/` on the destination tells `cp` to place the file inside that
directory under the same name. `cp` does not remove the source.

### Step 4.2 - Delete `keys.txt`

```bash
rm keys.txt
```

`rm` deletes permanently; there is no undo at the command line.

**Verification:**

```bash
ls -la ~/mission/intel
ls -la ~/mission/ops/backup
```

Result: `keys.txt` gone from `intel/`; `routes.txt` now exists in both
`intel/` and `ops/backup/`.

**Evidence:** `evidence/screenshots/04-copy-remove-files.png`

---

## Phase 5 - Permissions Handling

**Run as:** `agent007`

### Step 5.1 - Set exact permissions on `targets.txt`

Required: owner read+write, group read-only, others no access.

| Slot | Permission | Value |
|---|---|---|
| Owner | rw- | 6 |
| Group | r-- | 4 |
| Others | --- | 0 |

```bash
chmod 640 targets.txt
```

**Verification:**

```bash
ls -l targets.txt
```

Result: `-rw-r----- 1 agent007 agent007 0 ... targets.txt` - matches spec
exactly.

**Evidence:** `evidence/screenshots/05-file-permissions.png`

---

## Phase 6 - Error Simulation & Recovery

**Run as:** `agent007`

### Step 6.1 - Delete the backup copy on purpose

```bash
rm ~/mission/ops/backup/routes.txt
```

**Verification:**

```bash
ls -la ~/mission/ops/backup
```

Result: `backup/` empty (just `.` and `..`).

### Step 6.2 - Recover from the surviving copy in `intel/`

```bash
cp ~/mission/intel/routes.txt ~/mission/ops/backup/
```

**Verification:**

```bash
ls -la ~/mission/ops/backup
```

Result: `routes.txt` restored in `backup/`, original in `intel/` untouched.

**Evidence:** `evidence/screenshots/06-error-recovery.png`

---

## Phase 7 - Advanced Permissions & Ownership

**Run as:** `agent007` invoking `sudo` (root-level action for this one command
only)

### Step 7.1 - Change ownership of `targets.txt`

```bash
sudo chown root targets.txt
```

`chown` here changes only the **owner** to `root`; the group remains
`agent007` (it was not explicitly changed).

**Verification:**

```bash
ls -l targets.txt
```

Result: `-rw-r----- 1 root agent007 0 ... targets.txt`

**Evidence:** `evidence/screenshots/07-ownership-changed.png`

### Step 7.2 - Observe the access change

With permissions still `640` (`rw-r-----`) but owner now `root`, `agent007` no
longer matches the owner slot and falls through to the group slot
(read-only).

```bash
cat targets.txt        # succeeds - read access via group permission
echo "test" >> targets.txt   # fails - no write access anymore
```

Result: read succeeded; write failed with `Permission denied`, confirming
that changing a file's owner can silently remove access the previous owner
had, even though the permission bits never changed.

**Evidence:** `evidence/screenshots/08-permission-denied-test.png`

---

## Phase 8 - Evidence & Submission Collection

**Run as:** `agent007`

### Step 8.1 - Save command history

```bash
history > ~/mission/command-history.txt
```

### Step 8.2 - Save the final recursive listing

```bash
ls -laR /home/agent007/mission/ > ~/mission/final-output.txt
```

`-R` recurses into every subdirectory, listing `mission/`, `intel/`, `ops/`,
and `ops/backup/` in one combined output.

**Evidence:** `evidence/screenshots/09-final-directory-structure.png`

### Step 8.3 - Write the explanation

```bash
nano ~/mission/explanation.txt
```

4–5 line explanation of `chmod`, `useradd`, and `ls -l`, written and saved.

**Evidence:** `evidence/screenshots/10-explanation-file.png`

### Step 8.4 - Transfer submission files to the Windows host

Files were moved off the VM using a VirtualBox Shared Folder rather than
clipboard copy-paste (clipboard alone doesn't move whole files).

```bash
sudo usermod -aG vboxsf agent007   # one-time: allow agent007 to access shared folders
exit
su - agent007                       # re-login required for new group to apply
cp ~/mission/command-history.txt ~/mission/final-output.txt ~/mission/explanation.txt /media/sf_kali-linux-share/
```

Result: all three submission files appeared on the Windows host inside the
mapped `kali-linux-share` folder.
