difficulty 3

description "A file has been modified, but you don't want to keep the modification.  Checkout the `config.rb` file from the last commit."

setup do
  repo.init
  File.open("config.rb", "w") do |file|
    file.puts("This is the initial config file")
  end

  repo.add("config.rb")
  repo.commit_all("Added initial config file")

  File.open("config.rb", "a") do |file|
    file.puts("These are changed you don't want to keep!")
  end
end

solution do
  repo.status.files["config.rb"].type != "M" && repo.commits.length == 1
end

hint do
  puts "You will need to do some research on the checkout command for this one."
end
