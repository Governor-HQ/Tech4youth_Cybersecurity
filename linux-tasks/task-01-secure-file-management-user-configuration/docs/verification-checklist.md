# Final Verification Checklist

- [x] `agent007` user created with home directory, bash shell, sudo group
- [x] `mission/intel/` and `mission/ops/backup/` directories created
- [x] `targets.txt`, `routes.txt`, `keys.txt` created; `keys.txt` later removed
- [x] `listing1.txt`, `listing2.txt`, `listing3.txt` created inside `intel/`
- [x] `routes.txt` copied into `ops/backup/`
- [x] `targets.txt` permissions set to `640` (`rw-r-----`) and verified
- [x] `ops/backup/routes.txt` deleted on purpose, then recovered from `intel/`
- [x] `targets.txt` ownership changed to `root`; access change to `agent007`
      observed and confirmed (`Permission denied` on write)
- [x] Command history saved (`command-history.txt`)
- [x] Final recursive listing saved (`final-output.txt`)
- [x] Written explanation of `chmod`, `useradd`, `ls -l` completed
      (`explanation.txt`)
- [x] Screenshots captured for every phase
- [x] Submission files transferred off the VM to the Windows host
