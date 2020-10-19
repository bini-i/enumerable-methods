

module Enumerable
  def my_each()
    length.times do |k|
      result = yield self[k]
      puts result
    end
    self
  end
end

[8, 3, 6, 8, 4,78,56].my_each do |i|
  i
end
