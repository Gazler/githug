difficulty 1
description "There are some files in this repository, one of the files is untracked, which file is it?"

setup do
  repo.init
  %w{config.rb README setup.rb deploy.rb Guardfile}.each do |file|
    FileUtils.touch(file)
    repo.add(file)
  end
  FileUtils.touch("database.yml")
end

solution do

  name = request("What is the full file name of the untracked file?")

  if name != "database.yml"
    return false
  end

  true
end

hint do
  puts "You are looking for a command to identify the status of the repository."
end
