difficulty 2
description "You want to include the files from the following repo: `https://github.com/jackmaney/githug-include-me` into a the folder `./githug-include-me`. Do this without cloning the repo or copying the files from the repo into this repo."

setup do
    repo.init
end

solution do
    return false if not File.directory?("./githug-include-me")
    return false if not File.exist?("./githug-include-me/README.md")
    return false if not File.exist?("./githug-include-me/.git")
    return false if File.directory?("./githug-include-me/.git")
    return false if not File.exist?(".gitmodules")

    return true
end

hint do
    puts "Take a look at `git submodule`."
end
