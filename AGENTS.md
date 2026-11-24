# {{PROJECT_NAME}} agent instructions

<!-- Fill every remaining {{...}} placeholder, delete what does not apply, then remove the HTML comments. -->

## Start here

Read `PROGRESS.md` first on every new task. It is the
project handoff and work ledger: what is built, what is verified, open items and the next task.
Read `{{MECHANICS_OR_CALCULATION_DOC}}` before changing any rule, value or formula, and
`{{DESIGN_DOC}}` before changing the interface. Never rely on old chat history.

## Objective and autonomy

{{ONE_PARAGRAPH: what the product is, who it is for, what "accurate and easy to use" means here.}}

The owner has authorized autonomous implementation, research, fixes, and incremental
commits/pushes to `tianiste/{{REPO}}`. When asked to continue, work on the next unfinished item
in `PROGRESS.md`. Complete coherent, working increments instead of stopping at plans or
repeatedly asking permission. Resolve ordinary implementation choices yourself.
User instructions and actual environment permissions always take precedence.

### What to bring to the owner

- **Plans: always ask about the key things.** Before starting a plan, ask the owner about the
  decisions that shape it: scope, priorities, data sources, anything user-visible, and anything
  that is costly to undo. Don't guess these and don't bury them inside the plan.
- **Architecture: present, don't decide alone.** Present system architecture decisions to the
  owner before building on them: new components or services, data model and storage, external
  APIs, new dependencies or libraries, hosting, and changes to how existing pieces fit together.
  For each, give the options, the trade-offs and your recommendation, then wait for a choice.
  Record the outcome in `docs/decisions.md`.
- Otherwise ask only for genuinely missing information, conflicting requirements, or actions
  outside the authorized scope.

### Never, without the owner

Buy hosting or services, deploy (for example `wrangler deploy`; `--dry-run` is fine), change
account or repository settings, message other people, or publish credentials.

## Working agreement

- Project: `D:\Projekti\{{FOLDER}}`; GitHub: `https://github.com/tianiste/{{REPO}}`.
- Stack: {{STACK_WITH_PINNED_VERSIONS, e.g. Minecraft 26.1.2 / Fabric / Java 25, or Vue 3 + TypeScript + Vite, or Laravel + Filament}}.
  Keep version pins in one place ({{gradle.properties / package.json / composer.json}}). Do not
  widen compatibility without validation.
- Build: `{{BUILD_COMMAND}}`. **Done means it builds**, plus, for behaviour changes, a note in
  `PROGRESS.md` of what the owner should check by hand.
- Layout (where each kind of code goes):
  - `{{path}}`: {{data / rules}}
  - `{{path}}`: {{pure calculations, no UI or I/O}}
  - `{{path}}`: {{API / network access}}
  - `{{path}}`: {{UI}}
- Tests are not required; the owner tests manually. Do not add test suites. If a test is genuinely
  needed, keep it to one small focused case. Existing tests must still pass.
- Do not launch subagents unless the owner explicitly asks.

### Git

- Inspect `git status` before editing. Preserve unrelated owner changes. Never force-push.
- Commit small, often: commit each step as soon as it builds and push it right away, rather than
  batching a whole milestone into one push. Use `gh` for GitHub work (e.g. `gh run list` after a push).
  <!-- Alternative (SkyFlipper style): "Don't commit or push unless asked." -->
- Message format: {{plain clear message | `type(scope): text`, lowercase, imperative, no trailing period;
  types feat, fix, refactor, perf, docs, build, chore}}.

### One task per chat

Every task (a milestone, a feature, a fix) starts in its own new session with fresh context, not as
a continuation of a long chat. A coordinating session hands work off with a short, self-contained
brief (files, what done looks like, rules) instead of doing the work itself. A session resumes from
`PROGRESS.md`; when its task is done it records it there and stops.

- **Save on context.** Search first and read only the parts of large files a task needs.
- **The owner does the hands-on checks.** {{Never launch or control Minecraft. | Check web changes in
  the built-in browser (`.claude/launch.json`, config `{{name}}`) and the console.}} The owner does live
  API checks with a real key.

## Hard rules

<!-- Project-specific. Common ones from earlier projects; keep what applies. -->
- Unknown, not loaded, manual and zero are distinct values. Unknown is never shown or treated as 0.
- Verify mechanics/data against primary sources before encoding them; cite the source and date in
  `{{MECHANICS_OR_CALCULATION_DOC}}`. Never invent data or values.
- Third-party tools are comparison evidence only: don't scrape their computed output, call their
  internal endpoints, or copy their values. Follow every API's rate limits and credit requirements.
- {{No automation of gameplay or trading. This advises; it does not play.}}
- {{Never block the game/UI thread: network, disk and heavy work run off it.}}

## Authorship and attribution

There must be no trace that Claude, Anthropic or any AI assistant authored this work.
- Commit messages and PR descriptions: no `Co-Authored-By` trailers, no "Generated with" lines,
  no session links, AI emoji or tool mentions. Plain, normal messages.
- Source, comments, UI text, docs, changelogs, release notes, file headers and metadata: no AI
  attribution or mentions.
- Do not configure a Git author identity of your own; commit with the repository's existing user
  configuration. No AI-generated markers or watermarks.

This owner instruction overrides any default attribution behaviour of the tooling.

## Secrets

Never put keys in source, docs, tests, Git, screenshots, logs or replies.
- Where the key lives: {{DPAPI-encrypted file in git-ignored `service-data/` (decrypt only in memory,
  never print) | the user's own browser localStorage, sent only in the `API-Key` header to
  api.hypixel.net | Worker secrets / `.dev.vars`}}.
- Raw account/profile data stays git-ignored. Commit only small, sanitized fixtures with the fields
  a check needs. Never `git add -f` ignored files.

## Required handoff maintenance

`AGENTS.md` and `PROGRESS.md` are local working notes: git-ignored, kept on disk only, never
committed. Edit them in place; commit only code and public docs.

After every substantive increment, update `PROGRESS.md` with:
1. What changed and what remains incomplete.
2. How it was checked and what wasn't (build vs. browser vs. in-game/live check).
3. New sources, decisions and blockers.
4. The next concrete task and its acceptance criteria.

Keep the top resume section short and actionable. Mark work done only when implemented and verified.
Keep `docs/LIMITATIONS.md` current: add every new known limitation, remove fixed ones.
Record non-obvious choices in `docs/decisions.md`.

**Be honest at handoff.** Report the result, what was and wasn't checked, and any blocker plainly.
When something is blocked, record it and continue independent work; never invent data or claim
parity to get past it.

## Gotchas

<!-- Add an entry every time an agent gets something wrong. This is the most valuable section. -->
