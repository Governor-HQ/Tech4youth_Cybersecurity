# Evidence

All screenshots below are real terminal captures from the completed lab, not
staged or fabricated. Several deliberately show a mistake being made and
then corrected, since that's part of the genuine learning record.

| Screenshot | Proves |
|---|---|
| `01-user-created-and-switched.png` | `student01` created, password set, switched into via `su -`, confirmed with `whoami`. |
| `02-project-structure-created.png` | `project/docs/scripts/bin` structure built, `report.txt` and `.secret.txt` created via `echo`, hidden file confirmed with `ls -la`. |
| `03-nano-append-mistake-and-fix.png` | First `nano ~/report.txt` opened the wrong file (home directory instead of `docs/`); the correct file (`docs/report.txt`) was then edited and verified with both lines present. |
| `04-stray-file-cleanup.png` | The stray `~/report.txt` found via `ls -la ~` and removed with `rm`; the real file confirmed untouched. |
| `05-copy-report-to-scripts.png` | `cp report.txt ~/project/scripts/` - copy confirmed in both locations. |
| `06-move-rename-classified.png` | `mv .secret.txt ~/project/bin/classified.txt` - original gone from `docs/`, present (renamed) in `bin/`. |
| `07-install-sh-created.png` | `install.sh` created via `nano` with the required shebang + echo content. |
| `08-install-sh-chmod-775.png` | `chmod 775 install.sh` reasoned from `664`, verified as `-rwxrwxr-x`. |
| `09-classified-chmod-660.png` | `chmod 660 classified.txt` - read removed for others only, verified as `-rw-rw----`. |
| `10-admin-notes-chmod-600.png` | First attempt `644` (incorrect - still group/others readable), corrected to `600` (`-rw-------`), matching "only the owner can read and write." |
| `11-admin-notes-deleted.png` | `admin_notes.txt` removed with `rm`, confirmed gone via `ls -la`. |
| `12-backup-copy-complete.png` | `cp -r` (after an incorrect first attempt without `-r` and using `>`) correctly populated `backup/` with copies of `docs/` and `scripts/`. |
| `13-sudo-fix-and-tree-install.png` | Circular sudo attempt from `student01`'s own shell, fixed by switching to `governor`, running `sudo usermod -aG sudo student01`, then re-logging in. |
| `14-tree-with-permissions.png` | `tree -apug project` - full structure with hidden files, permissions, and ownership shown together. |
| `15-full-command-history-file.png` | Final, complete, renumbered 1-64 `commands_used.txt`, reconstructed to include commands lost from `history` due to nested `su` session switching. |

No separate `terminal-output/` text captures were kept; the equivalent raw
text is preserved in [`submission/commands_used.txt`](../submission/commands_used.txt).
