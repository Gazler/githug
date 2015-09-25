difficulty 4
description "You have committed several times but want to undo the middle commit.
All commits have been pushed, so you can't change existing history."

setup do
  repo.init

  FileUtils.touch "file1"
  repo.add        "file1"
  repo.commit_all "First commit"

  FileUtils.touch "file3"
  repo.add        "file3"
  repo.commit_all "Bad commit"

  FileUtils.touch "file2"
  repo.add        "file2"
  repo.commit_all "Second commit"
end

solution do
  repo.commits.length > 3 &&
    repo.commits[3].message == "Second commit" &&
    repo.commits[2].message == "Bad commit" &&
    repo.commits[1].message == "First commit" &&
    repo.commits[0].message.split("\n").first == "Revert \"Bad commit\""
end

hint do
  puts "Try the revert command."
end
