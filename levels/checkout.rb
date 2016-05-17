difficulty 2
description "Stworz i przelacz sie na nowa galaz o nazwie my_branch. Powinienes stworzyc galaz w taki sam sposob jak w poprzednim zadaniu."

setup do
  repo.init
  FileUtils.touch("README")
  repo.add("README")
  repo.commit_all("initial commit")
end

solution do
  return false unless repo.head.name == "my_branch"
  true
end

hint do
  puts "Sprawdz komendy 'git checkout' i 'git branch'."
end
