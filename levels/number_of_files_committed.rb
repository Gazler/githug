difficulty 1
description "There are some files in this repository, how many of the files will be committed?"

setup do
  repo.init

  #Modified files
  %w{rubyfile4.rb rubyfile5.rb}.each do |file|
    FileUtils.touch(file)
    repo.add(file)
  end
  repo.commit_all "Commit"

  #Staged file
  File.open("rubyfile4.rb", 'w') { |f| f << "#Changes" }
  repo.add("rubyfile4.rb")

  #Not staged file
  File.open("rubyfile5.rb", 'w') { |f| f << "#Changes" }

  #Changes to be committed
  %w{rubyfile1.rb}.each do |file|
    FileUtils.touch(file)
    repo.add(file)
  end  

  #Untrached files
  %w{rubyfile6.rb rubyfile7.rb}.each do |file|
    FileUtils.touch(file)
  end
end

solution do
  numberOfFilesThereWillBeCommit = request("How many changes are going to be committed?")

  isInteger = !!(numberOfFilesThereWillBeCommit =~ /^[-+]?[0-9]+$/)

  if !isInteger
    return false
  end

  if numberOfFilesThereWillBeCommit.to_i == 2
    return true
  end

  return false
end

hint do
  puts "You are looking for a command to identify the status of the repository."
end
