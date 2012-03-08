difficulty 1
description "There is a file in your folder called README, you should add it to your staging area"

setup do
  repo.init
  FileUtils.touch("README")
end

solution do
  return false unless repo.status.files.keys == ["README"]
  return false if repo.status.files["README"].untracked
  true
end
