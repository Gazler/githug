difficulty 1
description "Set up your git name and email, this is important so that your commits can be identified."

setup do
  repo.init
end

solution do
  valid = false

  name = request(I18n.t("level.config.questions")[0])
  email = request(I18n.t("level.config.questions")[1])
  config_name = repo.config["user.name"]
  config_email = repo.config["user.email"]

  if name.respond_to?(:force_encoding)
    config_name = config_name.force_encoding("UTF-8")
    config_email = config_email.force_encoding("UTF-8")
  end

  if name == config_name && email == config_email
    valid = true
  end

  puts I18n.t("level.config.messages")[0] + config_name
  puts I18n.t("level.config.messages")[1] + config_email

  valid
end

hints ["These settings are config settings. You should run `git help config` if you are stuck."]
