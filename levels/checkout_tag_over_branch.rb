difficulty 2

description "You need to fix a bug in the version 1.2 of your app. Checkout the tag `v1.2` (Note: There is also a branch named `v1.2`)."

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

  repo.git.native :checkout, {"b" => true}, 'v1.2'
  File.open("file3", 'w') { |f| f << "some feature\n" }
  repo.add "file3"
  repo.commit_all "Developing new features"

  repo.git.native :checkout, {}, 'master'
end

solution do
  return false unless repo.commits.length == 5
  return false unless `git show HEAD --format=%s` =~ /Some more changes/
  true
end

hint do
  puts "You should think about specifying you're after the tag named `v1.2` (think `tags/`)."
end
