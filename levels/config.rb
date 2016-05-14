difficulty 1
description "Zmien konfigurację ustawiajac nazwe uzytkownika i email. Jest to wazny krok ktory zapewni Ci ze Twoje commity beda podpisane i bedzie mozna je z latwoscia odnalezc."

setup do
  repo.init
end

solution do
  valid = false

  name = request("Jak sie nazywasz?")
  email = request("Jaki jest Twoj email?")
  config_name = repo.config["user.name"]
  config_email = repo.config["user.email"]

  if name.respond_to?(:force_encoding)
    config_name = config_name.force_encoding("UTF-8")
    config_email = config_email.force_encoding("UTF-8")
  end

  if name == config_name && email == config_email
    valid = true
  end

  puts "Twoja nazwa uzytkownika to: #{config_name}"
  puts "Twoj email to: #{config_email}"

  valid
end

hint do
  puts "Jezeli potrzebujesz pomocy uzyj komendy 'git help config'."
end
