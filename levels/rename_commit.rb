difficulty 3
description "Correct the typos in the message of your last commit."

setup do
  repo.init

  FileUtils.touch "README"
  repo.add        "README"
  repo.commit_all "Adding README"

  FileUtils.touch "file1"
  repo.add        "file1"
  repo.commit_all "A fresh commmit"
end

solution do
  repo.commits.first.message == "A fresh commit"
end

hint do
  puts "Take a look at the --amend flag of the commit command"
end
