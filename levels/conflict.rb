difficulty 4
description "Potrzebujesz polaczyc galaz o nazwie mybranch to aktualnej galezi (master). Na galezi mybranch moga pojawic sie zmiany ktore spowoduja konflikty. Rozwiaz powstale konflikty i dokoncz scalenie (merge)."

setup do
  init_from_level
end

solution do
  solved = true

  solved = false unless repo.head.name == "master"
  solved = false unless repo.commits("master")[0].parents.length == 2

  txt = File.read("poem.txt")
  solved = false if txt =~ /[<>=|]/
  solved = false unless txt =~ /Sat on a wall/

  solved
end

hint do
  puts ["Poczatkowo musisz wywolac komende merge. Nastepnie rozwiazac konflikty i dokonczyc merge", "Mozesz szukac pomocy pod haslem 'git merge'.", "Usun niepotrzebne linijki w pliku 'poe,.txt', tak aby pozostala poprawna tresc."]
end
