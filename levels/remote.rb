difficulty 2

description "Ten projekt posiada zdalne repozytorium. Znajdz jego nazwe."

setup do
  repo.init
  repo.remote_add("my_remote_repo", "https://github.com/Gazler/githug")
end

solution do
  "my_remote_repo" == request("Jaka jest nazwa zdalnego repozytorium?")
end

hint do
  puts "Jezeli potrzebujesz pomocy uzyj komendy 'git', wyswietlone zostana dostepne komendy."
end
