# Git Workflow with Worktree

$ARGUMENTS

1. Understand the user's request.
2. Create a worktree with `git wtba <BRANCH_NAME>` command.
  - `git wtab` will create worktree directory and add branch, and run setup script if it exists.
  - Choose the branch name based on the user's request.
3. Switch to the worktree directory.
4. Make changes in the worktree directory.
  - It is recommended to write failing tests first when fixing bugs.
5. Commit changes.
  - If it becomes a long task, you should commit changes in small steps so that you can revert to the previous state if needed.
6. Push changes.
7. Create a pull request.
8. Monitor GitHub Actions checks.
9. Help fix issues if checks fail.
10. Go back to the original directory.
11. Delete the worktree with `git wtd <BRANCH_NAME>` command.