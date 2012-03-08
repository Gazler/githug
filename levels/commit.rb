difficulty 1
description "Make a commit"

setup do
  `git init`
  `touch README`
  `git add README`
end

solution do
  repo = Grit::Repo.new(".")
  return false if repo.commits.empty?
  true
end
