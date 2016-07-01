require_relative 'heap'

class Array
  def heap_sort!
  	max_heap = BinaryMaxHeap.new

    2.upto(count).each { |heap_size| max_heap.heapify_up!(self, heap_size - 1) }

    count.downto(2).each do |heap_size|
      self[heap_size - 1], self[0] = self[0], self[heap_size - 1]
      max_heap.heapify_down!(self, heap_size - 1)
    end

    self
  end
end
