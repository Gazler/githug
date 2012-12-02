difficulty 2

description "You will be asked for the first 7 chars of the hash of most recent commit.  You will need to investigate the logs of the repository for this."

setup do
  repo.init
  file = File.new("newfile.rb", "w")
  repo.add("newfile.rb")
  repo.commit_all("THIS IS THE COMMIT YOU ARE LOOKING FOR!")
end

solution do
  repo.commits.last.id_abbrev == request("What are the first 7 characters of the hash of the most recent commit?")
end

hint do
  puts "You need to investigate the logs.  There is probably a command for doing that!"
end
