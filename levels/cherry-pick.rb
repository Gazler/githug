difficulty 3
description "Twoja nowa funkcjonalnosc nie zostanie wdrozona i zamierzasz ja usunac. Jednak zalezy Ci na jednym commicie ktory modyfikuje plik 'README', chcesz aby ten plik znalazl sie na glownej galezi (master)."

setup do
    init_from_level
    `git stash` #fix for README.md being in githug root an the level
end

solution do
  return false unless repo.commits[1].message == "Added fancy branded output"
  return false unless repo.commits[0].message == "Filled in README.md with proper input"
  true
end

hint do
  puts "Zapoznaj sie z komenda 'cheryy-pick'."
end
