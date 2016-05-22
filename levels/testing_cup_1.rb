difficulty 2
description "Kiedys ta prezentacja wygladala nienajgorzej. Jednak zaczelo nad nia pracowac zbyt duzo osob o bardzo
poznych porach i ktos wprowadzil zmiane ktora uniemozliwia jej odczyt. Znajdz winnego, hash commita oraz nr lini w ktorej powstal blad.
Prezentacje uruchamiamy z katalogu presentation w glownej galezi poprzez plik index.html"


setup do
  init_from_level
end

solution do
  offender = repo.commit("dd797d1a0edbcbae317940eb289528763cd53298").author.name
  request("Podaj hash commita w ktorym powstal blad sprawiajacy, ze prezentacja nie jest czytelna") == "dd797d1a0edbcbae317940eb289528763cd53298"
  request("Kto wprowadzil ta zmiane?").downcase == offender.downcase
  request("Ktora linia spowodowala blad?") == "208"
end

hint do
  puts "git blame, git checkout, git diff - powinny pomoc"
end
