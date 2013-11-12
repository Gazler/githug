difficulty 4
description "You need to merge mybranch into the current branch (master). But there may be some incorrect changes in mybranch which may cause conflicts. Solve any merge-conflicts you come across and finish the merge."

setup do
  init_from_level
end

solution do
  solved = true

  solved = false unless repo.head.name == "master"
  solved = false unless repo.commits("master")[0].parents.length == 2

  txt = File.read("poem.txt")
  solved = false if txt =~ /[<>=|]/
  solved = false unless txt =~ /Sat on a wall/

  solved
end

hint do
  puts ["First you have to do a merge. Then resolve any conflicts and finish the merge", "Take a look at the sections on merge conflicts in 'git merge'.", "Remove the unnecessary lines in `poem.txt`, so only the correct poem remains."]
end
