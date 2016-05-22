difficulty 1
description "Po tym jak przygotowalismy plik `README` przyszedl czas, zeby go zacommitowac."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
end

solution do
  return false if repo.commits.empty?
  true
end

hint do
  puts "Pamietaj, ze musisz dodac opis do przygotowanego commita."
end
