difficulty 2

description "There are multiple untracked files and directories cluttering your repository. Clean up your working tree by deleting all untracked files and directories."

setup do
  repo.init
  FileUtils.touch("tracked_file.txt")
  repo.add("tracked_file.txt")
  repo.commit_all("Initial commit")
  system "git branch -m master"

  FileUtils.touch("untracked_file.txt")
  FileUtils.touch("old_dump.log")
  FileUtils.mkdir_p("untracked_directory")
  FileUtils.touch("untracked_directory/temp.txt")
end

solution do
  untracked = `git status --porcelain`.lines.select { |line| line.start_with?("??") }
  untracked.empty? && File.exist?("tracked_file.txt") && !File.exist?("untracked_file.txt") && !File.exist?("untracked_directory")
end

hint do
  puts [
    "You can first perform a dry run using `git clean -n -d` to see what will be deleted.",
    "Then use `git clean -f -d` to forcefully delete untracked files and directories."
  ]
end
