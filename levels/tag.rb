difficulty 2

description "We have a git repo and we want to tag the current commit with `new_tag`."

setup do
    repo.init
    FileUtils.touch("somefile.txt")
    repo.add("somefile.txt")
    repo.commit_all("Added some file to the repo")
end

solution do
    repo.tags.first.name == "new_tag"
end

hint do
    puts "Take a look at `git tag`."
end
