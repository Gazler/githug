difficulty 2
description "Your project's deadline approaches, you should evaluate how many TODOs are left in your code"

setup do
  init_from_level
end

solution do
  request("How many items are there in your todolist?") == "4"
end

hint do
  puts "You want to research the `git grep` command."
end
