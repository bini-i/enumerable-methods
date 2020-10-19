

module Enumerable
    def my_each()
        self.length.times do |k|
        result = yield self[k]
        puts result
        end
        self
    end
 
    def my_index()
        puts "index"
        self.length.times do |j|
            yield j
        end
        self
    end

    def my_select()
        puts "odd"
        selected_elements=Array.new
        self.my_each() do |k|
            selected_elements.push(k) if (yield k)
        end
        puts selected_elements
    end
end
    



 
 

   # puts selected_elements
 
[8, 3, 6, 81, 4,78,24,45,91].my_select do |i| 
     i.odd?
end
