difficulty 2
description "Create and switch to a new branch called 'my_branch'.  You will need to create a branch like you did in the previous level"

setup do
  repo.init
end

solution do
  return false unless repo.head.name == "my_branch"
  true
end

hints ["Try looking up `git checkout` and `git branch`"]
