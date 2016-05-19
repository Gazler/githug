difficulty 2
description "Jeden z edytorow tekstowych tworzy pliki z rozszerzeniem '.swp'. " +
"Nie checmy ich commitowac, spraw zeby git ignorowal pliki z rozszerzeniem '.swp'."

setup do
  repo.init
  FileUtils.touch("README.swp")
  file = File.open(".git/config", "w") do |file|
    file.puts "[core]\nexcludesfile="
  end
end

solution do

  valid = false


  File.open(".gitignore", "r") do |file|
    while line = file.gets
      if line.chomp == "*.swp"
        valid = true
      end
    end
  end

  valid
end

hint do
  puts "Zwroc uwage na plik o nazwie '.gitignore'."
end
