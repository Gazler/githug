difficulty 2
description "Grab the fixed app.rb file from the feature branch into master, but don't get the README.md file from that branch. Try to do it without copying it manually!"

setup do
  repo.init
  FileUtils.touch("app.rb")
  FileUtils.touch("README.md")
  repo.add("app.rb")
  File.write("app.rb", "Some buggy code")
  repo.add("README.md")
  File.write("README.md", "Hey! This is the master branch.")
  repo.commit_all("Initial commit")

  repo.git.native :checkout, {"b" => true}, 'other_branch'
  File.write("app.rb", "Fixed code")
  File.write("README.md", "Hey! This is the other_branch branch, and we don't want this to be included in master!")
  repo.add("app.rb")
  repo.add("README.md")
  repo.commit_all("Some more changes")

  repo.git.native :checkout, {}, 'master'
end

solution do
  return false unless repo.head.name == "master"
  readme = File.read("README.md").gsub('"', '').strip
  return false unless readme == "Hey! This is the master branch."
  app = File.read("app.rb").gsub('"', '').strip
  return false unless app == "Fixed code"
  true
end

hint do
  puts "The checkout command is gonna be useful here."
end
