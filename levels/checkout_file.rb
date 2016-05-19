difficulty 3

description "Plik, ktory zostal zmodyfikowany zawiera zmiany ktorych nie potrzebujesz. Pozbadz sie zmian wprowadzonych z ostatnik commitem w pliku 'config.rb'."

setup do
  repo.init
  File.open("config.rb", "w") do |file|
    file.puts("This is the initial config file")
  end

  repo.add("config.rb")
  repo.commit_all("Added initial config file")

  File.open("config.rb", "a") do |file|
    file.puts("These are changed you don't want to keep!")
  end
end

solution do
  repo.status.files["config.rb"].type != "M" && repo.commits.length == 1
end

hint do
  puts "W razie potrzeby spojrz na pomoc dotyczacaca komendy 'checkout'."
end
