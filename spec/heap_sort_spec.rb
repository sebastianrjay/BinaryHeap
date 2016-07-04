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

    it "does not make a copy of the array, and returns self" do
      arr = [1, 2, 3, 4, 5]

      forbidden_array_methods = [:clone, :collect, :collect_concat, :cycle, 
        :drop, :dup, :entries, :find_all, :flat_map, :group_by, :inject, :map, 
        :partition, :reduce, :reverse, :slice, :slice_after, :slice_before, 
        :slice_when, :take, :zip]
      forbidden_array_methods.each do |method|
        expect(arr).to_not receive(method)
      end
      
      new_arr = arr.heap_sort!

      expect(arr.object_id).to eq(new_arr.object_id)
    end

    it "works on an empty array" do
      arr = []
      
      expect(arr.heap_sort!.object_id).to eq(arr.object_id)
      expect(arr).to eq([])
    end
  end
end
