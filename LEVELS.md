# Githug Levels

A complete guide to all **56 levels** in Githug, ordered from beginner to advanced. Each level teaches a different Git concept through hands-on practice.

> **Difficulty Scale:** 1 = Beginner | 2 = Intermediate | 3 = Advanced | 4 = Expert

---

## Getting Started

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 1 | **init** | 1 | A new directory, `git_hug`, has been created; initialize an empty repository in it. |
| 2 | **config** | 1 | Set up your git name and email; this is important so that your commits can be identified. |
| 3 | **add** | 1 | There is a file in your folder called `README`; add it to your staging area. _(Note: Each level starts with a new repo. Don't look for files of the previous one.)_ |
| 4 | **commit** | 1 | The `README` file has been added to your staging area, now commit it. |
| 5 | **clone** | 1 | Clone the repository at `https://github.com/Gazler/cloneme`. |
| 6 | **clone_to_folder** | 1 | Clone the repository at `https://github.com/Gazler/cloneme` into the folder `my_cloned_repo`. |

<details>
<summary>Solutions (Getting Started)</summary>

**Level 1 - init**
```bash
git init
```

**Level 2 - config**
```bash
git config user.name "Your Name"
git config user.email "your@email.com"
```

**Level 3 - add**
```bash
git add README
```

**Level 4 - commit**
```bash
git commit -m "Initial commit"
```

**Level 5 - clone**
```bash
git clone https://github.com/Gazler/cloneme
```

**Level 6 - clone_to_folder**
```bash
git clone https://github.com/Gazler/cloneme my_cloned_repo
```

</details>

---

## Working with Files

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 7 | **ignore** | 2 | The text editor 'vim' creates files ending in `.swp` (swap files) for all files that are currently open. We don't want them creeping into the repository. Make this repository ignore those swap files which are ending in `.swp`. |
| 8 | **include** | 2 | Notice a few files with the `.a` extension. We want git to ignore all the files except the `lib.a` file. |
| 9 | **status** | 1 | Among the files in this repository, which of them is untracked? |
| 10 | **number_of_files_committed** | 1 | There are some files in this repository; how many of them are staged for a commit? |
| 11 | **rm** | 2 | A file has been removed from the working tree, but not from the repository. Identify this file and remove it. |
| 12 | **rm_cached** | 2 | A file has accidentally been added to your staging area. Identify and remove it from the staging area. _(Note: Do not remove the file from the file system, only from git.)_ |
| 13 | **stash** | 2 | You've made some changes and want to work on them later. You should save them, but don't commit them. |
| 14 | **rename** | 3 | We have a file called `oldfile.txt`. We want to rename it to `newfile.txt` and stage this change. |
| 15 | **restructure** | 3 | You added some files to your repository, but now realize that your project needs to be restructured. Make a new folder named `src` and use Git to move all of the `.html` files into this folder. |

<details>
<summary>Solutions (Working with Files)</summary>

**Level 7 - ignore**
```bash
echo "*.swp" >> .gitignore
```

**Level 8 - include**
```bash
echo "*.a" >> .gitignore
echo "!lib.a" >> .gitignore
```

**Level 9 - status**
```bash
git status
# Answer: database.yml
```

**Level 10 - number_of_files_committed**
```bash
git status
# Answer: 2
```

**Level 11 - rm**
```bash
git rm deleteme.rb
```

**Level 12 - rm_cached**
```bash
git rm --cached deleteme.rb
```

**Level 13 - stash**
```bash
git stash
```

**Level 14 - rename**
```bash
git mv oldfile.txt newfile.txt
```

**Level 15 - restructure**
```bash
mkdir src
git mv *.html src/
```

</details>

---

## History and Tags

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 16 | **log** | 2 | Identify the hash of the latest commit. |
| 17 | **tag** | 2 | We have a git repo and we want to tag the current commit with `new_tag`. |
| 18 | **push_tags** | 2 | A tag in the local repository isn't pushed into the remote repository. Push it now. |
| 19 | **commit_amend** | 2 | The `README` file has been committed, but it looks like the file `forgotten_file.rb` was missing from the commit. Add the file and amend your previous commit to include it. |
| 20 | **commit_in_future** | 2 | Commit your changes with a future date (e.g. tomorrow). |

<details>
<summary>Solutions (History and Tags)</summary>

**Level 16 - log**
```bash
git log
# Answer: the full hash of the latest commit
```

**Level 17 - tag**
```bash
git tag new_tag
```

**Level 18 - push_tags**
```bash
git push origin --tags
```

**Level 19 - commit_amend**
```bash
git add forgotten_file.rb
git commit --amend
```

**Level 20 - commit_in_future**
```bash
git commit --date="2026-10-01T00:00:00" -m "Commit in future"
```

</details>

---

## Undoing Changes

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 21 | **reset** | 2 | There are two files to be committed. The goal was to add each file as a separate commit, however both were added by accident. Unstage the file `to_commit_second.rb` using the reset command (don't commit anything). |
| 22 | **reset_soft** | 2 | You committed too soon. Now you want to undo the last commit, while keeping the index. |
| 23 | **checkout_file** | 3 | A file has been modified, but you don't want to keep the modification. Checkout the `config.rb` file from the last commit. |

<details>
<summary>Solutions (Undoing Changes)</summary>

**Level 21 - reset**
```bash
git reset HEAD to_commit_second.rb
```

**Level 22 - reset_soft**
```bash
git reset --soft HEAD^
```

**Level 23 - checkout_file**
```bash
git checkout -- config.rb
```

</details>

---

## Remotes and Syncing

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 24 | **remote** | 2 | This project has a remote repository. Identify it. |
| 25 | **remote_url** | 2 | The remote repositories have a URL associated to them. Please enter the URL of `remote_location`. |
| 26 | **pull** | 2 | You need to pull changes from your origin repository. |
| 27 | **remote_add** | 2 | Add a remote repository called `origin` with the URL `https://github.com/githug/githug`. |
| 28 | **push** | 3 | Your local master branch has diverged from the remote `origin/master` branch. Rebase your branch onto `origin/master` and push it to remote. |

<details>
<summary>Solutions (Remotes and Syncing)</summary>

**Level 24 - remote**
```bash
git remote
# Answer: my_remote_repo
```

**Level 25 - remote_url**
```bash
git remote -v
# Answer: https://github.com/githug/not_a_repo
```

**Level 26 - pull**
```bash
git pull origin master
```

**Level 27 - remote_add**
```bash
git remote add origin https://github.com/githug/githug
```

**Level 28 - push**
```bash
git rebase origin/master
git push origin master
```

</details>

---

## Inspecting and Comparing

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 29 | **diff** | 2 | Since your last commit, file `app.rb` was modified. Find out which line has changed. |
| 30 | **blame** | 2 | Identify who put a password inside the file `config.rb`. |

<details>
<summary>Solutions (Inspecting and Comparing)</summary>

**Level 29 - diff**
```bash
git diff
# Answer: 26
```

**Level 30 - blame**
```bash
git blame config.rb
# Answer: Spider Man
```

</details>

---

## Branching

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 31 | **branch** | 1 | To work on a piece of code that has the potential to break things, create the branch `test_code`. |
| 32 | **checkout** | 2 | Create and switch to a new branch called `my_branch`. You will need to create a branch like you did in the previous level. |
| 33 | **checkout_tag** | 2 | You need to fix a bug in the version 1.2 of your app. Checkout the tag `v1.2`. |
| 34 | **checkout_tag_over_branch** | 2 | You need to fix a bug in the version 1.2 of your app. Checkout the tag `v1.2`. _(Note: There is also a branch named `v1.2`.)_ |
| 35 | **branch_at** | 3 | You forgot to branch at the previous commit and made a commit on top of it. Create the branch `test_branch` at the commit before the last. |
| 36 | **delete_branch** | 2 | You have created too many branches for your project. There is an old branch in your repo called `delete_me`, you should delete it. |
| 37 | **push_branch** | 2 | You've made some changes to a local branch and want to share it, but aren't yet ready to merge it with the `master` branch. Push only `test_branch` to the remote repository. |

<details>
<summary>Solutions (Branching)</summary>

**Level 31 - branch**
```bash
git branch test_code
```

**Level 32 - checkout**
```bash
git checkout -b my_branch
```

**Level 33 - checkout_tag**
```bash
git checkout v1.2
```

**Level 34 - checkout_tag_over_branch**
```bash
git checkout tags/v1.2
```

**Level 35 - branch_at**
```bash
git branch test_branch HEAD~1
```

**Level 36 - delete_branch**
```bash
git branch -d delete_me
```

**Level 37 - push_branch**
```bash
git push origin test_branch
```

</details>

---

## Merging and Rebasing

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 38 | **merge** | 2 | We have a file in the branch `feature`. Let's merge it with the master branch. |
| 39 | **fetch** | 2 | Looks like a new branch was pushed into our remote repository. Get the changes without merging them with the local repository. |
| 40 | **rebase** | 2 | We are using a git rebase workflow and the feature branch is ready to go into master. Let's rebase the feature branch onto our master branch. |
| 41 | **rebase_onto** | 2 | You have created your branch from `wrong_branch` and already made some commits, and you realise that you needed to create your branch from `master`. Rebase your commits onto `master` branch so that you don't have `wrong_branch` commits. |
| 42 | **repack** | 2 | Optimise how your repository is packaged ensuring that redundant packs are removed. |
| 43 | **cherry-pick** | 3 | Your new feature isn't worth the time and you're going to delete it. But it has one commit that fills in `README` file, and you want this commit to be on the master as well. |

<details>
<summary>Solutions (Merging and Rebasing)</summary>

**Level 38 - merge**
```bash
git merge feature
```

**Level 39 - fetch**
```bash
git fetch origin
```

**Level 40 - rebase**
```bash
git rebase master feature
```

**Level 41 - rebase_onto**
```bash
git rebase --onto master wrong_branch readme-update
```

**Level 42 - repack**
```bash
git repack -d
```

**Level 43 - cherry-pick**
```bash
git log new-feature   # find the commit hash for "Filled in README.md"
git cherry-pick <commit-hash>
```

</details>

---

## Searching and Debugging

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 44 | **grep** | 2 | Your project's deadline approaches, you should evaluate how many TODOs are left in your code. |

<details>
<summary>Solutions (Searching and Debugging)</summary>

**Level 44 - grep**
```bash
git grep TODO
# Answer: 4
```

</details>

---

## Rewriting History

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 45 | **rename_commit** | 3 | Correct the typo in the message of your first (non-root) commit. |
| 46 | **squash** | 4 | You have committed several times but would like all those changes to be one commit. |
| 47 | **merge_squash** | 3 | Merge all commits from the `long-feature-branch` as a single commit. |
| 48 | **reorder** | 4 | You have committed several times but in the wrong order. Please reorder your commits. |
| 49 | **bisect** | 3 | A bug was introduced somewhere along the way. You know that running `ruby prog.rb 5` should output 15. You can also run `make test`. What are the first 7 chars of the hash of the commit that introduced the bug? |
| 50 | **stage_lines** | 4 | You've made changes within a single file that belong to two different features, but neither of the changes are yet staged. Stage only the changes belonging to the first feature. |

<details>
<summary>Solutions (Rewriting History)</summary>

**Level 45 - rename_commit**
```bash
git rebase -i HEAD~2
# Change "pick" to "reword" on the line with "First coommit"
# Save and close, then correct the message to "First commit"
```

**Level 46 - squash**
```bash
git rebase -i HEAD~4
# Change "pick" to "squash" (or "s") for the last 3 commits
# Save and close, then write a combined commit message
```

**Level 47 - merge_squash**
```bash
git merge --squash long-feature-branch
git commit -m "Merged long-feature-branch"
```

**Level 48 - reorder**
```bash
git rebase -i HEAD~3
# Reorder the lines so commits appear in the correct order
```

**Level 49 - bisect**
```bash
git bisect start HEAD <known-good-commit>
git bisect run make test
# Answer: the first 7 characters of the bad commit hash (18ed2ac)
```

**Level 50 - stage_lines**
```bash
git add -p feature.rb
# Split the hunk with "s", then stage only the first feature's changes
# with "y" and skip the second feature's changes with "n"
```

</details>

---

## Expert Challenges

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 51 | **find_old_branch** | 4 | You have been working on a branch but got distracted by a major issue. Switch back to that branch even though you forgot the name of it. |
| 52 | **revert** | 4 | You have committed several times but want to undo the middle commit. All commits have been pushed, so you can't change existing history. |
| 53 | **restore** | 4 | You decided to delete your latest commit by running `git reset --hard HEAD^` (not a smart thing to do). Now you changed your mind and want that commit back. Restore the deleted commit. |
| 54 | **conflict** | 4 | You need to merge `mybranch` into the current branch (master). But there may be some incorrect changes in `mybranch` which may cause conflicts. Solve any merge-conflicts you come across and finish the merge. |
| 55 | **submodule** | 2 | You want to include the files from the following repo: `https://github.com/jackmaney/githug-include-me` into the folder `./githug-include-me`. Do this without manually cloning the repo or copying the files from the repo into this repo. |

<details>
<summary>Solutions (Expert Challenges)</summary>

**Level 51 - find_old_branch**
```bash
git reflog
# Find the branch name you were on (solve_world_hunger)
git checkout solve_world_hunger
```

**Level 52 - revert**
```bash
git revert HEAD~1
```

**Level 53 - restore**
```bash
git reflog
# Find the hash of the deleted commit
git reset --hard HEAD@{1}
```

**Level 54 - conflict**
```bash
git merge mybranch
# Edit poem.txt to resolve conflicts - remove conflict markers and keep the correct lines
git add poem.txt
git commit
```

**Level 55 - submodule**
```bash
git submodule add https://github.com/jackmaney/githug-include-me githug-include-me
```

</details>

---

## The Final Level

| # | Level | Difficulty | Description |
|---|-------|:----------:|-------------|
| 56 | **contribute** | 3 | This is the final level, the goal is to contribute to this repository by making a pull request on GitHub. Please note that this level is designed to encourage you to add a valid contribution to Githug, not testing your ability to create a pull request. Contributions that are likely to be accepted are levels, bug fixes and improved documentation. |

<details>
<summary>Solution (The Final Level)</summary>

**Level 56 - contribute**

1. Fork the Githug repository on GitHub
2. Clone your fork locally
3. Make a meaningful contribution (new level, bug fix, or documentation improvement)
4. Commit and push your changes
5. Open a Pull Request against the original repository

</details>

---

## Difficulty Breakdown

| Difficulty | Level | Count |
|------------|:-----:|:-----:|
| Beginner | 1 | 9 |
| Intermediate | 2 | 27 |
| Advanced | 3 | 11 |
| Expert | 4 | 9 |

> **Tip:** Run `githug` to start playing, and `githug hint` if you get stuck on a level!
