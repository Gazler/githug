difficulty 1
description "There is a file in your folder called README, you should add it to your staging area"

setup do
  `git init`
  `touch README`
end

solution do
  repo = Grit::Repo.new(".")
  return false unless repo.status.files.keys == ["README"]
  return false if repo.status.files["README"].untracked
  true
end
