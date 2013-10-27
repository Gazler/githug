difficulty 2
description "There have been modifications to the `app.rb` file since your last commit.  Find out which line has changed."

setup do
  init_from_level
end

solution do
  line = request "What is the number of the line which has changed?"
  return false unless line == "26"
  true
end

hint do
  puts "You are looking for the difference since your last commit.  Don't forget that running `git` on its own will list the possible commands."
end
