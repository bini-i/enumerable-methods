require_relative 'helper_methods'

module Enumerable
  def my_each()
    return to_enum(:my_each) unless block_given?

    arr = *self # if a range is given, it splats it into an array
    size.times do |indx|
      yield arr[indx]
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    arr = *self # if a range is given, it splats it into an array
    size.times do |indx|
      yield arr[indx], indx
    end
    self
  end

  def my_select
    return to_enum(:my_each) unless block_given?

    selected_elements = []
    my_each do |k|
      selected_elements.push(k) if yield k
    end
    selected_elements
  end

  def my_all?(*param)
    return Helper.match_all(self, param[0]) if param.length.positive?

    # returns false if a block is not given and falsy element is found
    my_each { |ele| return false unless ele || block_given? }
    # returns true if a block is not given and falsy element is not found
    return true unless block_given?

    my_each do |ele|
      # returns false if an element that doesn't satsify the condition is found
      return false unless yield ele
    end
    true
  end

  def my_any?(*param)
    return Helper.match_any(self, param[0]) if param.length.positive?

    # returns true if a block is not given and truthy element is found
    my_each { |ele| return true if ele && !block_given? }
    # returns false if a block is not given and truthy element is not found
    return false unless block_given?

    my_each do |ele|
      # returns true if an element that satsifys the condition is found
      return true if yield ele
    end
    false
  end

  def my_none?(*param)
    return Helper.match_none(self, param[0]) if param.length.positive?

    # returns true if a block is not given and truthy element is found
    my_each { |ele| return false if ele && !block_given? }
    # returns false if a block is not given and truthy element is not found
    return true unless block_given?

    my_each do |ele|
      # returns false if an element that satsifys the condition is found
      return false if yield ele
    end
    true
  end

  def my_count(*param)
    # when a comparing argument is provided
    if param.length.positive?
      count = 0
      my_each do |ele|
        count += 1 if ele == param[0]
      end
      return count
    elsif param.length.zero? && !block_given?
      count = 0
      my_each do |_ele|
        count += 1
      end
      return count
    end
    count = 0
    my_each do |ele|
      count += 1 if yield ele
    end
    count
  end

  def my_map(*param, &block)
    return to_enum(:my_each) unless block_given?

    # can accept either a proc or a block, and if both are provided, only uses a proc
    new_array = []
    if param.length.positive?
      proc = param[0] # proc object
    elsif param.length.zero? && block
      proc = block # proc object
    end

    my_each do |ele|
      new_array.push(proc.call(ele))
    end
    new_array
  end

  def my_inject(*param)
    # when no block is given and symbol is provided as argument
    return Helper.no_block(self, param) unless block_given?

    # when a block is specified
    if param.length.positive?
      # provides optional parameter for default value of accumulator
      accumulator = param[0]
      i = 0
    elsif param.length.zero?
      accumulator = first
      i = 1
    end
    arr = *self # if a range is given, it splats it into an array
    (i..(size - 1)).my_each do |indx|
      accumulator = yield accumulator, arr[indx]
    end
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject do |acc, ele|
    acc * ele
  end
end
