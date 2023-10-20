difficulty 2

description "You have created too many branches for your project. There is an old branch in your repo called 'delete_me', you should delete it."

setup do
    init_from_level
end

solution do
  return true unless repo.branches.map(&:name).include?('delete_me')
end

hint do
  puts "You can check option using git branch command so user can get better hint."
end