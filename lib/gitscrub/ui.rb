module Gitscrub
  class UI

    @@out_string

    class << self
      
      def out_string=(out)
        @@out_string = out
      end

      def puts(string)
        @@out_string.puts(string)
      end

    end

  end
end
