require 'parallel'

# Multi-threaded / multi-processed sort for Ruby
class Tort
  def initialize(process_workers = Parallel.processor_count)
    @process_workers = process_workers
  end

  def tort_sort(unsorted_array, &block)
    sorted_sub_arrays = Parallel.map(chunk_array(unsorted_array), in_processes: @process_workers) do |sub_array|
      sub_array.sort(&block)
    end
    sorted_sub_arrays.inject(&method(:merge))
  end

  protected

  def chunk_array(array)
    array.each_slice((array.size.to_f / @process_workers.to_f).ceil).to_a
  end

  # merge two sorted sub arrays
  #
  # Note: this method supports TCO
  def merge(left_array, right_array)
    merged_array = []
    offset_left = 0
    offset_right = 0
    while offset_left < left_array.count && offset_right < right_array.count
      left_element = left_array[offset_left]
      right_element = right_array[offset_right]

      # Take the smallest of the two, and push it on our array
      if left_element <= right_element
        merged_array << left_element
        offset_left += 1
      else
        merged_array << right_element
        offset_right += 1
      end
    end

    # There is at least one element left in either part_a or part_b (not both)
    while offset_left < left_array.count
      merged_array << left_array[offset_left]
      offset_left += 1
    end

    while offset_right < right_array.count
      merged_array << right_array[offset_right]
      offset_right += 1
    end

    merged_array
  end
end
