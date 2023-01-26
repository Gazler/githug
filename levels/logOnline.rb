difficulty 2

description "Find out what the hash of the latest commit is simplified."

setup do
  repo.init
  file = File.new("longonline.rb", "w")
  repo.add("logOnline.rb")
  repo.commit_all("THIS IS THE COMMIT YOU ARE LOOKING FOR!")
end

solution do
  repo.commits.last.id_abbrev == request("What is the hash of the most recent commit?")[0..6]
end

hint do
  puts "You need to investigate the logs and find the simplified version. There is probably a command for doing that!"
end
