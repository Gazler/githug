difficulty 1
description "The `README` file has been added to your staging area, now commit it."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
end

solution do
  return false if repo.commits.empty?
  true
end

hint do
  puts "You must include a message when you commit."
end
