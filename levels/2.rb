difficulty 1
description "Add a file called README to your repository"
solution do
  repo = Grit::Repo.new(".")
  return false unless repo.status.files.keys == ["README"]
  return false if repo.status.files["README"].untracked
  true
end
