difficulty 2

description "A file has been removed from the working tree, however the file was not removed from the repository.  Find out what this file was and remove it."

setup do
  repo.init
  file = File.new("deleteme.rb", "w")
	file.close
  repo.add("deleteme.rb")
  repo.commit_all("Added a temp file")
  File.delete("deleteme.rb")
end

solution do
  repo.status.files["deleteme.rb"].nil? || repo.status.files["deleteme.rb"].stage.nil?
end

hint do
  puts "You may need to use more than one command to complete this.  You have checked your staging area in a previous level.  Don't forget to run `git` for a list of commands."
end
