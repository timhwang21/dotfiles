# Fix CI Build Failures

Monitor a PR's Buildkite CI build, identify failures, fix them, commit, push, and repeat until the build passes.

## Arguments

- `$ARGUMENTS` — PR number or URL (required). Optionally append a base branch (default: master).

## Workflow

### Step 1: Identify the PR

Parse the PR number from `$ARGUMENTS`. If a URL is given, extract the PR number from it.

### Step 2: Check Build Status

```bash
gh pr checks <PR_NUMBER> --json name,state,link
```

Filter for the Buildkite check (`buildkite/web-pull-request`). If it shows:
- **SUCCESS** — Report success and stop.
- **PENDING / IN_PROGRESS** — Wait and poll every 2 minutes (use `sleep 120` in background, then check again). Buildkite builds typically take ~10 minutes.
- **FAILURE** — Proceed to Step 3.

### Step 3: Investigate Failures

Use the `buildkite-test-failures` agent to get all failure details:

```
Agent(subagent_type="buildkite-test-failures", prompt="Investigate the failing Buildkite build for PR #<NUMBER>. Find all failing steps and provide specific error messages and file paths.")
```

### Step 4: Categorize Failures

Separate failures into:
1. **Caused by this PR's changes** — lint errors, spec failures in files this PR touches, type errors from new code
2. **Pre-existing / flaky** — failures in unrelated files, known flaky tests

Only fix category 1 failures. Report category 2 failures to the user but don't attempt fixes.

### Step 5: Fix Each Failure Type

**Prettier / ESLint formatting errors:**
```bash
yarn prettier --write <files>
# or
yarn eslint --fix <files>
```

**RuboCop errors:**
```bash
docker compose exec web bundle exec rubocop -A <files>
```

**RSpec failures:**
- Read the failing spec and related source files
- Identify the root cause
- Fix the source code or test setup
- Run the spec locally to verify:
  ```bash
  docker exec -i <container> bundle exec rspec --fail-fast <spec_file>
  ```

**TypeScript errors:**
- Fix the type issues in the reported files
- Verify with `yarn tsc --noEmit`

**Vitest failures:**
- Fix the failing test or source
- Verify with `yarn vitest run --bail 1 <spec_file>`

### Step 6: Commit and Push

Stage only the files you changed. Follow the repo's commit message format (load `/using-git` skill if available):

```bash
git add <specific files>
git commit -F - <<'EOF'
fix(<scope>): fix CI failures — <brief description>

<What was fixed and why>

**Potential Risk**
<risk assessment>

Worst Case Incident: SEV-4

**AI Usage**
Claude Code identified and fixed CI failures automatically.

**Testing Strategy**
- Verified fixes locally before pushing
- CI build will validate end-to-end

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
git push
```

### Step 7: Wait for New Build and Re-check

After pushing, wait ~10 minutes for the new Buildkite build, then go back to Step 2.

Repeat until the Buildkite check shows **SUCCESS** or only pre-existing/flaky failures remain.

### Step 8: Report Results

Summarize what was fixed and what remains:
- List of fixes applied (with commit SHAs)
- Any remaining failures that are pre-existing/flaky (not caused by this PR)
- Final build status
