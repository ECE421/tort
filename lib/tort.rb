require 'parallel'

# Multi-threaded / multi-processed sort for Ruby
class Tort
  def self.tort_thread_sort(unsorted_array, thread_workers = Parallel.processor_count, &block)
    sorted_sub_arrays = Parallel.map(chunk_array(unsorted_array, thread_workers), in_threads: thread_workers) do |sub_array|
      sub_array.sort(&block)
    end
    sorted_sub_arrays.inject(&method(:merge))
  end

  def self.tort_process_sort(unsorted_array, process_workers = Parallel.processor_count, &block)
    sorted_sub_arrays = Parallel.map(chunk_array(unsorted_array, process_workers), in_processes: process_workers) do |sub_array|
      sub_array.sort(&block)
    end
    parallel_process_merging(sorted_sub_arrays, process_workers)
  end


  def self.parallel_process_merging(sorted_sub_arrays, process_workers)
    while sorted_sub_arrays.count > 1
      puts(sorted_sub_arrays.to_s)  # debug
      puts(sorted_sub_arrays.each_slice(2).to_a.to_s)
      sorted_sub_arrays = Parallel.map(sorted_sub_arrays.each_slice(2), in_processes: process_workers) do |sorted_sub_array1, sorted_sub_array2 = []|
        merge(sorted_sub_array1, sorted_sub_array2)
      end
    end
    sorted_sub_arrays[0]
  end

  def self.chunk_array(array, workers)
    array.each_slice((array.size / workers.to_f).ceil)
  end

  # merge two sorted sub arrays
  #
  # Note: this method supports TCO
  def self.merge(left_array, right_array)
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
