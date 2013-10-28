difficulty 2
description "Create and switch to a new branch called my_branch.  You will need to create a branch like you did in the previous level."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
  repo.commit_all("initial commit")
end

solution do
  return false unless repo.head.name == "my_branch"
  true
end

hint do
  puts "Try looking up `git checkout` and `git branch`."
end
