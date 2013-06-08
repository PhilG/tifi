class Changelog
    attr_reader :entries
    
    def initialize(options)
        @options = options
    end
    
    def build
    end
    
    def result
        puts "# Changelog #"
    end
    
    def finish
        result
    end
end