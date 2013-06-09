describe Changelog do
    
    let(:options) { { :io => "Changelog.md", :base => "test/repo/" } }
    let(:subject) { Changelog.new(options) }
    
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
    
    it "builds a valid entries array" do
        skip
        subject.build
        subject.entries.each do |e|
            e.message.must_match /\[(F|B|I)\]/i
        end
    end

end