difficulty 3

description "Your project`s a bit cluttered, and needs to be restructured.  Make two new folders named `database` and `src`.  Then move the *.sql files to the `database` folder, and move the *.html files to the `src` folder."

setup do
  repo.init

  FileUtils.touch("index.html")
  repo.add("index.html")
  repo.commit_all("adding index page.")

  FileUtils.touch("about.html")
  repo.add("about.html")
  repo.commit_all("adding about page.")

  FileUtils.touch("schema.sql")
  repo.add("schema.sql")
  FileUtils.touch("data.sql")
  repo.add("data.sql")
  repo.commit_all("adding database schema, and data.")
end

solution do
  repo.status["about.html"].type == "D" &&
  repo.status["about.html"].stage.nil? &&
  repo.status["src/about.html"].type == "A" &&
  repo.status["index.html"].type == "D" &&
  repo.status["index.html"].stage.nil? &&
  repo.status["src/index.html"].type == "A" &&
  repo.status["schema.sql"].type == "D" &&
  repo.status["schema.sql"].stage.nil? &&
  repo.status["database/schema.sql"].type == "A" &&
  repo.status["data.sql"].type == "D" &&
  repo.status["data.sql"].stage.nil? &&
  repo.status["database/data.sql"].type == "A"
end

hint do
  puts "You'll have to use mkdir, and `git mv`."
end

