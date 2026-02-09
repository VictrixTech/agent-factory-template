# Branch Protection Rules

Configure these rules in GitHub Settings > Branches > Branch protection rules for `main`:

## Required Settings

1. **Require a pull request before merging**
   - Required approvals: 1
   - Dismiss stale PR approvals when new commits are pushed: Yes

2. **Require status checks to pass before merging**
   - Required checks:
     - `Lint`
     - `Type Check`
     - `Unit Tests`
     - `Build`
   - Require branches to be up to date before merging: Yes

3. **Do not allow force pushes**

4. **Do not allow deletions**

## How to Apply

### Via GitHub CLI
```bash
gh api repos/{owner}/{repo}/branches/main/protection \
  --method PUT \
  --field required_status_checks='{"strict":true,"contexts":["Lint","Type Check","Unit Tests","Build"]}' \
  --field enforce_admins=false \
  --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
  --field restrictions=null \
  --field allow_force_pushes=false \
  --field allow_deletions=false
```

### Via GitHub UI
1. Go to Settings > Branches
2. Add rule for branch name pattern: `main`
3. Configure as described above
