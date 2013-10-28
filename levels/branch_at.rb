difficulty 3
description "You forgot to branch at the previous commit and made a commit on top of it. Create branch test_branch at the commit before the last."

setup do
  repo.init
  FileUtils.touch("file1")
  repo.add("file1")
  repo.commit_all("Adding file1")
  File.open("file1", 'w') { |f| f.write("content") }
  repo.add("file1")
  repo.commit_all("Updating file1")
  File.open("file1", 'a') { |f| f.write("\nAdding some more text") }
  repo.add("file1")
  repo.commit_all("Updating file1 again")
end

solution do
  return false unless repo.branches.map(&:name).include?("test_branch")
  repo.commits("test_branch").each { |commit| return false if commit.message ==  "Updating file1 again" }
  true
end

hint do
  puts "Just like creating a branch, but you have to pass an extra argument."
end
