difficulty 2
description "Masz stworzone wiele galezi w swoim projekcie. Jedna z galezi o nazwie 'delete_me' nie jest Ci potrzebna, usun ja."

setup do
    init_from_level
end

solution do
  return true unless repo.branches.map(&:name).include?('delete_me')
end

hint do
  puts "Uruchomienie komendy 'git --help branch' pozwoli Ci zapoznac sie ze wszystkimi komendami dotyczacymi pracy na galeziach."
end