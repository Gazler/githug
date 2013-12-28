difficulty 3

description "You realize that your project need to be restructured.  Make a new folder named `src`, and move the .html file into this folder."

setup do
  repo.init

  FileUtils.touch("index.html")
  repo.add("index.html")
  repo.commit_all("adding index page.")
end

solution do
  repo.status["index.html"].type == "D" && repo.status["index.html"].stage.nil? && repo.status["src/index.html"].type == "A"
end

hint do
  puts "You'll have to use mkdir, and `git mv`."
end
