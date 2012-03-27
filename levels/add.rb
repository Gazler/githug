difficulty 1
description "There is a file in your folder called README, you should add it to your staging area"

setup do
  repo.init
  FileUtils.touch("README")
end

solution do
  return false unless repo.status.files.keys.include?("README")
  return false if repo.status.files["README"].untracked
  true
end

hints ["You can type `git` in your shell to get a list of available git commands"]
