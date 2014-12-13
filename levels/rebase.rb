difficulty 2

description "We are using a git rebase workflow and the feature branche is ready to go into master. Let's reabse!"

setup do
  init_from_level
end

solution do
  return repo.commits('feature').last.id_abbrev != "ed0fdcf" &&
    repo.commits("feature").map(&:message) == ['add feature','add content','init commit']
end

hint do
  puts "You want to research the `git rebase` command"
end
