difficulty 4
description "You have been working on a branch but got distracted by a major issue. Switch back to that branch even though you forgot the name of it."

setup do
  init_from_level
end

solution do
  return false unless repo.head.name == "solve_world_hunger"
  true
end

hint do
  puts "Ever played with the `git reflog` command?"
end
