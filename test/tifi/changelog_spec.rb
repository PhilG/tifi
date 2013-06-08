describe Changelog do
    
    let(:options) { { :io => "Changelog.md" } }
    let(:subject) { Changelog.new(options) }
    
    it "is able to build" do
        subject.must_respond_to :build
    end
    
    it "has entries" do
        subject.must_respond_to :entries
    end
    
    it "can output the result" do
        proc { Changelog.new({ :io => $stdout }).result }.must_output "# Changelog #\n"
    end
    
    it "finishes properly given STDOUT" do
        proc { Changelog.new({ :io => $stdout }).finish }.must_output "# Changelog #\n"
    end
end