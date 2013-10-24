difficulty 2

description "A file has accidentally been added to your staging area, find out which file and remove it from the staging area.  *NOTE* Do not remove the file from the file system, only from git."

setup do
  repo.init
  FileUtils.touch("deleteme.rb")
  repo.add(".gitignore")
  repo.add("deleteme.rb")
end

solution do
  (repo.status.files["deleteme.rb"].nil? || repo.status.files["deleteme.rb"].stage.nil?) && File.exists?("deleteme.rb")
end

hint do
  puts "You may need to use more than one command to complete this.  You have checked your staging area in a previous level.  Don't forget to run `git` for a list of commands."
end
