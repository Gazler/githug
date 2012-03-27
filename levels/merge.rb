difficulty 2
description "We have a file in the branch 'feature'; Let's merge it to the master branch"

setup do
	init_from_level
end

solution do
	File.exists?("file1")	&& File.exists?("file2") 
end

hints ["You want to research the `git merge` command"]
