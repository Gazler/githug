difficulty 1
description "Jeden z plikow w tym repozytorium nie zostal dodany do listy przygotowanej do commita. Ktory to plik?"

setup do
  repo.init
  %w{config.rb README setup.rb deploy.rb Guardfile}.each do |file|
    FileUtils.touch(file)
    repo.add(file)
  end
  FileUtils.touch("database.yml")
end

solution do

  name = request("Jak nazywa sie plik niedodany do listy?")

  if name != "database.yml"
    return false
  end

  true
end

hint do
  puts "Szukasz komendy ktora zwroci aktualny stan repozytorium."
end
