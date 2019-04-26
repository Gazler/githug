difficulty 2

description "Find out what the hash of the latest commit is."

setup do
  repo.init
  file = File.new("newfile.rb", "w")
  repo.add("newfile.rb")
  repo.commit_all("THIS IS THE COMMIT YOU ARE LOOKING FOR!")
end

solution do
  repo.commits.last.id_abbrev == request("What is the hash of the most recent commit?")[0..6]
end

hint do
  puts "You need to investigate the logs. There is probably a command for doing that!"
end
