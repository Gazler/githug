#Githug
Git Your Game On [![Build Status](https://secure.travis-ci.org/Gazler/githug.png?branch=master)](http://travis-ci.org/Gazler/githug)

##About
Githug is designed to give you a practical way of learning git.  It has a series of levels, each utilizing git commands to ensure a correct answer.

##Installation
To install Githug

    gem install githug

After the gem is installed, you can run `githug` where you will be prompted to create a directory.  Githug should work on Linux and OS X.

##Commands

Githug has 4 commands:

 * play - This is the default command and it will check your solution for the current level.
 * hint - Gives you a hint (if available) for the current level
 * reset - Reset the current level
 * test - Used to test levels in development, please see the Testing Levels section.


##Contributing

If you want to suggest a level or make a level that has been suggested, check out [the wiki](https://github.com/Gazler/githug/wiki).

 Get yourself on the [contributors list](https://github.com/Gazler/githug/contributors) by doing the following:

 * Fork the repository
 * Make a level in the levels directory (covered below)
 * Add your level to the LEVELS array inside `lib/githug/level.rb` in a position that makes sense (the "commit" level after the "add" and "init" levels for example)
 * Make sure your level works (covered below)
 * Submit a pull request

##Todo List

 * A better way of returning from the solution block
 * A follow up to the level, more information on a specific command, etc.
 * More levels!

##Writing Levels

Githug has a DSL for writing levels

An example level:

    difficulty 1
    description "There is a file in your folder called README, you should add it to your staging area"

    setup do
      repo.init
      FileUtils.touch("README")
    end

    solution do
      return false unless repo.status.files.keys.include?("README")
      return false if repo.status.files["README"].untracked
      true
    end

    hint do
      puts "You can type `git` in your shell to get a list of available git commands"
    end

 `difficulty`, `description` and `solution` are required.

You can also include multiple hints like this:

    hints [
      "You can type `git` in your shell to get a list of available git commands",
      "Check the man for `git add`"]

 **note** Because `solution` is a Proc, you cannot prematurely return out of it and as a result, must put an implicit return on the last line of the solution block.


    solution do
      solved = false
      solved = true if repo.valid?
      solved
    end

 By default, `setup` will remove all files from the game folder.  You do not need to include a setup method if you don't want an initial git repository (if you are testing `git init` or only checking an answer.)
 
 You can call `repo.init` to initialize an empty repository with a .gitignore file. It takes a single parameter of false if you want to skip the initial commit of the .gitignore file.

 All methods called on `repo` are sent to the [grit gem](https://github.com/mojombo/grit) if the method does not exist, and you can use that for most git related commands (`repo.add`, `repo.commit`, etc.)


Another method exists called `init_from_level` and it is used like so:

    setup do
      init_from_level
    end

This will copy the contents of a repository specified in the levels folder for your level.  For example, if your level is called "merge" then it will copy the contents of the "merge" folder.  it is recommended that you do the following steps:

 * mkdir "yourlevel"
 * cd "yourlevel"
 * git init
 * some git stuff
 * **important** rename ".git" to ".githug" so it does not get treated as a submodule
 * cd "../"
 * git add "yourlevel"

After doing this, your level should be able to copy the contents from that git repository and use those for your level.  You can see the "blame" level for an example of this.

##Testing Levels

The easiest way to test a level is:

 * change into your git_hug repository
 * Run `githug reset PATH_TO_YOUR_LEVEL
 * Solve the level
 * Run `githug test PATH_TO_YOUR_LEVEL

Please note that the `githug test` command can be run as `githug test --errors` to get an error stacktrace from your solve method.
