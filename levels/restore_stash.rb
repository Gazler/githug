difficulty 2
description "You've just stashed some changes, but now you want to restore them."

setup do
  init_from_level
end

solution do
  return true if (repo.status.files["README.md"].type=="M")
  false
end

hint do
  puts "The answer to the previous level should help you out here"
end
