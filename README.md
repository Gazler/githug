# Githug
Git Your Game On [![Build Status](https://travis-ci.org/Gazler/githug.png?branch=master)](https://travis-ci.org/Gazler/githug) [![Code Climate](https://codeclimate.com/github/Gazler/githug.png)](https://codeclimate.com/github/Gazler/githug)
## About
Githug is designed to give you a practical way of learning git.  It has a series of levels, each utilizing git commands to ensure a correct answer.

## Installation
To install Githug

    gem install githug

After the gem is installed, you can run `githug` where you will be prompted to create a directory.  Githug should work on Linux, OS X and Windows.

## Commands

Githug has 5 commands:

 * play - This is the default command and it will check your solution for the current level.
 * hint - Gives you a hint (if available) for the current level
 * reset - Reset the current level or reset the level to a given name or path
 * levels - List all of the levels
 * test - Used to test levels in development, please see the Testing Levels section.

## Change Log

The change log is available on the wiki.  [Change log](https://github.com/Gazler/githug/wiki/Change-Log)


## Contributing

If you want to suggest a level or make a level that has been suggested, check out [the wiki](https://github.com/Gazler/githug/wiki).

 Get yourself on the [contributors list](https://github.com/Gazler/githug/contributors) by doing the following:

 * Fork the repository
 * Make a level in the levels directory (covered below)
 * Add your level to the LEVELS array inside `lib/githug/level.rb` in a position that makes sense (the "commit" level after the "add" and "init" levels for example)
 * Make sure your level works (covered below)
 * Submit a pull request

## Todo List

 * A better way of returning from the solution block.
 * A follow up to the level, more information on a specific command, etc.
 * More levels!

## Writing Levels

Githug has a DSL for writing levels

An example level:

```ruby
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
```

 `difficulty`, `description` and `solution` are required.

You can also include multiple hints like this:

```ruby
hints [
  "You can type `git` in your shell to get a list of available git commands",
  "Check the man for `git add`"]
```

 By default, `setup` will remove all files from the game folder.  You do not need to include a setup method if you don't want an initial git repository (if you are testing `git init` or only checking an answer.)

 You can call `repo.init` to initialize an empty repository.

 All methods called on `repo` are sent to the [grit gem](https://github.com/mojombo/grit) if the method does not exist, and you can use that for most git related commands (`repo.add`, `repo.commit`, etc.)


Another method exists called `init_from_level` and it is used like so:

```ruby
setup do
  init_from_level
end
```

This will copy the contents of a repository specified in the levels folder for your level.  For example, if your level is called "merge" then it will copy the contents of the "merge" folder.  it is recommended that you do the following steps:

 * mkdir "yourlevel"
 * cd "yourlevel"
 * git init
 * some git stuff
 * **important** rename ".git" to ".githug" so it does not get treated as a submodule
 * cd "../"
 * git add "yourlevel"

After doing this, your level should be able to copy the contents from that git repository and use those for your level.  You can see the "blame" level for an example of this.

## Testing Levels

The easiest way to test a level is:

 * change into your git_hug repository
 * Run `githug load PATH_TO_YOUR_LEVEL`
 * Solve the level
 * Run `githug test PATH_TO_YOUR_LEVEL`

Please note that the `githug test` command can be run as `githug test --errors` to get an error stacktrace from your solve method.

It would be ideal if you add an integration test for your level.  These tests live in `spec/githug_spec` and **must** be run in order.  If you add a level but do not add a test, please add a simple `skip_level` test case similar to the `contribute` level.
