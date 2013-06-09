describe Runner do
    
    let(:subject) { Runner.new }
        
    it "is a Runner" do
        subject.must_be_instance_of Runner
    end

    it "is able to start" do
        subject.must_respond_to :start
    end
        
    it "return options when asked about them" do
        subject.options.must_equal Hash[:io => $stdout]
    end
    
    it "is able to parse commandline arguments" do
        Runner.must_respond_to :parse
    end
    
    describe "when parse is called" do
        r = Runner.parse([])
        
        it "returns an instace of itself" do
            r.must_be_instance_of Runner
        end
        
        it "has the default options" do
            r.options.must_equal Hash[:io => $stdout]
        end
        
        it "returns correct modified options" do
            argv = ["Changelog.md", "test/repo/"]
            runner = Runner.parse(argv)
            runner.options.must_equal Hash[:io => "Changelog.md", :base => "test/repo/"]
        end
    end  
end