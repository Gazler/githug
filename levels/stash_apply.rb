difficulty 3
description "you have made some changes and you have some other changes stashing (i.e a 'git stash' was executed). 
You must save the latest changes without a commit and then you need to apply the first stashed changes"

setup do
  init_from_level
  `git stash`
  FileUtils.touch "stashThisFile"
  repo.add        "stashThisFile"
end

solution do
  return false if `git stash list` !~ /stash@\{1\}/
  return true if repo.status.changed.to_a.flatten.include? "lyrics.txt"
  false
end

hint do
  puts "try with `git stash apply`."
end
