require "heap"

describe BinaryMinHeap do
  before(:each) { @heap = BinaryMinHeap.new }
  before(:all) do
    @forbidden_array_methods = [:clone, :collect, :collect!, :collect_concat, 
      :concat, :cycle, :delete, :delete_at, :delete_if, :drop, :dup, :each, 
      :each_index, :entries, :find_all, :find_index, :flat_map, :flatten, 
      :group_by, :include?, :index, :inject, :insert, :map, :map!, :max, 
      :max_by, :min, :min_by, :partition, :rassoc, :reduce, :reject, :reject!, 
      :reverse, :reverse!, :reverse_each, :rindex, :rotate, :select, :select!, 
      :shift, :slice, :slice_after, :slice_before, :slice_when, :sort, :sort!, 
      :sort_by, :sort_by!, :take, :take_while, :unshift, :zip]
  end

  describe "#initialize" do
    it "creates an element store that starts as an empty array" do
      expect(@heap.instance_variable_get(:@store)).to eq([])
    end
  end

  describe ".heapify_down! class method" do
    it "correctly reorders the elements in the store" do
      [7, 4, 5].each { |num| @heap.instance_variable_get(:@store) << num }
      BinaryMinHeap.heapify_down!(@heap.instance_variable_get(:@store))
      expect(@heap.instance_variable_get(:@store)).to eq([4, 7, 5])

      @heap.instance_variable_get(:@store).clear
      [7, 4, 5, 6, 8].each { |num| @heap.instance_variable_get(:@store) << num }
      BinaryMinHeap.heapify_down!(@heap.instance_variable_get(:@store))
      expect(@heap.instance_variable_get(:@store)).to eq([4, 6, 5, 7, 8])
    end

    description = "takes an optional length parameter, indicating the first " +
      "'length' array elements on which the heapify down operation executes"

    it description do
      arr = [7, 4, 5, 6, 8]
      BinaryMinHeap.heapify_down!(arr, 3)
      expect(arr).to eq([4, 7, 5, 6, 8])
    end
  end

  describe ".heapify_up! class method" do
    it "correctly reorders the elements in the store" do
      [4, 5, 1].each { |num| @heap.instance_variable_get(:@store) << num }
      BinaryMinHeap.heapify_up!(@heap.instance_variable_get(:@store))
      expect(@heap.instance_variable_get(:@store)).to eq([1, 5, 4])

      @heap.instance_variable_get(:@store).clear
      [3, 4, 5, 1].each { |num| @heap.instance_variable_get(:@store) << num }
      BinaryMinHeap.heapify_up!(@heap.instance_variable_get(:@store))
      expect(@heap.instance_variable_get(:@store)).to eq([1, 3, 5, 4])
    end

    description = "takes an optional child_index parameter, indicating the " +
      "array index at which the heapify up operation begins execution"

    it description do
      arr = [7, 4, 5, 6, 8, 2, 1]
      BinaryMinHeap.heapify_up!(arr, 4)
      expect(arr).to eq([7, 4, 5, 6, 8, 2, 1])
      BinaryMinHeap.heapify_up!(arr, 5)
      expect(arr).to eq([2, 4, 7, 6, 8, 5, 1])
    end
  end

  describe "#insert" do
    it "adds the new element and reorders the store with heapify_up!" do
      @heap.insert(7)
      expect(@heap.instance_variable_get(:@store)).to eq([7])

      @heap.insert(5)
      expect(@heap.instance_variable_get(:@store)).to eq([5, 7])

      @heap.insert(6)
      expect(@heap.instance_variable_get(:@store)).to eq([5, 7, 6])

      @heap.insert(4)
      expect(@heap.instance_variable_get(:@store)).to eq([4, 5, 6, 7])
    end

    it "does not call any O(n) array methods on @store" do
      @forbidden_array_methods.each do |method|
        expect(@heap.instance_variable_get(:@store)).to_not receive(method)
      end

      [7, 5, 6, 4].each { |el| @heap.insert(el) }
    end
  end

  describe "#extract" do
    it "returns nil when called on a heap with an empty store" do
      expect(@heap.extract).to be_nil
    end

    it "removes and returns the minimum element from a non-empty store" do
      [7, 5, 6, 4].each { |el| @heap.insert(el) }

      expect(@heap.extract).to eq(4)
      expect(@heap.extract).to eq(5)
    end

    it "correctly reorders the store with heapify_down!" do
      [7, 5, 6, 4].each { |el| @heap.insert(el) }

      @heap.extract
      expect(@heap.instance_variable_get(:@store)).to eq([5, 7, 6])
      @heap.extract
      expect(@heap.instance_variable_get(:@store)).to eq([6, 7])
    end

    it "works on a heap containing exactly one element" do
      @heap.insert(3)
      expect(@heap.extract).to eq(3)
      expect(@heap.instance_variable_get(:@store)).to eq([])
    end
    
    it "does not call any O(n) array methods on @store" do
      [7, 5, 6, 4].each { |el| @heap.insert(el) }
      @forbidden_array_methods.each do |method|
        expect(@heap.instance_variable_get(:@store)).to_not receive(method)
      end

      @heap.extract
    end
  end

  describe "#count" do
    it "returns the number of elements contained in the store" do
      expect(@heap.count).to eq(0)
      [7, 5, 6, 4].each { |el| @heap.insert(el) }
      expect(@heap.count).to eq(4)
    end
  end

  describe "#peek" do
    it "returns nil when the store is empty" do
      expect(@heap.peek).to be_nil
    end

    it "returns the minimum element in the heap without affecting the store" do
      [7, 5, 6, 4].each { |el| @heap.insert(el) }
      expect(@heap.peek).to eq(4)
      expect(@heap.instance_variable_get(:@store)).to eq([4, 5, 6, 7])
    end
  end
end
