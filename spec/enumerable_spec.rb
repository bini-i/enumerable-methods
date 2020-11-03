require 'rspec'
require 'enumerable.rb'

describe Enumerable do
    let(:array) {[2,4,6]}
    let(:range) {(1..8)}
    let(:result) {[]}
    let(:my_result) {[]}

    describe "#my_each" do
        it "iterates through each elements of a range" do
            expect(range.my_each{|x| my_result << x}).to eq(range.each{|x| result << x})
        end
        
        it "iterates through each elements of an array" do
            expect(array.my_each{|x| my_result << x}).to eq(array.each{|x| result << x})
        end

        it "returns an enumerator when no block is passed" do
            expect(array.my_each.is_a?(Enumerator)).to eq(true)
        end

        it "returns the original array" do
        expect(array.my_each{}).to eq(array)
        end
    end

    describe "#my_each_with_index" do
        it "iterates through each elements of a range with index" do
            expect(range.my_each_with_index{|x, i| my_result << [x, i]}).to eq(range.each_with_index{|x, i| result << [x, i]})
        end
        
        it "iterates through each elements of an array with index" do
            expect(array.my_each_with_index{|x, i| my_result << [x, i]}).to eq(array.each_with_index{|x, i| result << [x, i]})
        end

        it "returns an enumerator when no block is passed" do
            expect(array.my_each.is_a?(Enumerator)).to eq(true)
        end

        it "returns the original array" do
        expect(array.my_each{}).to eq(array.each{})
        end
    end
end
