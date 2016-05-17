difficulty 1
description "Sklonuj repozytorium z https://github.com/Gazler/cloneme do nowego katalogu o nazwie `my_cloned_repo`."

solution do
  repo("my_cloned_repo").commit("157b2b61f29ab9df45f31c7cd9cb5d8ff06ecde4")
end

hint do
  puts "Uzyj tej samej komendy co w ostatnim zadaniu, bo `git clone` posiada opcjonalny argument."
end
