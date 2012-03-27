module Githug
  class Level
    include UI
    include I18n

    LEVELS = [nil, "init", "add", "commit", "config", "clone",
              "clone_to_folder", "ignore", "status", "rm", "rm_cached",
              "rename", "log", "tag",  "commit_ammend", "reset",
              "checkout_file", "remote", "remote_url", "pull", "remote_add",
              "diff", "blame", "branch", "checkout", "branch_at", "merge",
              "rename_commit", "squash", "merge_squash", "reorder",
              "stage_lines", "find_old_branch", "contribute"]

    attr_accessor :level_no, :level_path, :level_name
    
    class << self
      
      def load(level_name)
        path = "#{File.dirname(__FILE__)}/../../levels/#{level_name}.rb"
        setup(path)
      end

      def load_from_file(path)
        setup(path)
      end

      def setup(path)
        level_name = File.basename(path, File.extname(path))
        #Remove .rb extension, WTB a better way to do this
        level_path = path[0..-4]
        level = new
        return false unless File.exists?(path)
        level.level_name = level_name
        level.level_no = LEVELS.index(level_name) || 1
        level.level_path = level_path
        level.instance_eval(File.read(path))
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
      if I18n.locale != :en && I18n.exists?("level.#{level_name}.description")
        @description = I18n.t("level.#{level_name}.description")
      end
    end

    def solution(&block)
      @solution = block
    end

    def setup(&block)
      @setup = block 
    end

    def hint(&hint)
      @hint = hint
    end

    def hints(hints)
      @hints = hints
      if I18n.locale != :en && I18n.exists?("level.#{level_name}.hints")
        @hints = I18n.t("level.#{level_name}.hints")
      end
    end

    def full_description
      UI.puts
      UI.puts "#{I18n.t("githug.level.level")} #{level_no}"
      UI.puts "#{I18n.t("githug.level.difficulty")} #{"*"*@difficulty}"
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
      @solution.call
    rescue
      false
    end

    def test
      @solution.call
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
        UI.puts("githug.level.no_hints")
      end
    end
  end
end
