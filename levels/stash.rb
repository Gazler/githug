difficulty 2
description "You've made some changes and want to work on them later. You should save them, but don't commit them."

setup do
  init_from_level
end

solution do
  return false if `git stash list` !~ /stash@\{0\}/
  return false if repo.status.changed.to_a.flatten.include? "lyrics.txt"
  true
end

hint do
  puts "It's like stashing. Try finding appropriate git command."
end
