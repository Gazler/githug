difficulty 1
description "You want to work on a piece of code that has the potential to break things, create the branch test_code."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add "README"
  repo.commit_all("Initial commit")
end

solution do
  repo.branches.map(&:name).include?("test_code")
end

hint do
  puts "`git branch` is what you want to investigate."
end

