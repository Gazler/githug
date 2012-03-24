difficulty 4

description "You've made changes within a single file that belong to two different features, but neither of the changes are yet staged. Stage and commit only the changes belonging to the first feature."

setup do
  repo.init
  File.open("feature.rb", "w") do |file|
    file.puts("this is the class of my feature")
  end

  repo.add("feature.rb")
  repo.commit_all("Added initial feature file")

  File.open("feature.rb", "a") do |file|
    file.puts("This change belongs to the first feature")
  end

  File.open("feature.rb", "a") do |file|
    file.puts("This change belongs to the second feature")
  end
end

solution do
  `git diff --staged` =~ /\+This change belongs to the first feature/ && `git diff` =~ /\+This change belongs to the second feature/
end

hint do
  puts "Read about the -p flag which can be passed to the 'add' command; man git-add. After that have a look the options available while using 'add -p' mode to manupulate hunks."
end
