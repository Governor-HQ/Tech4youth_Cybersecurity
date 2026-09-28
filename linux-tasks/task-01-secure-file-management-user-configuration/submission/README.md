# Submission

Per the task's submission requirements, this folder contains:

1. **`command-history.txt`** - the real `agent007` shell command history
   (`history` output), covering workspace setup through evidence collection.
   Note: the two `governor`-shell commands (`sudo useradd ...` and
   `sudo passwd agent007`) are not present in this file, since Bash history is
   per-session and those were run before switching into `agent007`. They are
   fully documented instead in `commands/commands.sh` and `workflow/workflow.md`.
2. **`final-output.txt`** - the real output of
   `ls -laR /home/agent007/mission/`, showing the complete final directory
   structure, including `targets.txt`'s changed ownership (`root agent007`).
3. **`explanation.txt`** - a written explanation of what `chmod`, `useradd`,
   and `ls -l` do, in the student's own words.

All three files contain actual results from the completed lab, not
placeholders.
