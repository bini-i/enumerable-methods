module Enumerable
  def my_each
    each do |ele|
      yield ele
    end
    self
  end

  def my_each_with_index
    length.times do |j|
      yield j
    end
    self
  end

  def my_select
    selected_elements = []
    my_each do |k|
      selected_elements.push(k) if yield k
    end
    selected_elements
  end

  def my_all?
    my_each do |ele|
      # returns false if an element that doesn't satsify the condition is found
      return false unless yield ele
    end
    true
  end

  def my_any?
    my_each do |ele|
      return true if yield ele
    end
    false
  end

  def my_none?
    my_each do |ele|
      return false if yield ele
    end
    true
  end

  def my_count
    count = 0
    my_each do |ele|
      count += 1 if yield ele
    end
    count
  end

  def my_map(*param, &block)
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

  def my_inject
    accumulator = first
    (1..(length - 1)).my_each do |indx|
      accumulator = yield accumulator, self[indx]
    end
    accumulator
  end
end
