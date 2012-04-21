difficulty 3
description "This is the final level, the goal is to contribute to this repository by making a pull request on Github.  Please note that this level is designed to encourage you to add a valid contribution to Githug, not testing your ability to create a pull request.  Contributions that are likely to be accepted are levels, bug fixes and improved documentation."

solution do
  location = "/tmp/githug"
  FileUtils.rm_rf(location)
  puts "Cloning repository to #{location}"
  `git clone git@github.com:Gazler/githug.git #{location}`

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

hints ["Forking the repository would be a good start!"]
