difficulty 3

description "We have a file called oldFile.txt. We want to rename it to newFile.txt and stage this change."

setup do
    repo.init
    FileUtils.touch("oldFile.txt")
end

solution do
    repo.status["oldFile.txt"].type == "D" && repo.status["newFile.txt"].type == "A" && repo.status["oldFile.txt"].stage.nil?
end

hint do
    puts "Take a look at `git mv`"
end
