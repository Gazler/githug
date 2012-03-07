module Gitscrub
  class UI

    @@out_stream
    @@in_stream

    class << self
      
      def out_stream=(out)
        @@out_stream = out
      end

      def in_stream=(in_stream)
        @@in_stream = in_stream
      end

      def puts(string)
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
        print(msg)
        gets.chomp
      end
      
      def ask(msg)
        request("#{msg} [yn] ") == 'y'
      end

    end

  end
end
