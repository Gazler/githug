difficulty 1
description "Set up your git name and email, this is important so that your commits can be identified."

setup do
  repo.init
end

solution do
  valid = false

  name = request("What is your name?")
  email = request("What is your email?")
  config_name = repo.config["user.name"]
  config_email = repo.config["user.email"]

  if name.respond_to?(:force_encoding)
    config_name = config_name.force_encoding("UTF-8")
    config_email = config_email.force_encoding("UTF-8")
  end

  if name == config_name && email == config_email
    valid = true
  end

  puts "Your config has the following name: #{config_name}"
  puts "Your config has the following email: #{config_email}"

  valid
end

hint do
  puts "These settings are config settings.  You should run `git help config` if you are stuck."
end
