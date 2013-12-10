difficulty 2
description "There are tags in the repository that aren't pushed into remote repository. Push them now."

setup do
  # remember the working directory so we can come back to it later
  cwd = Dir.pwd
  # initialize another git repo to be used as a "remote"
  tmpdir = Dir.mktmpdir

  # local repo
  repo.init

  FileUtils.touch "file1"
  repo.add        "file1"
  repo.commit_all "First commit"
  repo.git.tag({'f' => true}, "tag_to_be_pushed")

  FileUtils.touch "file2"
  repo.add        "file2"
  repo.commit_all "Second commit"

  # copy the repo to remote
  FileUtils.cp_r ".", tmpdir

  # remote repo
  Dir.chdir tmpdir
  repo.init
  # make a 'non-bare' repo accept pushes
  `git config receive.denyCurrentBranch ignore`

  # change back to original repo to set up a remote
  Dir.chdir cwd
  `git remote add origin #{tmpdir}/.git`
  `git fetch origin`

  # delete tags from remote
  Dir.chdir tmpdir
  repo.git.tag({'d' => true}, "tag_to_be_pushed")

  # change back to local repo
  Dir.chdir cwd
end

solution do
  solved = false

  # a bit hacky solution to get tags from remote
  remote_tags=
    repo.git.raw_git_call("git ls-remote --tags .", repo.git.git_file_index).
      first.
      split("\n")

  # see if we have the correct tag in the remote
  remote_tags.each do |t|
    solved=true if t.include?("refs/tags/tag_to_be_pushed")
  end

  solved
end

hint do
  puts "Take a look at `--tags` flag of `git push`"
end
