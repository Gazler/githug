difficulty 2
description "You committed too soon. Now you want to undo the last commit, while keeping the index."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
  repo.commit_all("Initial commit")
  FileUtils.touch("newfile.rb")
  repo.add("newfile.rb")
  repo.commit_all("Premature commit")
end

solution do
  return false unless File.exists?("newfile.rb") && repo.status.files.keys.include?("newfile.rb")
  return false if repo.status.files["newfile.rb"].untracked || repo.commit_count > 1
  true
end

hint do
  puts "What are some options you can use with `git reset`?"
end
