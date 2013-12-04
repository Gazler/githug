difficulty 2

description "You have created too many branches for your project. There is an old branch in your repo called 'delete_me', you should delete it."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add "README"
  repo.commit_all("Initial commit")
  repo.git.native :checkout, {"b" => true}, 'delete_me'
  repo.git.native :checkout, {}, 'master'
end

solution do
  return true unless repo.branches.map(&:name).include?('delete_me')
end

hint do
  puts "Running 'git --help branch' will give you a list of branch commands."
end