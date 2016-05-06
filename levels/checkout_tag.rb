difficulty 2

description "You need to fix a bug in the version 1.2 of your app. Checkout the tag `v1.2`."

setup do
  repo.init
  FileUtils.touch("app.rb")
  repo.add("app.rb")
  repo.commit_all("Initial commit")

  `echo "Some code" >> app.rb`
  repo.add("app.rb")
  repo.commit_all("Some changes")
  repo.git.tag( { 'f' => true }, "v1.0" )

  `echo "Buggy code" >> app.rb`
  repo.add("app.rb")
  repo.commit_all("Some more changes")
  repo.git.tag( { 'f' => true }, "v1.2" )

  `echo "More code" >> app.rb`
  repo.add("app.rb")
  repo.commit_all("Yet more changes")

  `echo "Some more code" >> app.rb`
  repo.add("app.rb")
  repo.commit_all("Changes galore")
  repo.git.tag( { 'f' => true }, "v1.5" )
end

solution do
  return false unless repo.commits.length == 5
  return false unless `git show HEAD --format=%s` =~ /Some more changes/
  true
end

hint do
  puts "There's no big difference between checking out a branch and checking out a tag."
end
