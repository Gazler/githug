difficulty 3
description "Correct the typo in the message of your first commit."

setup do
  repo.init

  FileUtils.touch "file1"
  repo.add        "file1"
  repo.commit_all "First commmit"

  FileUtils.touch "file2"
  repo.add        "file2"
  repo.commit_all "Second commit"
end

solution do
  repo.commits[1].message == "First commit"
end

hints ["Take a look the -i flag of the rebase command."]
