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
  valid = false
  commit_messages = repo.commits.map(&:message)
  valid = true if repo.commits.length > 3 &&
    commit_messages.any? { |e| e =~ /(Revert )?"Bad commit"/ }
  valid
end

hint do
  puts "Try the revert command."
end
