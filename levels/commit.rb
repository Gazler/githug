difficulty 1
description "Make a commit"

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
end

solution do
  repo = Grit::Repo.new(".")
  return false if repo.commits.empty?
  true
end
