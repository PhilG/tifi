class Runner
    attr_reader :options
    
    def initialize(options = {}) # Command method
        @options = { :io => $stdout }
        @options.merge!(options)
        @changelog = Changelog.new(@options)
    end
    
    def self.parse(argv = []) # Query method
        argv == [] ? self.new : self.new({ :io => argv[0]}) 
    end
    
    def start # Command method! Not thourougly tested
        @changelog.finish
    end
end