difficulty 2
description "Plik 'README' zostal zacommitowany, jednak wyglada na to ze plik 'forgotten_file.rb' zostal pominiety. Dodaj plik i zmien swoj poprzedni commit tak zeby zawieral ten plik."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
  repo.commit_all("Initial commit")
  FileUtils.touch("forgotten_file.rb")
end

solution do
  # Reset config - see issue #74
  file = File.open(".git/config", "w") do |file|
    file.puts("[format]")
    file.puts(" pretty = medium")
  end
  repo.commits.length == 1 && Grit::CommitStats.find_all(repo, repo.commits.first.sha).first[1].files.length == 2
end

hint do
  puts "Uruchom komende 'git commit --help' i zapoznaj sie z mozliwymi akcjami."
end
