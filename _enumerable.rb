

module Enumerable
    def my_each
        for ele in self
            yield ele
        end
        self
    end
 
    def my_each_with_index
        self.length.times do |j|
            yield j
        end
        self
    end

    def my_select
        selected_elements = []
        self.my_each do |k|
            selected_elements.push(k) if (yield k)
        end
        selected_elements
    end
    
    def my_all?
        self.my_each do |ele|              
            #returns false if an element that doesn't satsify the condition is found     
            return false unless yield ele
        end
        true         
    end

    def my_any?
        self.my_each do |ele|
            return true if yield ele
        end
        false
    end

    def my_none?
        self.my_each do |ele|
            return false if yield ele
        end
        true
    end

    def my_count
        count=0
        self.my_each do |ele|
            count+=1 if yield ele
        end
        count
    end

    def my_map(*param, &block)
        new_array=[]
        if param.length>0 
            proc = param[0]     #proc object
        elsif param.length == 0 && block
            proc = block        #proc object
        end

        self.my_each do |ele|
            new_array.push(proc.call(ele)) 
        end
        new_array
    end

    def my_inject
        accumulator=self.first
        (1..(self.length-1)).my_each do |indx|
            accumulator = yield accumulator,self[indx]
        end
        accumulator
    end
end