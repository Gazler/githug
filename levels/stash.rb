difficulty 2
description "Zrobiles kilka zmian z ktorymi chcesz pracowac pozniej. Powinienes zamisac je, ale nie commitowac."
	
end

setup do
  init_from_level
end

solution do
  return false if `git stash list` !~ /stash@\{0\}/
  return false if repo.status.changed.to_a.flatten.include? "lyrics.txt"
  true
end

hint do
  puts "Sprobuj znalezc odpowiednia komende, ktora 'schowa' Twoje zmiany."
end
