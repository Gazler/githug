require 'spec_helper'

RSpec::Matchers.define :be_solved do
  match do |actual|
    !actual.match("Congratulations, you have solved the level").nil?
  end
end

def skip_level
  Githug::Profile.load.level_bump
  `githug reset`
end


describe "The Game" do

  before(:all) do
    @dir = Dir.pwd
    `rake build`
    `gem install pkg/githug-#{Githug::VERSION}.gem`
    FileUtils.rm_rf("/tmp/git_hug")
    Dir.chdir("/tmp")
    `echo "y" | githug`
    Dir.chdir("/tmp/git_hug")
  end

  after(:all) do
    Dir.chdir(@dir)
  end

  it "should complete the init level" do
    `git init`
    `githug`.should be_solved
  end

  it "should complete the add level" do
    `git add README`
    `githug`.should be_solved
  end

  it "should complete the commit level" do
    `git commit -m "test message"`
    `githug`.should be_solved
  end


  it "should complete the config level" do
    skip_level #The CI server does not have git config set
    #full_name = `git config --get user.name`.chomp
    #email = `git config --get user.email`.chomp
    #f = IO::popen('githug', 'w')
    #f.puts(full_name)
    #f.puts(email)
    #f.close
  end

  it "should complete the clone level" do
    `git clone https://github.com/Gazler/cloneme`
    `githug`.should be_solved
  end

  it "should complete the clone_to_folder level" do
    `git clone https://github.com/Gazler/cloneme my_cloned_repo`
    `githug`.should be_solved
  end

  it "should complete the ignore level" do
    `echo "*.swp" >> .gitignore`
    `githug`.should be_solved
  end

  it "should complete the status level" do
    `git ls-files --other --exclude-standard | githug`.should be_solved
  end

  it "should complete the rm level" do
    file_name = `git status | grep deleted | cut -d " " -f 5`
    `git rm #{file_name}`
    `githug`.should be_solved
  end

  it "should complete the rm cached level" do
    file_name = `git status | grep "new file" | cut -d " " -f 5`
    `git rm --cached #{file_name}`
    `githug`.should be_solved
  end

  it "should complete the stash level" do
    `git stash save`
    `githug`.should be_solved
  end

  it "should complete the rename level" do
    `git mv oldfile.txt newfile.txt`
    `githug`.should be_solved
  end

  it "should complete the log level" do
    `git log --pretty=short | grep commit | cut -c 8-14 | githug`.should be_solved
  end

  it "should complete the tag level" do
    `git tag new_tag`
    `githug`.should be_solved
  end

  it "should complete the commit_amend level" do
    `git add forgotten_file.rb`
    `git commit --amend -C HEAD`
    `githug`.should be_solved
  end

  it "should complete the reset level" do
    `git reset HEAD to_commit_second.rb`
    `githug`.should be_solved
  end

  it "should complete the reset_soft level" do
    `git reset --soft HEAD^`
    `githug`.should be_solved
  end

  it "should complete the checkout_file level" do
    `git checkout -- config.rb`
    `githug`.should be_solved
  end

  it "should complete the remove level" do
    `git remote | githug`.should be_solved
  end

  it "should complete the remote_url level" do
    `git remote -v | tail -2 | head -1 | cut -c 17-52 | githug`.should be_solved
  end

  it "should complete the pull level" do
    `git pull origin master`
    `githug`.should be_solved
  end

  it "should complete the remote_add level" do
    `git remote add origin https://github.com/githug/githug`
    `githug`.should be_solved
  end

  it "should complete the push level" do
    `git rebase origin/master`
    `git push origin`
    `githug`.should be_solved
  end

  it "should complete the diff level" do
    `echo "26" | githug`.should be_solved
  end

  it "should complete the blame level" do
    `echo "spider man" | githug`.should be_solved
  end

  it "should complete the branch level" do
    `git branch test_code`
    `githug`.should be_solved
  end

  it "should complete the checkout level" do
    `git checkout -b my_branch`
    `githug`.should be_solved
  end

  it "should complete the checkout_tag level" do
    `git checkout v1.2`
    `githug`.should be_solved
  end

  it "should complete the branch_at level" do
    commit = `git log HEAD~1 --pretty=short | head -1 | cut -d " " -f 2`
    `git branch test_branch #{commit}`
    `githug`.should be_solved
  end

  it "should commit the merge level" do
    `git merge feature`
    `githug`.should be_solved
  end

  it "should complete the cherry-pick level" do
    commit = `git log new-feature --oneline  -n 3 | tail -1 | cut -d " " -f 1`
    `git cherry-pick #{commit}`
    `githug`.should be_solved
  end

  it "should complete the rename_commit level" do
    skip_level
  end

  it "should complete the squash level" do
    skip_level
  end

  it "should complete the merge squash level" do
    `git merge --squash long-feature-branch`
    `git commit -m "Merged Long Feature Branch"`
    `githug`.should be_solved
  end

  it "should complete the reorder level" do
    skip_level
  end

  it "should complete the bisect level" do
    `echo "18ed2ac" | githug`.should be_solved
  end

  it "should complete the stage_lines level" do
    skip_level
  end

  it "should complete the find_old_branch level" do
    `git checkout solve_world_hunger`
    `githug`.should be_solved
  end

  it "should complete the revert level" do
    sleep 1
    `git revert HEAD~1 --no-edit`
    `githug`.should be_solved
  end

  it "should complete the restore level" do
    `git reflog | grep "Restore this commit" | awk '{print $1}' | xargs git checkout`
    `githug`.should be_solved
  end

  it "should complete the conflict level" do
    skip_level
  end

  it "should complete the contribute level" do
    skip_level
  end

end
