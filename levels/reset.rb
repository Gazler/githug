difficulty 2
description "There are two files to be committed.  The goal was to add each file as a separate commit, however both were added by accident.  Unstage the file `to_commit_second.rb` using the reset command (don't commit anything)."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
  repo.commit_all("Initial commit")
  FileUtils.touch("to_commit_first.rb")
  FileUtils.touch("to_commit_second.rb")
  repo.add(".")
end

solution do
  return false unless (repo.status.files["to_commit_second.rb"].nil? || repo.status.files["to_commit_second.rb"].stage.nil?) && File.exists?("to_commit_second.rb")
  return false if (repo.status.files["to_commit_first.rb"].nil? || repo.status.files["to_commit_first.rb"].stage.nil?)
  true
end

hint do
  puts "You can get some useful information for git status, it will tell you the command you need to run."
end
