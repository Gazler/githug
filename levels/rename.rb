difficulty 3

description "We have a file called `oldfile.txt`. We want to rename it to `newfile.txt` and stage this change."

setup do
  repo.init
  FileUtils.touch("oldfile.txt")
  repo.add("oldfile.txt")
  repo.commit_all("Commited oldfile.txt")
end

solution do
  repo.status["oldfile.txt"].type == "D" && repo.status["newfile.txt"].type == "A" && repo.status["oldfile.txt"].stage.nil?
end

hint do
  puts "Take a look at `git mv`."
end
