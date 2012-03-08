difficulty 1
description "Initialize an empty repository"

setup do
  `rm -rf .git`
end

solution do
  Grit::Repo.new(".")
end
