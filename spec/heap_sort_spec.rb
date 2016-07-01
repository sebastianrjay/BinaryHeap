require "heap_sort"

describe Array do
  describe "#heap_sort!" do
    it "sorts an unsorted array" do
      arr = [4,2,1,3,5,7,8,9]
      arr.heap_sort!

      expect(arr).to eq([1,2,3,4,5,7,8,9])
    end

    it "sorts a reversed array" do
      arr = [5,4,3,2,1]
      arr.heap_sort!

      expect(arr).to eq([1,2,3,4,5])
    end

    it "doesn't change a sorted array" do
      arr = [1,2,3,4,5]
      arr.heap_sort!

      expect(arr).to eq([1,2,3,4,5])
    end

    it "works on an empty array" do
      arr = []
      arr.heap_sort!

      expect(arr).to eq([])
    end

    it "does not make a copy of the array" do
      forbidden_array_methods = [:collect, :dup, :inject, :map, :reduce, :reverse, :slice]
      arr = [1, 2, 3, 4, 5]
      forbidden_array_methods.each {|method| expect(arr).to_not receive(method) }
      new_arr = arr.heap_sort!

      expect(arr.object_id).to eq(new_arr.object_id)
    end
  end
end
