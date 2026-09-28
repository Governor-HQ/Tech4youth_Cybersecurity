# Linux Command Line Practical Task

> Part of the [Tech4Youth Cybersecurity](../../README.md) labs, in the [Linux tasks](../README.md) section.

## Description

This folder documents a completed practical Linux lab covering user
creation, directory/file management, file editing with `nano`, copying vs.
moving files, `chmod` permission reasoning, cleanup/backup operations, and
the `tree` command. All commands were executed manually in a Kali Linux VM
(VirtualBox) and this folder reflects the **actual** commands run and
**actual** output produced, not a template.

## Objective

Demonstrate understanding of basic Linux commands by completing the given
tasks as a newly created user (`student01`) in Kali Linux.

## Lab / Activity Requirements

- Create and switch to a new user, `student01`.
- Perform directory/file management, editing, permission changes, and
  cleanup as that user.
- Confirm final structure and permissions with `tree` and `ls -la`.
- (Bonus) Save command history to a file in the home directory.

## Technologies / Tools Used

- Kali Linux (running inside VirtualBox)
- Bash shell, `nano` text editor, Terminator terminal
- Core GNU coreutils: `useradd`, `passwd`, `su`, `mkdir`, `echo`, `cat`,
  `cp`, `mv`, `rm`, `chmod`, `usermod`, `history`
- `tree` (installed via `apt` mid-task)

## Prerequisites

- A working Kali Linux installation with a `sudo`-capable admin account
  (used here: `governor`)
- Terminal access (Terminator)

## Environment / Setup Information

| Item | Value |
|---|---|
| Host OS | Windows |
| Virtualization | Oracle VirtualBox |
| Guest OS | Kali Linux 2026.2 |
| Admin user | `governor` |
| Lab user created | `student01` |
| Terminal emulator | Terminator |

## Folder Structure

```
task-02-command-line-practical-task/
│
├── README.md
├── .gitignore
│
├── docs/
│   └── task-overview.md
│
├── workflow/
│   └── workflow.md
│
├── commands/
│   └── commands.sh
│
├── scripts/
│   └── README.md
│
├── evidence/
│   ├── README.md
│   └── screenshots/ (15 real annotated screenshots)
│
└── submission/
    ├── README.md
    └── commands_used.txt
```

## Step-by-Step Workflow

See [`workflow/workflow.md`](workflow/workflow.md) for the full phase-by-phase
breakdown, including the real mistakes made along the way and how each was
diagnosed and fixed.

## Commands Used

See [`commands/commands.sh`](commands/commands.sh) for the full annotated
command list.

## Expected Results

- `student01` exists with a home directory, bash shell, and (added partway
  through) `sudo` group membership.
- `~/project/` contains `docs/`, `scripts/`, `bin/`, and `backup/`.
- `install.sh` is `775` (`rwxrwxr-x`).
- `bin/classified.txt` is `660` (`rw-rw----`).
- `backup/` contains full copies of `docs/` and `scripts/`.
- `~/commands_used.txt` holds the full, numbered command history.

## Evidence Requirements

See [`evidence/README.md`](evidence/README.md) for what each screenshot
proves.

## Submission Requirements

See [`submission/README.md`](submission/README.md).

## Troubleshooting

- **Plain `cat` with no filename** doesn't error, it waits on keyboard input
  and echoes back whatever is typed next as literal text. Escape with
  `Ctrl+C` - this cancels the hanging command without clearing any terminal
  history.
- **`nano ~/report.txt` vs `nano report.txt`** - `~/` always means the home
  directory, regardless of your current folder. Using it by mistake while
  already inside `~/project/docs` created an unwanted duplicate file in the
  home directory, found via `ls -la ~` and removed with `rm`.
- **`cp` on a directory without `-r`** fails; directories need
  `cp -r source destination`. `>` is for text redirection, not for
  specifying a `cp` destination.
- **Chained `su` switches losing history** - `history` only reflects the
  current shell session; switching `student01` → `governor` → `student01`
  again meant earlier commands weren't visible in a fresh `history` call,
  even though they weren't lost or undone. Reconstructed manually against
  the real screenshot record.
- **Granting `sudo` to a user who doesn't have `sudo` yet** is circular -
  fix by switching to an account that already has `sudo` rights
  (`su governor`) and running `sudo usermod -aG sudo student01` from there,
  then fully re-logging into `student01` (`exit`, `su - student01`) since
  group membership changes don't apply to an already-open shell.

## Safety / Permission Notes

- `student01` was deliberately **not** added to the `sudo` group at creation
  time, since nothing in the task initially required it. It was added later,
  once `tree` needed installing via `apt`.
- `rm` has no undo; used deliberately in the cleanup step and once by
  mistake (a stray file), both confirmed via `ls` before and after.
