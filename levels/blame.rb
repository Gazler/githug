difficulty 2
description "Someone has put a password inside the file 'config.rb' find out who it was"

setup do
  init_from_level
end

solution do

  solved = false

  offender = repo.commit("acca5adddbc031bcffde0ab414e88bdca63d73f5").author.name
  solved = true if request("Who made the commit with the password?") == offender
    
  solved
end

hint do
  puts "You want to research the `git blame` command"
end
