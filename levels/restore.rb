difficulty 4
description "You decided to delete your latest commit by running `git reset --hard HEAD^`.  (Not a smart thing to do.)  You then change your mind, and want that commit back.  Restore the deleted commit."

setup do
  repo.init
  FileUtils.touch 'file1'
  repo.add        'file1'
  repo.commit_all 'Initial commit'

  FileUtils.touch 'file2'
  repo.add        'file2'
  repo.commit_all 'First commit'

  FileUtils.touch 'file3'
  repo.add        'file3'
  repo.commit_all 'Restore this commit'

  repo.git.native :reset, { "hard" => true }, 'HEAD^'
end

solution do
  return false unless File.exists?('file3')
  true
end

hint do
  puts "The commit is still floating around somewhere.  Have you checked out `git reflog`?"
end
