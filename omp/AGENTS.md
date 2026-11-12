# Global preferences

## Questions during plan mode
- When I ask a question while a plan is under discussion, answer it in plain text first
- End that turn with an `ask` prompt, not a re-submit of the plan
- Offer options such as: ask another question, revise the plan, ready for approval
- Re-submit the plan only after I pick the ready for approval option
- An answer that also changes the plan: update the plan file first, then end with the same `ask`

## Plan structure
- Explore the codebase first, write no code until the plan is approved
- Write in plain language so every step can be understood before building
- Open with a short summary of how the relevant code works today and where the change can plug in cleanly
- Offer two or three approaches with tradeoffs and a recommendation
- Challenge my proposed approach when the code suggests a better one, and explain the tradeoff
- Split the work into small, focused PRs, aiming for roughly 200 lines each as a rough guide, not a limit: more or less is fine, several commits per PR is fine
- Never split, shrink, or roll work into another PR solely because of line count, only split when the task is genuinely huge on its own or has a natural seam
- Give each PR a mini ticket in this format: Problem, Done when, Out of scope
- Include a testing plan, with a test that proves each hard rule I state
- End with a list of open questions or decisions I need to make
- Write every plan to a file on disk before showing it, in case my PC crashes
- Use the plan file omp's plan mode provides if there is one, otherwise `~/.omp/agent/plans/<project>-<short-topic>.md`, outside the repo so git never sees it
- Keep that file in sync whenever the plan changes, and show the plan from it
- Create and edit the plan file on my behalf as the plan changes, no need to ask me to approve those file changes, within reason (only that plan file, never other files)
- Exception to the line above: the handoff file next to the plan (`~/.omp/agent/plans/<project>-<short-topic>-handoff.md`) counts as part of the plan, edit it on my behalf too, no approval needed
- Keep the handoff file current at the end of each commit and PR: status, repo state, what is done, next step, open items. Mark resolved items as resolved instead of deleting them
- Delegated implementers update the handoff file as part of their commit work, by default
- End the chat message that shows the plan with the full absolute path to the file on its own last line, so I can copy it

## Commit messages

Imperative subject line under 50 chars, blank line, then a bulleted body: one bullet per real change, naming the actual function/file/identifier rather than describing it abstractly. Keep bullets short: no trailing periods, no unnecessary hyphens, no em dashes, no semicolons. State what changed, not why it's fine or how it was tested. Drop self-justifying or "so that..." explanatory clauses. Check `git log` before drafting so a bullet doesn't restate reasoning from a recent earlier commit. For a small or mechanical change, a subject line alone is often enough, so don't pad it into bullets it doesn't need. Start bullets lowercase.
