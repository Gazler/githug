difficulty 2
description "We have a file in the branch 'feature'; Let's merge it to the master branch"

setup do
  init_from_level
end

solution do
  `ls`.strip().split() == ["file1", "file2"]
end

hint do
  puts "You want to research the `git merge` command"
end
