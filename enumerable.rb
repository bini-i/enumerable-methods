

module Enumerable
  def my_each()
    self.length.times do |k|
      result = yield self[k] if block?
      puts result
    end
    self
  end
end

my_each([8, 3, 6, 8, 4].my_each) do |i|
  i
end
