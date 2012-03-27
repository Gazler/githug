difficulty 3
description "Your new feature doesn't worth its time and you're going to delete it. But it has one commit that fills in README file, and you want this commit to be on the master as well"

setup do
    init_from_level
end

solution do
  return false unless repo.commits[1].message == "Added fancy branded output"
  return false unless repo.commits[0].message == "Filled in README.md with proper input"
  true
end

hint do
  puts "Sneak peek at the `cherry-pick` command"
end
