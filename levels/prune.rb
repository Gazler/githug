difficulty 2
description "You have stash stuff and you have some changes. You should stash latest changes and apply the old stash."
setup do
  repo.init
  FileUtils.touch("aplly-file")
  FileUtils.touch("stash-file")
end

solution do
  return false unless repo.status.files.keys.include?("aplly-file")
  return false unless repo.status.files.keys.include?("stash-file")
  true
end

hint do
  puts "You can use $(git stash apply stash@\{i\})."
end
	
