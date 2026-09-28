# Task Overview

**Source task:** Linux Command Line Practical Task

## Objective

Demonstrate understanding of basic Linux commands by completing the
following tasks as a newly created user in Kali Linux.

## Task Steps (as given)

**Step 1: Create and Switch to a New User**
1. Open the terminal.
2. Create a new user called `student01`.
3. Set a password for the user.
4. Add the user to the sudo group (if required).
5. Switch to the new user using `su` or `login`.
6. Confirm login as `student01` with `whoami`.

**Step 2: Directory & File Management**
1. Inside the home directory, create `project`, and inside it: `docs`,
   `scripts`, `bin`.
2. Navigate to `docs`, create `report.txt` via `echo` with the content
   "This is the initial report by student01."
3. Use `ls -la` to view hidden files.
4. Create a hidden file `.secret.txt` in `docs` with "Top Secret".

**Step 3: Edit and Move Files**
1. Open `report.txt` with `nano`, add a second line: "Appended line using
   nano."
2. Copy `report.txt` to `scripts`.
3. Move `.secret.txt` to `bin`, renaming it `classified.txt`.
4. Create `install.sh` in `scripts` with:
   ```
   #!/bin/bash
   echo "Installing project dependencies..."
   ```

**Step 4: Permissions with `chmod`**
1. In `scripts`, make `install.sh` executable by all users.
2. In `bin`, remove read permission for others from `classified.txt`.
3. In `docs`, create `admin_notes.txt`, set permissions so only the owner
   can read and write it.

**Step 5: Clean-Up and Final Touches**
1. Delete `admin_notes.txt`.
2. Create `project/backup`.
3. Copy the entire content of `docs` and `scripts` into `backup`.

**Final Checks**
1. Navigate back to the home directory.
2. Run `tree project` (install `tree` via `apt` first if needed).
3. Use `ls -la` to confirm permissions and file locations.

**Bonus (Optional)**
1. Use `history` to list all commands run so far.
2. Redirect the history output to `commands_used.txt` in the home directory
   using `>`.
