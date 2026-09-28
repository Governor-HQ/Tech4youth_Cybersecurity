#!/bin/bash
#
# Secure File Management & User Configuration on Kali Linux
# ------------------------------------------------------------
# This file documents the commands used, in order, exactly as run
# during the lab. It is NOT meant to be executed top-to-bottom as a
# single script: several commands require manual password entry or a
# user switch, and are marked accordingly.
#
# Run blocks manually, in order, in your own terminal.

# ============================================================
# BLOCK 1 - run as: governor (with sudo)
# Requires manual password entry - do not automate.
# ============================================================

# Create the agent007 user with a home directory, bash shell, and sudo group
sudo useradd -m -s /bin/bash -G sudo agent007

# Verify the user and group memberships
id agent007

# Set a password for agent007 (interactive - prompts twice)
sudo passwd agent007

# Switch into the agent007 account as a full login shell
su - agent007

# Confirm the switch worked
whoami


# ============================================================
# BLOCK 2 - run as: agent007
# Safe to run as a sequence once you are inside agent007's shell.
# ============================================================

# --- Phase 2: workspace ---
mkdir -p ~/mission/intel ~/mission/ops/backup
ls -la ~/mission
ls -la ~/mission/ops

# --- Phase 3: file creation ---
touch ~/mission/intel/targets.txt ~/mission/intel/routes.txt ~/mission/intel/keys.txt
ls -la ~/mission/intel

cd ~/mission/intel
ls        > listing1.txt
ls -l     > listing2.txt
ls -la    > listing3.txt
cat listing1.txt
cat listing2.txt
cat listing3.txt

# --- Phase 4: copy & remove ---
cp routes.txt ~/mission/ops/backup/
rm keys.txt
ls -la ~/mission/intel
ls -la ~/mission/ops/backup

# --- Phase 5: permissions ---
# owner rw- (6), group r-- (4), others --- (0) => 640
chmod 640 targets.txt
ls -l targets.txt

# --- Phase 6: simulate error and recover ---
rm ~/mission/ops/backup/routes.txt
ls -la ~/mission/ops/backup
cp ~/mission/intel/routes.txt ~/mission/ops/backup/
ls -la ~/mission/ops/backup


# ============================================================
# BLOCK 3 - run as: agent007, using sudo for ONE command
# Requires manual password entry - do not automate.
# ============================================================

# Change ownership of targets.txt to root (task's specified exception)
sudo chown root targets.txt
ls -l targets.txt

# Observe the access change caused by the ownership change
cat targets.txt              # expected: succeeds (group has read)
echo "test" >> targets.txt   # expected: fails - Permission denied


# ============================================================
# BLOCK 4 - run as: agent007
# Evidence and submission file generation.
# ============================================================

history > ~/mission/command-history.txt
ls -laR /home/agent007/mission/ > ~/mission/final-output.txt

# Write the 4-5 line explanation manually - interactive, do not automate
nano ~/mission/explanation.txt


# ============================================================
# BLOCK 5 - run as: agent007
# One-time setup + file transfer to the Windows host via a
# VirtualBox Shared Folder. Requires the shared folder to already be
# configured in VirtualBox (Devices > Shared Folders).
# ============================================================

# One-time: allow agent007 to access VirtualBox shared folders
sudo usermod -aG vboxsf agent007

# Group membership only applies to NEW shells - re-login is required
exit
su - agent007

# Copy the three submission files onto the shared folder
cp ~/mission/command-history.txt ~/mission/final-output.txt ~/mission/explanation.txt /media/sf_kali-linux-share/
