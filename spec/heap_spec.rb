require "heap"

describe BinaryMinHeap do
  before(:each) { @heap = BinaryMinHeap.new }
  before(:all) do
    @forbidden_array_methods = [:collect, :collect!, :concat, :delete, 
      :delete_at, :delete_if, :drop, :each, :each_index, :find_index, :flatten, 
      :include?, :index, :insert, :map, :map!, :max, :max_by, :min, :min_by, 
      :rassoc, :reject, :reject!, :reverse, :reverse!, :reverse_each, :rindex, 
      :rotate, :select, :select!, :shift, :slice, :sort, :sort!, :sort_by, 
      :sort_by!, :take, :take_while, :unshift]
  end

  describe "#initialize" do
    it "creates an element store that starts as an empty array" do
      expect(@heap.instance_variable_get(:@store)).to eq([])
    end
  end

  describe ".heapify_down!" do
    it "correctly reorders the elements in the store" do
      [7, 4, 5].each { |num| @heap.instance_variable_get(:@store) << num }
      BinaryMinHeap.heapify_down!(@heap.instance_variable_get(:@store))
      expect(@heap.instance_variable_get(:@store)).to eq([4, 7, 5])

      @heap.instance_variable_get(:@store).clear
      [7, 4, 5, 6, 8].each { |num| @heap.instance_variable_get(:@store) << num }
      BinaryMinHeap.heapify_down!(@heap.instance_variable_get(:@store))
      expect(@heap.instance_variable_get(:@store)).to eq([4, 6, 5, 7, 8])
    end
  end

  describe ".heapify_up!" do
    it "correctly reorders the elements in the store" do
      [4, 5, 1].each { |num| @heap.instance_variable_get(:@store) << num }
      BinaryMinHeap.heapify_up!(@heap.instance_variable_get(:@store))
      expect(@heap.instance_variable_get(:@store)).to eq([1, 5, 4])

      @heap.instance_variable_get(:@store).clear
      [3, 4, 5, 1].each { |num| @heap.instance_variable_get(:@store) << num }
      BinaryMinHeap.heapify_up!(@heap.instance_variable_get(:@store))
      expect(@heap.instance_variable_get(:@store)).to eq([1, 3, 5, 4])
    end
  end

  describe "#push" do
    it "adds the new element and reorders the store with heapify_up!" do
      @heap.push(7)
      expect(@heap.instance_variable_get(:@store)).to eq([7])

      @heap.push(5)
      expect(@heap.instance_variable_get(:@store)).to eq([5, 7])

      @heap.push(6)
      expect(@heap.instance_variable_get(:@store)).to eq([5, 7, 6])

      @heap.push(4)
      expect(@heap.instance_variable_get(:@store)).to eq([4, 5, 6, 7])
    end

    it "does not call any O(n) array methods on @store" do
      @forbidden_array_methods.each do |method|
        expect(@heap.instance_variable_get(:@store)).to_not receive(method)
      end

      [7, 5, 6, 4].each { |el| @heap.push(el) }
    end
  end

  describe "#extract" do
    it "returns nil when called on a heap with an empty store" do
      expect(@heap.extract).to be_nil
    end

    it "removes and returns the minimum element from a non-empty store" do
      [7, 5, 6, 4].each { |el| @heap.push(el) }

      expect(@heap.extract).to eq(4)
      expect(@heap.extract).to eq(5)
    end

    it "correctly reorders the store with heapify_down!" do
      [7, 5, 6, 4].each { |el| @heap.push(el) }

      @heap.extract
      expect(@heap.instance_variable_get(:@store)).to eq([5, 7, 6])
      @heap.extract
      expect(@heap.instance_variable_get(:@store)).to eq([6, 7])
    end

    it "works on a heap containing exactly one element" do
      @heap.push(3)
      expect(@heap.extract).to eq(3)
      expect(@heap.instance_variable_get(:@store)).to eq([])
    end
    
    it "does not call any O(n) array methods on @store" do
      [7, 5, 6, 4].each { |el| @heap.push(el) }
      @forbidden_array_methods.each do |method|
        expect(@heap.instance_variable_get(:@store)).to_not receive(method)
      end

      @heap.extract
    end
  end

  describe "#count" do
    it "returns the number of elements contained in the store" do
      expect(@heap.count).to eq(0)
      [7, 5, 6, 4].each { |el| @heap.push(el) }
      expect(@heap.count).to eq(4)
    end
  end

  describe "#peek" do
    it "returns nil when the store is empty" do
      expect(@heap.peek).to be_nil
    end

    it "returns the minimum element in the heap without affecting the store" do
      [7, 5, 6, 4].each { |el| @heap.push(el) }
      expect(@heap.peek).to eq(4)
      expect(@heap.instance_variable_get(:@store)).to eq([4, 5, 6, 7])
    end
  end
end
