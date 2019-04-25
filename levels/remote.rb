difficulty 2

description "This project has a remote repository.  Identify it."

setup do
  repo.init
  repo.remote_add("my-remote-repo", "https://github.com/Gazler/githug")
end

solution do
  "my-remote-repo" == request("What is the name of the remote repository?")
end

hint do
  puts "You are looking for a remote.  You can run `git` for a list of commands."
end
