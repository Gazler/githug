difficulty 2

description "Add a remote repository called `origin` with the url https://github.com/githug/githug"

setup do
  repo.init
end

solution do
  result = `git remote -v`
  result.include?("https://github.com/githug/githug")
end

hint do
  puts "You can run `git remote --help` for the man pages."
end
