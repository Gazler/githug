difficulty 2
description "The text editor 'vim' creates files ending in `.swp` (swap files) for all files that are currently open.  We don't want them creeping into the repository.  Make this repository ignore `.swp` files."

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
  puts "You may have noticed there is a file named `.gitignore` in the repository."
end
