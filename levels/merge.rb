difficulty 2
description "Na galezi 'feature' mamy pliki, ktore chcemy polaczyc z glowna galezia (master)."

setup do
	init_from_level
end

solution do
	File.exists?("file1")	&& File.exists?("file2")
end

hint do
  puts "Poznaj komende 'git merge'."
end
