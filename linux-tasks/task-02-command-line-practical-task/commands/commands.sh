#!/bin/bash
#
# Linux Command Line Practical Task
# ------------------------------------------------------------
# Documents the commands used, in order, exactly as run during the lab.
# NOT meant to be executed top-to-bottom as a single script - several
# commands require manual password entry, a user switch, or interactive
# editing (nano), and are marked accordingly.

# ============================================================
# BLOCK 1 - run as: governor (with sudo)
# Requires manual password entry - do not automate.
# ============================================================

sudo useradd -m -s /bin/bash student01
sudo passwd student01
su - student01
whoami


# ============================================================
# BLOCK 2 - run as: student01
# ============================================================

# --- Step 2: directory & file management ---
mkdir ~/project
ls -la ~
mkdir ~/project/docs ~/project/scripts ~/project/bin
ls -la ~/project

cd ~/project/docs
echo "This is the initial report by student01." > report.txt
ls -la
echo "Top Secret." > .secret.txt
cat .secret.txt

# --- Step 3: edit, copy, move ---
nano report.txt                              # manual - append second line
cat report.txt

cp report.txt ~/project/scripts/
mv .secret.txt ~/project/bin/classified.txt

cd ~/project/scripts
nano install.sh                              # manual - write shebang + echo line
cat install.sh

# --- Step 4: permissions ---
# 664 -> 775: add execute to owner/group/others (7,7,5)
chmod 775 install.sh

cd ~/project/bin
# 664 -> 660: remove read from "others" only
chmod 660 classified.txt

cd ~/project/docs
touch admin_notes.txt
# 600: owner rw, group none, others none ("only the owner can read and write")
chmod 600 admin_notes.txt

# --- Step 5: clean-up ---
rm admin_notes.txt
cd ~/project
mkdir backup
cp -r ~/project/docs ~/project/scripts ~/project/backup/
ls -la ~/project/backup


# ============================================================
# BLOCK 3 - run as: student01, then governor, then student01 again
# Requires manual password entry and a user switch - do not automate.
# ============================================================

cd ~
sudo apt install tree   # fails first time: student01 not in sudo group yet

# fix: switch to an account that already has sudo
su governor
sudo usermod -aG sudo student01
exit
exit
su - student01
groups                  # confirm 'sudo' now present

sudo apt install tree
tree project
ls -la
tree -apug project      # hidden files + permissions + owner + group, combined


# ============================================================
# BLOCK 4 - run as: student01
# Bonus: command history
# ============================================================

history > ~/commands_used.txt

# History only reflects the current session (nested su switches reset it).
# Manually reconstruct the full history in nano to reflect everything
# actually run across the whole task:
nano ~/commands_used.txt    # manual - merge + renumber full history
cat ~/commands_used.txt
