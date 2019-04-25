difficulty 1
description "Clone the repository at https://github.com/Gazler/cloneme to `my-cloned-repo`."

solution do
  repo("my-cloned-repo").commit("157b2b61f29ab9df45f31c7cd9cb5d8ff06ecde4")
end

hint do
  puts "This is like the last level, `git clone` has an optional argument."
end
