module Githug
  module UI

    class << self

      attr_accessor :out_stream, :in_stream

      @out_stream = STDOUT
      @in_stream = STDIN

      def puts(string = "")
        out_stream.puts(string)
      end

      def print(string)
        out_stream.print(string)
      end

      def gets
        in_stream.gets
      end

      def word_box(string,width=80,char='*')
        puts char*width
        puts "#{char}#{string.center(width-2)}#{char}"
        puts char*width
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
