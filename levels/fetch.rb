difficulty 2
description "Looks like a new branch was pushed into our remote repository. Get the changes without merging them with the local repository "

setup do
  # remember the working directory so we can come back to it later
  cwd = Dir.pwd
  # initialize another git repo to be used as a "remote"
  tmpdir = Dir.mktmpdir

  # local repo
  repo.init

    #adds a file to origin/master
  FileUtils.touch "master_file"
  repo.add        "master_file"
  repo.commit_all 'Commits master_file'

  # remote repo
  Dir.chdir tmpdir
  repo.init

  #adds a file to origin/master
  FileUtils.touch "master_file"
  repo.add        "master_file"
  repo.commit_all 'Commits master_file'
  
  #adds remote repo
  Dir.chdir cwd
  `git remote add origin #{tmpdir}/.git`
  `git fetch origin --quiet`
  `git branch -u origin/master master 2> /dev/null`

  Dir.chdir tmpdir
  # create a new branch in the remote repo
  `git checkout -b new_branch --quiet`

  # adds a file into the new branch.  Should not be pulled into the local
  FileUtils.touch "file1"
  repo.add        "file1"
  repo.commit_all 'Commits file 1'
  
end

solution do
  repo.init
  result = true


  # counts the number of local branches. Should equal 1
  local_branches = repo.branches.size

  # after a git fetch command, each branch will be stored in in the .git/FETCH_HEAD file. Each branch is on its own line
  # This command will count the number of lines, which will give the number of branches 
  if File.file?('.git/FETCH_HEAD') #checks for file existance
  	num_remote = File.read(".git/FETCH_HEAD").split("\n").count
  else
  	num_remote = 0
  end

  # there should be 1 local branch and 2 remote branches for a success condition
  if local_branches == 1 and num_remote == 2
  	result = true
  else
  	result = false
  end 
end

hint do
  puts "Look up the 'git fetch' command"
end
