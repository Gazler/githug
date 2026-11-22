difficulty 1
description "Set up your git default editor, this is important for editing commits, fixing merge conflicts and rebases. Or maybe you just like nano, we don't discriminate."

setup do
  repo.init
end

solution do
  valid = false

  editor = request("What is your default editor for git?")
  config_editor = repo.config["core.editor"]

  if editor.respond_to?(:force_encoding)
    config_editor = config_editor.force_encoding("UTF-8")
  end

  if editor == config_editor 
    valid = true
  end

  puts "Your config has the following core editor: #{config_editor}"

  valid
end

hint do
  puts "These settings are config settings. You should run `git help config` if you are stuck. In case you'd like to know what you're doing: man git-commit"
end
