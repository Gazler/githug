difficulty 2

description "You have created your branch from `wrong_branch` and already made some commits, \
and you realise that you needed to create your branch from `master`. \
Rebase your commits onto `master` branch so that you don't have `wrong_branch` commits."

setup do
  readme_file  = "README.md"
  authors_file = "authors.md"

  repo.init
  FileUtils.touch(authors_file)
  File.open(authors_file, "w") { |f| f << "https://github.com/janis-vitols\n" }
  repo.add(authors_file)
  repo.commit_all("Create authors file")

  repo.git.native :checkout, { "b" => true }, "wrong_branch"
  File.open(authors_file, "w") { |f| f << "None\n" }
  repo.add(authors_file)
  repo.commit_all("Wrong changes")

  repo.git.native :checkout, { "b" => true }, "readme-update"
  FileUtils.touch(readme_file)
  File.open(readme_file, "a") { |f| f << "# SuperApp\n" }
  repo.add(readme_file)
  repo.commit_all("Add app name in readme")
  File.open(readme_file, "a") { |f| f << "## About\n" }
  repo.add(readme_file)
  repo.commit_all("Add `About` header in readme")
  File.open(readme_file, "a") { |f| f << "## Install\n" }
  repo.add(readme_file)
  repo.commit_all("Add `Install` header in readme")
end

solution do
  repo.commits("readme-update").each { |commit| return false if commit.message ==  "Wrong changes" }
  return false unless repo.commits("readme-update").length == 4
  return false unless File.readlines("authors.md").include?("https://github.com/janis-vitols\n")

  true
end

hint do
  puts "You want to research the `git rebase` commands `--onto` argument"
end
