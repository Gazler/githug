difficulty 1
description "Initialize an empty repository"

solution do
  Grit::Repo.new(".")
end
