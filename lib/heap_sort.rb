require_relative 'heap'

class Array
  def heap_sort!
  	min_heap = BinaryMinHeap.new

    2.upto(count).each do |heap_sz|
      min_heap.heapify_up!(self, heap_sz - 1)
    end

    count.downto(2).each do |heap_sz|
      self[heap_sz - 1], self[0] = self[0], self[heap_sz - 1]
      min_heap.heapify_down!(self, heap_sz - 1)
    end

    self.reverse!
  end
end
