difficulty 1
description "There are some files in this repository, some of them will not be commit - how many is it?"

setup do
  repo.init

  #File is is in the index
  %w{rybyfile1.rb rybyfile2.rb rybyfile3.rb}.each do |file|
    FileUtils.touch(file)
    repo.add(file)
  end
  repo.commit_all "Commit"

  %w{rybyfile4.rb rybyfile5.rb}.each do |file|
    FileUtils.touch(file)
    repo.add(file)
  end

  %w{rybyfile6.rb rybyfile7.rb rybyfile8.rb}.each do |file|
    FileUtils.touch(file)
  end
end

solution do

  quantity = request("How many files will not be commited?")

  if quantity != 3
    return false
  end

  true
end

hint do
  puts "You are looking for a command to identify the status of the repository."
end
