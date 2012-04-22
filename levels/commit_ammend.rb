difficulty 2
description "The README file has been committed, but it looks like the file `forgotten_file.rb` was missing from the commit.  Add the file and ammend your previous commit to include it."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
  repo.commit_all("Initial commit")
  FileUtils.touch("forgotten_file.rb")
end

solution do
		
  repo.commits.length == 1 && Grit::CommitStats.find_all(repo, repo.commits.first.sha).first[1].files.length == 2
end

hint do
  puts "Running `git commit --help` will display the man page and possible flags."
end
