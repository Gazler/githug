difficulty 4
description "You need to merge the current branch (master) with mybranch. But there may be some incorrect changes in mybranch which may cause conflicts. Solve any merge-conflicts you come across and finish the merge."

setup do
  init_from_level
end

solution do
  solved = true

  solved = false unless repo.head.name == "master"
  solved = false unless repo.commits("master")[0].parents.length == 2

  txt = `cat poem.txt`
  solved = false if txt =~ /[<>=]/
  solved = false unless txt =~ /cool poem/

  solved
end

hint do
  puts ["First you have to do a merge. Then resolve any conflicts and finish the merge", "Take a look at the sections on merge conflicts in `git merge`.", "Remove the unnecessary lines in `poem.txt`."]
end
