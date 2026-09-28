# Evidence

All screenshots below are real terminal captures from the completed lab, not
staged or fabricated. Each shows the actual command typed and its actual
output.

| Screenshot | Proves |
|---|---|
| `01-user-created.png` | `agent007` created (`useradd`), password set (`passwd`), successfully switched into via `su -`, confirmed with `whoami` and `id`. |
| `02-workspace-created.png` | `mission/intel/` and `mission/ops/backup/` directory tree created with `mkdir -p` and verified with `ls -la`. |
| `03-files-created.png` | `targets.txt`, `routes.txt`, `keys.txt` created empty with `touch`; `ls`, `ls -l`, `ls -la` redirected into `listing1.txt`–`listing3.txt`. |
| `04-copy-remove-files.png` | `routes.txt` copied into `ops/backup/`; `keys.txt` deleted from `intel/`. |
| `05-file-permissions.png` | `chmod 640 targets.txt` applied and verified: `-rw-r-----`. |
| `06-error-recovery.png` | `ops/backup/routes.txt` deleted on purpose, then recovered by copying from the surviving copy in `intel/`. |
| `07-ownership-changed.png` | `sudo chown root targets.txt` run; `ls -l` shows owner changed to `root`, group still `agent007`. |
| `08-permission-denied-test.png` | With `agent007` no longer the owner, `cat` (read) succeeds via group permission but `echo >>` (write) fails with `Permission denied`. |
| `09-final-directory-structure.png` | Final `ls -laR /home/agent007/mission/` output, showing the complete directory tree, all files, and the `root`-owned `targets.txt`. |
| `10-explanation-file.png` | The written 4–5 line explanation of `chmod`, `useradd`, and `ls -l`, saved and verified with `cat`. |

No `terminal-output/` text captures were kept separately from the screenshots
above; the equivalent raw text output is already preserved in
[`submission/final-output.txt`](../submission/final-output.txt) and
[`submission/command-history.txt`](../submission/command-history.txt).
