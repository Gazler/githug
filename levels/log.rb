difficulty 2
description "Jestes poproszony o znacznik (hash) ostatnich commitow. Potrzebujesz sprawdzic zmiany, ktore zostaly wprowadzone w ostatnim czasie w repozytorium."

setup do
  repo.init
  file = File.new("newfile.rb", "w")
  repo.add("newfile.rb")
  repo.commit_all("THIS IS THE COMMIT YOU ARE LOOKING FOR!")
end

solution do
  repo.commits.last.id_abbrev == request("What is the hash of the most recent commit?")[0..6]
end

hint do
  puts "Musisz sprawdzic logi. Istnieje komenda, ktora pozwoli Ci wypisac wszystkie zmiany."
end
