module Githug
  module UI

    @@out_stream = STDOUT
    @@in_stream = STDIN

    class << self
      
      def out_stream=(out)
        @@out_stream = out
      end

      def in_stream=(in_stream)
        @@in_stream = in_stream
      end

      def puts(string = "")
        @@out_stream.puts(string)
      end

      def print(string)
        @@out_stream.print(string)
      end

      def gets
        @@in_stream.gets
      end

      def line
        puts("*"*80)
      end

      def word_box(string)
        space_length = (80/2) - ((string.length/2)+1)
        line
        print "*"
        print " "*space_length
        print string
        print " "*space_length
        puts "*"
        line
      end

      def request(msg)
        print("#{msg} ")
        gets.chomp
      end
      
      def ask(msg)
        request("#{msg} [yn] ") == 'y'
      end

      def colorize(text, color_code)
	return puts text if ENV['OS'] && ENV['OS'].downcase.include?("windows")
        puts "#{color_code}#{text}\033[0m"
      end

      def error(text)
        colorize(text, "\033[31m")
      end

      def success(text)
        colorize(text, "\033[32m")
      end

    end

    def method_missing(method, *args, &block)
      return UI.send(method, *args) if UI.methods(false).include?(method.to_s) || UI.methods(false).include?(method)
      super
    end

  end
end
