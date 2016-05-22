difficulty 1
description "Chcesz pracowac z kawalkiem kodu, ktory potencjalnie moze wprowadzic blad, stworz galaz (branch) test_code"

setup do
  repo.init
  FileUtils.touch("README")
  repo.add "README"
  repo.commit_all("Initial commit")
end

solution do
  repo.branches.map(&:name).include?("test_code")
end

hint do
  puts "'git branch' jest komenda ktora powinienes poznac"
end

