module Githug
  class Level
    include UI

    LEVELS = [nil, "init", "config", "add", "commit", "clone",
              "clone_to_folder", "ignore", "include", "status",
              "number_of_files_committed", "rm", "rm_cached", "stash", "rename",
              "restructure", "log", "tag", "push_tags", "commit_amend",
              "commit_in_future", "reset", "reset_soft", "checkout_file", "remote",
              "remote_url", "pull", "remote_add", "push", "diff", "blame", "branch",
              "checkout", "checkout_tag", "checkout_tag_over_branch", "branch_at",
              "delete_branch", "push_branch", "merge", "fetch", "rebase", "repack", "cherry-pick",
              "grep", "rename_commit", "squash", "merge_squash", "reorder", "bisect",
              "stage_lines", "find_old_branch", "revert", "restore", "conflict",
              "submodule","contribute"]

    attr_accessor :level_no, :level_path, :level_name

    class << self

      def load(level_name)
        path = "#{File.dirname(__FILE__)}/../../levels/#{level_name}.rb"
        setup(path)
      end

      def load_from_file(path)
        setup(path)
      end

      def list
        return LEVELS - [nil]
      end

      def setup(path)
        level_path = path.chomp(File.extname(path))
        level = self.new

        return false unless File.exists?(path)

        level.instance_eval(File.read(path))
        level.level_name = File.basename(path, File.extname(path))
        level.level_no = LEVELS.index(level.level_name) || 1
        level.level_path = level_path
        level
      end

    end

    def init_from_level
      FileUtils.cp_r("#{level_path}/.", ".")
      FileUtils.mv(".githug", ".git")
    end

    def difficulty(num)
      @difficulty = num
    end

    def description(description)
      @description = description
    end

    def solution(&block)
      singleton = class << self; self end
      singleton.send :define_method, :_solution, &block
    end

    def setup(&block)
      @setup = block
    end

    def hint(&hint)
      @hint = hint
    end

    def hints(hints)
      @hints = hints
    end

    def full_description
      UI.puts
      UI.puts "Name: #{level_name}"
      UI.puts "Level: #{level_no}"
      UI.puts "Difficulty: #{"*"*@difficulty}"
      UI.puts
      UI.puts @description
      UI.puts
    end

    def setup_level
      repo.reset
      @setup.call if @setup
    end

    def repo(location = "")
      @repo ||= Repository.new(location)
    end

    def solve
      _solution
    rescue
      false
    end

    def test
      _solution
    end

    def show_hint
      UI.word_box("Githug")
      profile = Profile.load
      current_hint_index = profile.current_hint_index
      if @hints
        puts @hints[current_hint_index]
        if current_hint_index < @hints.size - 1
          profile.current_hint_index += 1
          profile.save
        else
          profile.current_hint_index = 0
          profile.save
        end
      elsif @hint
        @hint.call
      else
        UI.puts("No hints available for this level.")
      end
    end
  end
end
