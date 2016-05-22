difficulty 2
description "Popularnym sposobem pracy z gitem jest 'git rebase workflow'. Twoje zmiany sa gotowe zeby dolaczyc je do galezi glownej (mastera)."

setup do
  init_from_level
end

solution do
  return repo.commits('feature').last.id_abbrev != "ed0fdcf" &&
    repo.commits("feature").map(&:message) == ['add feature','add content','init commit']
end

hint do
  puts "Poznaj komende 'git rebase'"
end
