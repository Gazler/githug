difficulty 3
description "A bug was introduced somewhere along the way.  You know that running `ruby prog.rb 5` should output 15.  You can also run `make test`.  What are the first 7 chars of the hash of the commit that introduced the bug."

setup do
  init_from_level
  repo.init
end

solution do
  "18ed2ac" == request("What are the first 7 characters of the hash of the commit that introduced the bug?")[0..6]
end

hint do
  puts ["The fastest way to find the bug is with bisect.", "Don't forget to start bisect first, identify a good or bad commit, then run `git bisect run make test`."]
end
