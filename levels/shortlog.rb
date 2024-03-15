difficulty 3
description "Find out how many commits, out of the most recent 100, were made by Charlie"

setup do
    init_from_level
end

solution do
    solved = false
    
    answer = request("How many of the last 100 commits were made by Charlie?")
    if answer.to_i == 25
        solved = true
    end

    solved
end

hints [
    "You might want to look into the `git shortlog` command",
    "100 is too many commits to count through manually. Is there a way you can use `git shortlog` to check only the most recent 100 commits?"]