difficulty 4

description "You've made changes within a single file that belong to two different features, but neither of the changes are yet staged. Stage only the changes belonging to the first feature."

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
  `git diff --no-ext-diff --no-color --staged` =~ /\+This change belongs to the first feature/ && `git diff --no-ext-diff --no-color` =~ /\+This change belongs to the second feature/
end

hint do
  puts "You might want to try to manipulate the hunks of the diff to choose which lines of the diff get staged. Read about the flags which can be passed to the `add` command; `man git-add`."
end
