class BinaryHeap
  def initialize(comparator)
    raise "Invalid comparator" unless [:<, :>].include?(comparator)
    @comparator, @store = comparator, []
  end

  def count
    @store.length
  end

  def extract
    return nil if @store.empty?
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    heapify_down!
    val
  end

  def heapify_down!(array = @store, len = array.length)
    parent_idx = 0

    until (child_idx = child_to_swap_index(parent_idx, len, array)).nil?
      break if heap_condition_is_satisfied?(parent_idx, child_idx, array)

      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      parent_idx = child_idx
    end
  end

  def heapify_up!(array = @store, child_idx = array.length - 1)
    until (parent_idx = parent_index(child_idx)).nil?
      break if heap_condition_is_satisfied?(parent_idx, child_idx, array)

      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
    end
  end

  def peek
    @store.first
  end

  def push(val)
    @store << val
    heapify_up!
    val
  end

  private

  def child_to_swap_index(parent_idx, length, array)
    # Returns the index of the smallest child in a min heap, or the index of the 
    # largest child in a max heap. Returns nil when parent_idx has no children
    [(2 * parent_idx) + 1, (2 * parent_idx) + 2]
      .select { |idx| idx < length }
      .send("#{@comparator == :> ? :max : :min}_by") { |idx| array[idx] }
  end

  def heap_condition_is_satisfied?(parent_idx, child_idx, array)
    array[parent_idx].send("#{@comparator}=", array[child_idx])
  end

  def parent_index(child_idx)
    child_idx > 0 ? (child_idx - 1) / 2 : nil
  end
end

class BinaryMaxHeap < BinaryHeap
  def initialize
    super(:>)
  end

  alias_method :max, :peek
end

class BinaryMinHeap < BinaryHeap
  def initialize
    super(:<)
  end

  alias_method :min, :peek
end
