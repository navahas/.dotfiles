# GIT WORKTREES

```bash
# Setup bare repo
mkdir custom-name
git clone --bare <repo-url> custom-name/.git
cd custom-name

# Configure fetch for all branches
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Add worktrees (reset local branch if exists, auto-track remote)
git worktree add $FOLDER -B $BRANCH origin/$BRANCH
# git worktree add <directory-name> -b <local-branch-name> origin/<remote-branch-name>
# git branch --set-upstream-to=origin/<branchname> <branchname>

# If ambiguous refname error, delete conflicting local branch first
git branch -D origin/$BRANCH

# Allow push to current branch
git config receive.denyCurrentBranch updateInstead
```
