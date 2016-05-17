difficulty 2

description "Potrzebujesz zaciagnac zmiany ze zrodlowego (origin) repozytorium"

setup do
  repo.init
  repo.remote_add("origin", "https://github.com/pull-this/thing-to-pull")
end

solution do
  repo.commits.last.id_abbrev == "1797a7c"
end

hint do
  puts "Zaciagnij zmiany ze zdalnego repozytorium i sprawdź polecenie 'git pull'."
end
