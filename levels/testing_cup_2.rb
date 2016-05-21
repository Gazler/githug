difficulty 3
description "Na lokalnym repozytorium rozwin slajd z testami (np. dodaj opis testow integracyjnych). Nastepnie opublikuj je na serwerze Github. Pamietaj zeby zrobic Pull Requesta z nowej, wlasnej galezi. Haslo do rozwiazania zadania pojawi sie w komentarzu Pull Requesta."


setup do
  init_from_level
end

solution do
  request("Podaj haslo") == "TestingCup2016"
end

hint do
  puts "Sprawdz czy masz aktualna wersje prezentacji. Pamietaj o wlasnym branchu. Uwazaj na konflikty."
end
