difficulty 2
description "Create and switch to a new branch called 'my_branch'"

setup do
  repo.init
end

solution do
  return false unless repo.head.name == "my_branch"
  true
end

hint do
  puts "Try looking up `git checkout` and `git branch`"
end
