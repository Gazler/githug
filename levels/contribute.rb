difficulty 3
description "Contribute to this repository by making a pull request on Github"

solution do
  location = "/tmp/gitscrub"
  FileUtils.rm_rf(location)
  puts "Cloning repository to #{location}"
  `git clone git@github.com:Gazler/gitscrub.git #{location}`

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
