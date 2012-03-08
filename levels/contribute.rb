difficulty 3
description "Contribute to this repository by making a pull request on Github"

solution do
  location = "#{File.dirname(__FILE__)}/../"
  p location
  repo = Grit::Repo.new(location)
  p repo
  repo.commits.each do |commit|
    if commit.author.name == repo.config["user.name"]
      if commit.author.email == repo.config["user.email"]
        word_box "You did it!"
      end
    end
  end
  false
end
