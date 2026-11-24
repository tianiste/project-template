# Project template

Starting point for a new project: agent instructions, the progress ledger and the decision and
limitation docs.

| File | Purpose |
|------|---------|
| `AGENTS.md` | Agent instructions: start here, autonomy, what to bring to the owner, working agreement, git, one task per chat, hard rules, attribution, secrets, handoff |
| `CLAUDE.md` | Imports `AGENTS.md` |
| `PROGRESS.md` | Handoff and work ledger: resume section, milestones, verification status, sources, session log |
| `docs/decisions.md` | Architecture and other decisions: options, recommendation, the owner's choice |
| `docs/LIMITATIONS.md` | Known limitations |
| `.gitignore` | Secrets and raw data; setup adds the local working notes |
| `setup.ps1` | One-time setup after cloning (deletes itself) |

## Use it

Clone it into a new folder, then run setup inside that folder:

```powershell
git clone https://github.com/tianiste/project-template my-project
```

```powershell
cd my-project; .\setup.ps1 -Name "My Project" -Build "npm run build"
```

Then point the repo at the new project's remote (`git remote set-url origin ...`, or delete
`.git` and `git init` for a fresh history), fill the remaining `{{...}}` placeholders the script
lists, and commit.
