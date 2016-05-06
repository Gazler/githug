difficulty 3
description "This is the final level, the goal is to contribute to this repository by making a pull request on GitHub.  Please note that this level is designed to encourage you to add a valid contribution to Githug, not testing your ability to create a pull request.  Contributions that are likely to be accepted are levels, bug fixes and improved documentation."

solution do
  location = "/tmp/githug"
  FileUtils.rm_rf(location)
  puts "Cloning repository to #{location}"
  `git clone https://github.com/Gazler/githug #{location}`

  contributor = false

  repo = Grit::Repo.new(location)
  repo.commits('master', false).each do |commit|
    if commit.author.name == repo.config["user.name"]
      if commit.author.email == repo.config["user.email"]
        contributor = true
      end
    end
  end
  contributor
end

hint do
  puts "Forking the repository would be a good start!"
end
