module Concerns
    module Findable
        def find_by_name(name)
            self.all.find{|f| f.name == name}
        end
        def find_or_create_by_name(name)
            f = self.find_by_name(name)
            f ? f : self.create(name)
        end
    end
end
