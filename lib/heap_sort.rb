require_relative 'heap'

class Array
  def heap_sort!
  	2.upto(count).each do |heap_size|
  		BinaryHeap.heapify_up!(self, :<, heap_size - 1)
  	end

    count.downto(2).each do |heap_size|
      self[heap_size - 1], self[0] = self[0], self[heap_size - 1]
      BinaryHeap.heapify_down!(self, :<, heap_size - 1)
    end

    self.reverse!
  end
end
