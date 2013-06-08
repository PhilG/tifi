require "minitest/autorun"

#module MiniTest::Beautify
#    VERSION = "0.0"
#end

module Minitest

    def self.plugin_beautify_init options
        io = BeautifyReporter.new options[:io]

        self.reporter.reporters.grep(Minitest::Reporter).each do |rep|
            rep.io = io
        end
    end
    
    class BeautifyReporter
        
        # Start an escape sequence
        ESC = "\e["
    
        # End the escape sequence
        NND = "#{ESC}0m"
        
        RED = "31"
        GREEN = "32"
        YELLOW = "33"
        TAB = "\s\s\s\s"
        SPACE = "\s\s"
    
        # The IO we're going to pipe through.
        attr_reader :io
    
        def initialize io
            @io = io
        end

        def print text
            case text
                when "." then
                    io.puts "#{SPACE}#{ESC}#{GREEN}m[PASS]#{NND}"
                when "E"
                    io.puts "#{TAB}#{ESC}#{RED}m[ERROR]#{NND}"
                when "F" then
                    io.puts "#{TAB}#{ESC}#{RED}m[FAIL]#{NND}"
                when "S" then
                    io.puts "#{TAB}#{ESC}#{YELLOW}m[SKIP]#{NND}"
                else
                    io.puts "Unkown Runnable#result_code"
            end
        end
    
        #def puts(*o) # :nodoc:
        #   o.map! { |s|
        #        s.to_s.sub(/Finished/) {
        #            @index = 0
        #            'Fabulous run'.split(//).map { |c|
        #                pride(c)
        #            }.join
        #        }
        #    }        
        #    super
        #end
    
        def method_missing msg, *args
            io.send(msg, *args)
        end
    end
end
