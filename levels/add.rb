difficulty 1
description "Stworzylismy plik `README` w katalogu, dodaj go do plikow przygotowanych dla zcommitowania. Pamietaj, ze kazdy poziom zaczynasz z nowym repozytorium!"

setup do
  repo.init
  FileUtils.touch("README")
end

solution do
  return false unless repo.status.files.keys.include?("README")
  return false if repo.status.files["README"].untracked
  true
end

hint do
  puts "Po wykonaniu komendy `git` zobaczysz liste dostepnych polecen."
end
