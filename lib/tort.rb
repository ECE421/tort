require 'parallel'

# stub class for development
class Tort
  public

  def initialize(process_workers = Parallel.processor_count)
    @process_workers = process_workers
  end

  def tort_sort(unsorted_array)
    sorted_sub_arrays = Parallel.map(chunk_array(unsorted_array), in_processes: @process_workers, &:sort)
    sorted_sub_arrays.inject(&method(:merge)).to_a
  end

  protected

  def chunk_array(array)
    array.each_slice((array.size / @process_workers.to_f).ceil).to_a
  end

  def merge(left_array, right_array)
    if right_array.empty?
      return left_array # We have nothing to compare. Left wins.
    end

    if left_array.empty?
      return right_array # We have nothing to compare. Right wins.
    end

    smallest_number = if left_array.first <= right_array.first
                        left_array.shift
                      else
                        right_array.shift
                      end

    # We keep doing it until the left or right array is empty.
    recursive = merge(left_array, right_array)

    # Okay, either left or right array are empty at this point. So we have a result.
    [smallest_number].concat(recursive)
  end
end
