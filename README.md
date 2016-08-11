# About
I set out to write the perfect Ruby binary heap, abstracted to work as a min heap
or a max heap. It also includes a heap sort implementation using `O(1)` extra 
memory.

# Description
I wrote a previous binary min heap in 50 lines, but instead I chose this overly 
verbose monstrosity. 80 lines define a binary min heap and max heap, with 
pedantically descriptive method names. It can easily be modified to store a key 
and a value at each heap node, like [this binary heap/priority queue](https://gist.github.com/aspyct/3428688).

My previous 50-line binary min heap (passes all tests):

```ruby
class BinaryMinHeap
  def initialize
    @store = []
  end

  def count
    @store.length
  end

  def extract
    return nil if @store.empty?
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    self.class.heapify_down!(@store)
    val
  end

  def insert(val)
    @store << val
    self.class.heapify_up!(@store)
    val
  end

  def peek
    @store.first
  end

  def self.child_to_swap_index(array, parent_idx, length)
    [(2 * parent_idx) + 1, (2 * parent_idx) + 2].select { |idx| idx < length }
      .min_by { |idx| array[idx] }
  end

  def self.heapify_down!(array, len = array.length, parent_idx = 0)
    until (child_idx = child_to_swap_index(array, parent_idx, len)).nil?  
      break if array[parent_idx] <= array[child_idx]

      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      parent_idx = child_idx
    end
  end

  def self.heapify_up!(array, child_idx = array.length - 1)
    until (parent_idx = (child_idx - 1) / 2) < 0
      break if array[parent_idx] <= array[child_idx]

      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
    end
  end
end
```

# Tests
Run `rspec spec` to run the test suite.
