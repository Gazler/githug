difficulty 2
description "Identify who put a password inside the file `config.rb`."

setup do
  init_from_level
  system "git branch -m master"
end

solution do
  offender = repo.commit("97bdd0cccf9f4b8730f78cb53a81a74f205dbcc2").author.name
  request("Who made the commit with the password?").downcase.strip == offender.downcase
end

hint do
  puts "You want to research the `git blame` command."
end
