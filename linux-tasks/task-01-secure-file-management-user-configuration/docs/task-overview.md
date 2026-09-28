# Task Overview

**Source task:** Practical Task: Secure File Management & User Configuration on
Kali Linux

## Objective

Demonstrate understanding of fundamental Linux file system and user management
commands. Set up a secure workspace for a newly created user and organize
files with proper permissions and structure.

## Restriction

You must **not** use the root user to complete the file operations. A new user
must be created, and all steps (except `useradd` and `usermod`) must be
performed using that user's account.

## Task Steps (as given)

1. **Create a New User** - create `agent007` with a home directory,
   `/bin/bash` shell, added to the `sudo` group.
2. **Switch to the New User** - set a password for `agent007`, switch into
   the account, perform the remaining steps as this user.
3. **Setup Workspace** - inside `/home/agent007/`, create:
   ```
   mission/
   ├── intel/
   └── ops/
       └── backup/
   ```
4. **File Creation and Listing** - inside `intel/`, create `targets.txt`,
   `routes.txt`, `keys.txt`. Run `ls`, `ls -l`, `ls -la` and redirect each
   output into `listing1.txt`, `listing2.txt`, `listing3.txt` inside `intel/`.
5. **Copy and Remove Files** - copy `routes.txt` into `ops/backup/`, delete
   `keys.txt` from `intel/`.
6. **Permissions Handling** - change `targets.txt` so owner can read/write,
   group can only read, others have no access. Verify with `ls -l`.
7. **Simulate an Error and Recover** - delete `ops/backup/routes.txt`, then
   copy `routes.txt` from `intel/` back into `backup/`.
8. **Advanced Permissions & Ownership** - as root, change ownership of
   `intel/targets.txt` to another user (e.g. `root`), switch back to
   `agent007`, observe the result with `ls -l`.

## Submission Requirements (as given)

- Command history (`.bash_history` or copy-paste of commands used)
- A screenshot or text file showing the final `ls -laR /home/agent007/mission/`
  output
- A text explanation (4–5 lines) of what `chmod`, `ls -l`, and `useradd` do
