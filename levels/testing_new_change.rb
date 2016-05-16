difficulty 2
description "Kiedyś ta prezentacja wyglądała nienajgorzej. Jednak zaczęło nad nią pracować zbyt dużo osób o bardzo
późnych porach i ktoś wprowadził zmianę która uniemożliwia jej odczyt. Znajdź winnego, hash commita oraz nr lini w której powstał błąd"


setup do
  init_from_level
end

solution do
  #offender = repo.commit("97bdd0cccf9f4b8730f78cb53a81a74f205dbcc2").author.name
  request("Who made the commit with the password?").downcase == offender.downcase
end

hint do
  puts "You want to research the `git blame` command."
end
