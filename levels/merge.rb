difficulty 2
description "We have a file in the branch 'feature'. Let's merge it with the master branch."

setup do
  init_from_level
  system "git branch -m master"
end

solution do
  File.exists?("file1")	&& File.exists?("file2")
end

hint do
  puts "You want to research the `git merge` command."
end
