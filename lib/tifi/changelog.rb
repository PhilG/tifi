class Changelog
    attr_reader :entries
    
    def initialize(options)
        @options = options
        @entries = []
    end
    
    def start
        build
        finish
    end
    
    def build
        repo = Grit::Repo.new("#{@options[:base]}.")
        tags = Grit::Tag.find_all(repo)
        tags.sort! { |x,y| x.name <=> y.name }
    
        tags.each do |t|
            e = Entry.new(t.name, [t.commit])
            repo.commits(e.tag).each do |c|
                unless c.message == t.commit.message
                    if !(already? c) && (c.message =~ /\[(F|B|I)\]/i)
                        e.commits << c
                    end
                end
            end           
                        
            @entries << e
            
        end
    end
    
    def already?(commit)
        if @entries == []
            return false
        else
            @entries.each do |e|
                if (e.commits.include? commit)
                    return true
                end
            end
        end            
    end
    
    def result
        @string = ""
        @entries.reverse.each do |e|
            @string << "## #{e.tag} ##\n"
            e.commits.each do |c|
                @string << "* #{c.message}\n"
            end
        end
        puts @string
    end

    def finish
        puts "# Changelog #"
        if @entries != []
            result
        end
    end
end