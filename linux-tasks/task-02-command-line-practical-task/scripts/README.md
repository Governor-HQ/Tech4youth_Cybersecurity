# Scripts

No executable setup/verify/cleanup scripts are included in this task folder.

Every step here is intentionally manual and sequential: user creation and
`sudo` require interactive password entry, `nano` editing (appending a line
to `report.txt`, writing `install.sh`, reconstructing `commands_used.txt`)
is a personal, hands-on action, and the permission-reasoning steps
(`chmod`) are meant to be worked out and typed individually, not generated.
Automating any of this would remove the parts of the task meant to be
performed and understood manually.

See [`commands/commands.sh`](../commands/commands.sh) for the full annotated
command reference instead, and [`workflow/workflow.md`](../workflow/workflow.md)
for the phase-by-phase procedure.
