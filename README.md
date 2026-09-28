# Tech4Youth Cybersecurity

Hands-on practical labs from the Tech4Youth cybersecurity course, done on
Kali Linux. Every task was completed manually, typing each command in the
terminal. Each task folder documents the real commands run, real screenshots,
and the real mistakes made and fixed along the way.

## Topics

| Topic | Focus | Tasks completed |
|---|---|---|
| [Linux](linux-tasks/) | Linux command line fundamentals: users, files, permissions, ownership | 01, 02 |

More topics and tasks will be added as they are completed.

## Linux tasks

| Task | Focus | Folder |
|---|---|---|
| 01 | User creation, workspace setup, file operations, `chmod`, ownership with `chown` | [`task-01-secure-file-management-user-configuration`](linux-tasks/task-01-secure-file-management-user-configuration/) |
| 02 | Directory and file management, `nano`, `cp` vs `mv`, `chmod` reasoning, backups, `tree` | [`task-02-command-line-practical-task`](linux-tasks/task-02-command-line-practical-task/) |

## Repository structure

```
Tech4youth_Cybersecurity/
├── README.md
├── .gitignore
└── linux-tasks/
    ├── README.md
    ├── task-01-secure-file-management-user-configuration/
    └── task-02-command-line-practical-task/
```

New topics get their own folder next to `linux-tasks/`, and each task lives in
its own subfolder inside its topic.

## What each task folder contains

```
task-XX-name/
├── README.md        overview, requirements, expected results, troubleshooting
├── workflow/        phase-by-phase procedure with commands and results
├── commands/        annotated command reference
├── evidence/        real screenshots from the lab
├── submission/      the files submitted for the task
├── docs/            task overview and verification checklist
└── scripts/         notes on why no automation was used
```

## Environment

| Item | Value |
|---|---|
| Host OS | Windows |
| Virtualization | Oracle VirtualBox |
| Guest OS | Kali Linux 2026.2 |
| Terminal | Terminator |

## Notes

- Screenshots and command histories are real captures, not staged output.
- Mistakes are left in on purpose. The troubleshooting sections explain what
  went wrong and how each one was diagnosed.
