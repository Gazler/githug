difficulty 4
description "You have committed several times but want to undo the middle commit."

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
  return false unless repo.commits[3].message == "First commit"
  return false unless repo.commits[2].message == "Second commit"
  return false unless repo.commits[1].message == "Bad commit"
  return false unless repo.commits[0].message.split("\n").first == "Revert \"Bad commit\""
  true
end

hint do
  puts "Try the revert command."
end
