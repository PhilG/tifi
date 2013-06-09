describe Changelog do
    
    let(:options) { { :io => "Changelog.md", :base => "test/repo/" } }
    let(:subject) { Changelog.new(options) }
    
    log = <<-EOF
# Changelog #
## v0.3 ##
* [I] now have a readme
## v0.2 ##
* [B] fancy update
## v0.1 ##
* [I] Tests are faster
* [F] Version detection
    EOF
    
    it "is able to build" do
        subject.must_respond_to :build
    end
    
    it "has entries" do
        subject.must_respond_to :entries
    end
        
    it "finishes properly given $stdout as IO" do
        proc { Changelog.new({ :io => $stdout }).finish }.must_output "# Changelog #\n"
    end
    
    it "has ALL the tags" do
        subject.build
        subject.entries.each do |e|
            e.must_be_instance_of Entry
            e.commits[0].must_be_instance_of Grit::Commit
        end
    end
    
    it "correctly build and outputs" do
        subject.build
        proc { subject.finish }.must_output log
    end
end