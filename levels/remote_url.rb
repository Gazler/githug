difficulty 2

description "The remote repositories have a url associated to them.  Please enter the url of remote_location."

setup do
  repo.init
  repo.remote_add("my_remote_repo", "https://github.com/Gazler/githug")
  repo.remote_add("remote_location", "https://github.com/githug/not_a_repo")
end

solution do
  !!(request("What is the url of the remote repository?") =~ /https:\/\/github.com\/githug\/not_a_repo\/?/)
end

hint do
  puts "You can run `git remote --help` for the man pages."
end
