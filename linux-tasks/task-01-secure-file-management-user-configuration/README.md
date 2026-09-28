# Secure File Management & User Configuration on Kali Linux

> Part of the [Tech4Youth Cybersecurity](../../README.md) labs, in the [Linux tasks](../README.md) section.

## Description

This folder documents a completed practical Linux lab covering user account
creation, workspace setup, file operations, permission management, error
recovery, and ownership behavior on Kali Linux. All commands were executed
manually in a Kali Linux VM (VirtualBox) and this folder reflects the
**actual** commands run and **actual** output produced, not a template.

## Objective

Demonstrate understanding of fundamental Linux file system and user management
commands by setting up a secure workspace for a newly created user and
organizing files with proper permissions and structure.

## Lab / Activity Requirements

- You must **not** use the root user to perform the file operations.
- A new user (`agent007`) must be created first.
- All steps except `useradd` and `usermod` must be performed as `agent007`.

## Technologies / Tools Used

- Kali Linux (running inside VirtualBox)
- Bash shell
- Core GNU coreutils: `useradd`, `passwd`, `su`, `mkdir`, `touch`, `ls`,
  `cp`, `rm`, `chmod`, `chown`, `cat`, `history`
- `nano` text editor
- VirtualBox Shared Folders (used to transfer submission files to the host)

## Prerequisites

- A working Kali Linux installation (VM or bare metal)
- A user account with `sudo` privileges (used here: `governor`)
- Terminal access (Terminator was used in this lab)

## Environment / Setup Information

| Item | Value |
|---|---|
| Host OS | Windows |
| Virtualization | Oracle VirtualBox |
| Guest OS | Kali Linux 2026.2 |
| Admin user | `governor` |
| Lab user created | `agent007` |
| Terminal emulator | Terminator |

## Folder Structure

```
task-01-secure-file-management-user-configuration/
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
│   └── screenshots/
│       ├── 01-user-created.png
│       ├── 02-workspace-created.png
│       ├── 03-files-created.png
│       ├── 04-copy-remove-files.png
│       ├── 05-file-permissions.png
│       ├── 06-error-recovery.png
│       ├── 07-ownership-changed.png
│       ├── 08-permission-denied-test.png
│       ├── 09-final-directory-structure.png
│       └── 10-explanation-file.png
│
└── submission/
    ├── README.md
    ├── command-history.txt
    ├── final-output.txt
    └── explanation.txt
```

## Step-by-Step Workflow

See [`workflow/workflow.md`](workflow/workflow.md) for the full phase-by-phase
breakdown with commands, expected results, and verification steps.

## Commands Used

See [`commands/commands.sh`](commands/commands.sh) for the full annotated
command list, separated by which user must run each block.

## Expected Results

- User `agent007` exists, has a home directory, `/bin/bash` shell, and is in
  the `sudo` group.
- `/home/agent007/mission/` contains the `intel/` and `ops/backup/` structure.
- `intel/` contains `targets.txt`, `routes.txt`, three listing files, but no
  `keys.txt` (deleted in Step 5).
- `targets.txt` permissions are `640` (`rw-r-----`).
- `ops/backup/routes.txt` exists (recovered after intentional deletion).
- `targets.txt` is owned by `root`, group `agent007`, demonstrating that
  `agent007` loses write access once ownership changes.

## Evidence Requirements

See [`evidence/README.md`](evidence/README.md) for what each screenshot proves.

## Submission Requirements

Per the task, the student must submit:
1. Command history
2. Final `ls -laR /home/agent007/mission/` output
3. A 4–5 line explanation of `chmod`, `ls -l`, and `useradd`

All three are provided, populated with real results, in
[`submission/`](submission/).

## Troubleshooting

- **`adduser` vs `useradd`**: The task requires `useradd` with explicit flags
  (`-m -s -G`). `adduser` is a different, higher-level wrapper with different
  syntax and will reject those flags with an "Unknown option" error.
- **Typing `~mission/intel` instead of `~/mission/intel`**: `~` alone means
  "home directory"; without the following `/`, Bash tries to resolve it as a
  *different user's* home directory and fails with "No such file or directory".
- **`ls -laR` failing as `ls laR`**: without the leading `-`, `ls` treats `laR`
  as a literal filename argument instead of three combined flags.
- **VirtualBox Shared Folder `Permission denied`**: the lab user must be added
  to the `vboxsf` group (`sudo usermod -aG vboxsf <user>`) and the shell must
  be restarted (`exit`, then `su - <user>` again) for the new group membership
  to take effect.

## Safety / Permission Notes

- `sudo useradd` and `sudo passwd` were run from the admin account
  (`governor`) to create the user and set its password. All file operations
  were then run as `agent007`, never as root.
- Step 8 (ownership change) is the task's one explicit privileged file
  operation, run with `sudo chown` from inside the `agent007` shell.
- `sudo usermod -aG vboxsf agent007` was used only to let `agent007` reach the
  VirtualBox shared folder when moving the submission files to the host. It is
  not part of the lab steps.
- `rm` has no undo. Step 7 intentionally uses `rm` to simulate an accidental
  deletion and then recovers using `cp` from a surviving copy.
