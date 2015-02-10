difficulty 2
description "You've made some changes to a local branch and want to share it, but aren't yet ready to merge it with the 'master' branch.  Push only 'test_branch' to the remote repository"

setup do

  # remember the working directory so we can come back to it later
  cwd = Dir.pwd
  # initialize another git repo to be used as a "remote"
  tmpdir = Dir.mktmpdir

  # local repo
  repo.init

  FileUtils.touch "file1"
  repo.add        "file1"
  repo.commit_all "committed changes on master"

  # copy the repo to remote
  FileUtils.cp_r ".", tmpdir

  # add another file.  If successful this file won't be pushed to the remote repository
  FileUtils.touch "file2"
  repo.add        "file2"
  repo.commit_all "If this commit gets pushed to repo, then you have lost the level :( "

  #This branch should not be pushed to to the remote repository
  `git checkout -b other_branch --quiet`
  # add another file
  FileUtils.touch "file3"
  repo.add        "file3"
  repo.commit_all "If this commit gets pushed to repo, then you have lost the level :( "

  `git checkout -b test_branch --quiet`

  #This file should get pushed if the level is successful
  FileUtils.touch "file4"
  repo.add        "file4"
  repo.commit_all "committed change on test_branch"

  # remote repo
  Dir.chdir tmpdir

  repo.init

  # make a 'non-bare' repo accept pushes
  `git config receive.denyCurrentBranch ignore`

  # change back to original repo to set up a remote
  Dir.chdir cwd
  `git remote add origin #{tmpdir}/.git`
  `git fetch --quiet origin`
  `git branch -u origin/master master 2> /dev/null`

  `git checkout master --quiet` #return to master branch
end

solution do
  repo.init
  result = false

  #each branch consits of one line, `wc -l counts the number of lines in order to get the number of remote branches`
  #At the moment Grit doesn't support remote branch references but is on the ToDo list.  This should be revisited when Grit implements the change
  num_remote_branches = `git branch -r`.split("\n").count

  # counts the number of commits in the remote master branch'
  remote_master_commits = repo.commits('origin/master').count
  remote_test_branch_commits = repo.commits('origin/test_branch').count #if returns 0 indicates that the remote test_branch doesn't exist

  #Level will be successful if the remote master branch remains at 1 commit, the remote test_branch exits and the number of remote branches
  if remote_master_commits == 1 and remote_test_branch_commits > 0 and num_remote_branches == 2
    result = true

  #User pushed up too many branches, level failed
  elsif num_remote_branches > 2
    puts "*** It looks like you pushed up too many branches. You need to make sure only 'test_branch' gets pushed. Please try again! ***"

  #User pushed up the master banch, level failed
  elsif remote_master_commits > 1
    puts "*** It looks like you pushed up new master branch changes. You need to make sure only 'test_branch' gets pushed. Please try again! ***"
  end

  result
end

hint do
  puts "Investigate the options in `git push` using `git push --help`"
end
