difficulty 2

description "You need to pull changes from your origin repository."

setup do
  repo.init
  repo.remote_add("origin", "https://github.com/pull-this/thing-to-pull")
end

solution do
  repo.commits.last.id_abbrev == "1797a7c"
end

hint do
  puts "Check out the remote repositories and research `git pull`."
end
