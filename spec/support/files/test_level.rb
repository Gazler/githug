difficulty 1
description "A test description"
setup do
  "test"
end
solution do
  Grit::Repo.new("githug/notadir")
end

hints [
  "this is hint 1",
  "this is hint 2"]

hint do
  puts "this is a hint"
end
