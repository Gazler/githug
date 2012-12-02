difficulty 2
description "You've made some changes and want to work on them later. You should save them, but don't commit them"

setup do
  init_from_level
end

solution do
  return false unless `git stash list` =~ /stash@\{0\}/ && !repo.status.files['lyrics.txt'].changed
  true
end

hint do
  "It's like stashing. Try finding appropriate git command"
end
