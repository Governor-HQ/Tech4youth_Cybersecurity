# Scripts

No executable setup/verify/cleanup scripts are included in this task folder.

This lab is intentionally interactive and sequential:

- User creation and password setup require manual `sudo` password entry.
- Switching into `agent007` requires a manual password prompt (`su -`).
- The ownership step (Phase 7) intentionally requires observing a
  permission-denied result, which loses its educational value if scripted.
- The explanation file (Phase 8) is written manually in `nano`, since it is a
  personal write-up, not a generated artifact.

Automating these steps would remove the parts of the task that are meant to
be performed and understood manually. See [`commands/commands.sh`](../commands/commands.sh)
for the full annotated command reference instead, and
[`workflow/workflow.md`](../workflow/workflow.md) for the phase-by-phase
procedure.
