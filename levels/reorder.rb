difficulty 4
description "You have committed several times but in the wrong order. Please reorder your commits."

setup do
  repo.init

  FileUtils.touch "README"
  repo.add        "README"
  repo.commit_all "Initial Setup"

  FileUtils.touch "file1"
  repo.add        "file1"
  repo.commit_all "First commit"

  FileUtils.touch "file3"
  repo.add        "file3"
  repo.commit_all "Third commit"

  FileUtils.touch "file2"
  repo.add        "file2"
  repo.commit_all "Second commit"
end

solution do
    `git log --format="%s"`.split.join("").match /Third.*Second.*First.*Initial/
end

hint do
  puts "Take a look the `-i` flag of the rebase command."
end
