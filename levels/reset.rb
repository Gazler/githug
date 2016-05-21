difficulty 2
description "Dwa pliki zostaly zacommitowane. Celem bylo dodanie ich w dwoch osobnych commitach, przez przypadek zostaly dodane w jednym. " +
"Usun plik 'to_commit_second.rb' z listy zacommitowanych uzywajac komendy reset (nie musisz nic commitowac)."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
  repo.commit_all("Initial commit")
  FileUtils.touch("to_commit_first.rb")
  FileUtils.touch("to_commit_second.rb")
  repo.add(".")
end

solution do
  return false unless (repo.status.files["to_commit_second.rb"].nil? || repo.status.files["to_commit_second.rb"].stage.nil?) && File.exists?("to_commit_second.rb")
  return false if (repo.status.files["to_commit_first.rb"].nil? || repo.status.files["to_commit_first.rb"].stage.nil?)
  true
end

hint do
  puts "Informacje o plikach ktore sa na liscie zacommitowanych uzyskasz dzieki komendzie 'git status'."
end
