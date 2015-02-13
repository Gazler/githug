difficulty 3
description "Merge all commits from the long-feature-branch as a single commit."

setup do
  repo.init

  FileUtils.touch "file1"
  repo.add        "file1"
  repo.commit_all "First commit"

  repo.git.native :checkout, {"b" => true}, 'long-feature-branch'
  File.open("file3", 'w') { |f| f << "some feature\n" }
  repo.add        "file3"
  repo.commit_all "Developing new features"

  File.open("file3", 'a') { |f| f << "getting awesomer\n" }
  repo.add        "file3"
  repo.commit_all "Takes"

  File.open("file3", 'a') { |f| f << "and awesomer!\n" }
  repo.add        "file3"
  repo.commit_all "Time"

  repo.git.native :checkout, {}, 'master'

  FileUtils.touch "file2"
  repo.add        "file2"
  repo.commit_all "Second commit"
end

solution do
  result = true

  # Check the number of commits in the repo (should be 4 - including initial .gitignore).
  result = false unless repo.commits.size == 3

  # Check if changes from all the commits from long-feature-branch are included.
  file = File.open('file3')
  result = false unless file.readline =~ /some feature/
  result = false unless file.readline =~ /getting awesomer/
  result = false unless file.readline =~ /and awesomer!/
  file.close

  result
end

hint do
  puts "Take a look at the `--squash` option of the merge command. Don't forget to commit the merge!"
end
