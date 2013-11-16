require 'time'

difficulty 2
description "Commit your changes with the future date (e.g. tomorrow)."

setup do
  repo.init

  FileUtils.touch("README")
  repo.add("README")
end

solution do
  repo.commits.length == 1 && repo.commits.first.authored_date > Time.now
end

hint do
  puts "Build a time machine, move to the future and commit your changes, then go back and verify results ;)."
end
