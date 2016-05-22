difficulty 2
description "Ktos wprowadzil haslo w pliku 'config.rb' znajdz kto to byl"

setup do
  init_from_level
end

solution do
  offender = repo.commit("97bdd0cccf9f4b8730f78cb53a81a74f205dbcc2").author.name
  request("Kto wprowadzil zmiany umieszczajac haslo?").downcase == offender.downcase
end

hint do
  puts "Sprawdz komende 'git blame'."
end
