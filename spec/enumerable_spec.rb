require 'rspec'
require 'enumerable.rb'

describe Enumerable do
  let(:array) { [2, 4, 6, 4] }
  let(:range) { (1..10) }
  let(:result) { [] }
  let(:my_result) { [] }

  describe '#my_each' do
    it 'iterates through each elements of a range' do
      expect(range.my_each { |x| my_result << x }).to eq(range.each { |x| result << x })
    end

    it 'iterates through each elements of an array' do
      expect(array.my_each { |x| my_result << x }).to eq(array.each { |x| result << x })
    end

    it 'returns an enumerator when no block is passed' do
      expect(array.my_each.is_a?(Enumerator)).to eq(true)
    end

    it 'returns the original array' do
      expect(array.my_each {}).to eq(array)
    end
  end

  describe '#my_each_with_index' do
    it 'iterates through each elements of a range with index' do
      my_each_with_index = range.my_each_with_index { |x, i| my_result << [x, i] }
      original_each_with_index = range.each_with_index { |x, i| result << [x, i] }
      expect(my_each_with_index).to eq(original_each_with_index)
    end

    it 'iterates through each elements of an array with index' do
      my_each_with_index = array.my_each_with_index { |x, i| my_result << [x, i] }
      original_each_with_index = array.each_with_index { |x, i| result << [x, i] }
      expect(my_each_with_index).to eq(original_each_with_index)
    end

    it 'returns an enumerator when no block is passed' do
      expect(array.my_each.is_a?(Enumerator)).to eq(true)
    end

    it 'returns the original array' do
      expect(array.my_each {}).to eq(array.each {})
    end
  end

  describe '#my_select' do
    it 'returns a selection of even numbers from a range' do
      expect(range.my_select(&:even?)).to eq(range.select(&:even?))
    end

    it 'returns a selection of numbers divisible by 3 from a range' do
      expect(range.my_select { |i| i % 3 == 0 }).to eq(range.select { |i| i % 3 == 0 })
    end

    it 'returns a selection of even numbers from an array' do
      expect(array.my_select(&:even?)).to eq(array.select(&:even?))
    end

    it 'returns a selection of numbers divisible by 3 from an array' do
      expect(array.my_select { |i| i % 3 == 0 }).to eq(array.select { |i| i % 3 == 0 })
    end

    it 'returns an enumerator when no block is passed' do
      expect(array.my_select.is_a?(Enumerator)).to eq(true)
    end
  end

  describe '#my_all?' do
    it 'returns true if length of all elements is greater than or equal to 3' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eq(true)
    end

    it 'returns false if length of all elements is not greater than or equal to 4' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eq(false)
    end

    it 'returns false if at least one element fails RegExp pattern matching' do
      expect(%w[ant bear cat].my_all?(/t/)).to eq(false)
    end
    it 'returns true if all elements are Numeric' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eq(true)
    end
    it 'returns false if any element is nil' do
      expect([nil, true, 99].my_all?).to eq(false)
    end
    it 'returns true if array is empty' do
      expect([].my_all?).to eq(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if length of any element is greater than or equal to 3' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eq(true)
    end

    it 'returns true if length of any element is greater than or equal to 4' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eq(true)
    end

    it 'returns false if no element passes RegExp pattern matching' do
      expect(%w[ant bear cat].my_any?(/d/)).to eq(false)
    end
    it 'returns true if any element is an Integer' do
      expect([nil, true, 99].my_any?(Integer)).to eq(true)
    end
    it 'returns true if atleast one element is not nil' do
      expect([nil, true, 99].my_any?).to eq(true)
    end
    it 'returns false if array is empty' do
      expect([].my_any?).to eq(false)
    end
  end

  describe '#my_none?' do
    it 'returns true if none of the elements of an array match the condition' do
      expect(%w[ant bear cat].none? { |word| word.length == 5 }).to eq(true)
    end

    it 'returns false if atleast one element of an array matches the condition' do
      expect(%w[ant bear cat].none? { |word| word.length >= 4 }).to eq(false)
    end

    it 'returns true if none of the elements match the RegExp' do
      expect(%w[ant bear cat].none?(/d/)).to eq(true)
    end
    it 'returns false if atleast one element is of type Float' do
      expect([1, 3.14, 42].none?(Float)).to eq(false)
    end
    it 'returns true if array is empty' do
      expect([].none?).to eq(true)
    end
    it 'returns true if no truthy element is found' do
      expect([nil].none?).to eq(true)
    end
    it 'returns true if no truthy element is found' do
      expect([nil, false].none?).to eq(true)
    end
    it 'returns false if atleast one truthy element is found' do
      expect([nil, false, true].none?).to eq(false)
    end
  end

  describe '#my_count' do
    it 'returns length of the array if no argument or block is given' do
      expect(array.my_count).to eq(array.count)
    end

    it 'returns number of items in the array that match the argument' do
      expect(array.my_count(4)).to eq(array.count(4))
    end

    it 'returns number of items in the array that match the condition in the block' do
      expect(range.my_count(&:even?)).to eq(range.count(&:even?))
    end

    it 'returns number of items in the array that match the condition in the block' do
      expect(range.my_count { |x| x % 3 == 0 }).to eq(range.count { |x| x % 3 == 0 })
    end
  end

  describe '#my_map' do
    it 'returns a modified array after performing actions specified in the block' do
      expect(range.my_map { |i| i * i }).to eq(range.map { |i| i * i })
    end
    it 'returns a modified array after replace elements with given string' do
      expect(range.my_map { 'cat' }).to eq(range.map { 'cat' })
    end
  end

  describe '#my_inject' do
    context 'when no block and no starting value is given' do
      it 'operates the element of a collection' do
        expect((5..10).my_inject(:+)).to eq(45)
      end
    end
    context 'when no block but starting value is given' do
      it 'operates the elements of a collection from the starting value' do
        expect((5..10).my_inject(1, :*)).to eq(151_200)
      end
    end
    context 'when a block is given but no starting value' do
      it 'operates the elements of a collection based on the block' do
        expect((5..10).my_inject { |sum, n| sum + n }).to eq(45)
      end
    end
    context 'when a block and starting value is given' do
      it 'operates the elements of a collection based on the block from the starting value' do
        expect((5..10).inject(1) { |product, n| product * n }).to eq(151_200)
      end
    end
    it 'finds the longest word in the array' do
      longest = %w[cat sheep bear].inject do |memo, word|
        memo.length > word.length ? memo : word
      end
      expect(longest).to eq('sheep')
    end
  end

  describe '#multiply_els' do
    it 'multiplies all elements of the range' do
      expect(multiply_els(range)).to eq(3_628_800)
    end
    it 'multiplies all elements of the array' do
      expect(multiply_els(array)).to eq(192)
    end
  end
end
