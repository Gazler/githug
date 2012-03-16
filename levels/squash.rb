difficulty 4
description "You have committed several times but would like all those changes to be one commit"

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
  repo.commit_all("Adding README")
  File.open("README", 'w') { |f| f.write("hey there") }
  repo.add("README")
  repo.commit_all("Updating README")
  File.open("README", 'a') { |f| f.write("\nAdding some more text") }
  repo.add("README")
  repo.commit_all("Updating README")
  File.open("README", 'a') { |f| f.write("\neven more text") }
  repo.add("README")
  repo.commit_all("Updating README")
end

solution do
  repo.commits.length == 2
end

hint do
  puts "Take a look the -i flag of the rebase command"
end
