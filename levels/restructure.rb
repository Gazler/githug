difficulty 3

description "You added some files to your repository, but now realize that your project needs to be restructured.  Make a new folder named `src`, and move all of the .html files into this folder."

setup do
  repo.init

  FileUtils.touch("index.html")
  repo.add("index.html")
  repo.commit_all("adding index page.")

  FileUtils.touch("about.html")
  repo.add("about.html")
  repo.commit_all("adding about page.")

  FileUtils.touch("contact.html")
  repo.add("contact.html")
  repo.commit_all("adding contact page.")
end

solution do
  index = repo.status["index.html"].type == "D" && repo.status["index.html"].stage.nil? && repo.status["src/index.html"].type == "A"
  about = repo.status["about.html"].type == "D" && repo.status["about.html"].stage.nil? && repo.status["src/about.html"].type == "A"
  contact = repo.status["contact.html"].type == "D" && repo.status["contact.html"].stage.nil? && repo.status["src/contact.html"].type == "A"
  index && about && contact
end

hint do
  puts "You'll have to use mkdir, and `git mv`."
end
