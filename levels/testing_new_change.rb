difficulty 2
description "Kiedyś ta prezentacja wyglądała nienajgorzej. Jednak zaczęło nad nią pracować zbyt dużo osób o bardzo
późnych porach i ktoś wprowadził zmianę która uniemożliwia jej odczyt. Znajdź winnego, hash commita oraz nr lini w której powstał błąd"


setup do
  init_from_level
end

solution do
  offender = repo.commit("dd797d1a0edbcbae317940eb289528763cd53298").author.name
  request("W którym commicie prezentacja po uruchomieniu jest nieczytelna?") == "dd797d1a0edbcbae317940eb289528763cd53298"
  request("Kto wprowadził tą zmianę").downcase == offender.downcase
  request("Która linia spowodowała błąd") == 208
end

hint do
  puts "git blame, git checkout, git diff - powinny pomóc"
end
