require 'parallel'

# Multi-threaded / multi-processed sort for Ruby
class Tort
  def self.tort_thread_sort(unsorted_array, thread_workers = Parallel.processor_count, &block)
    Parallel.map(chunk_array(unsorted_array, thread_workers), in_threads: thread_workers) do |sub_array|
      sub_array.sort(&block)
    end.inject(&method(:merge))
  end

  def self.tort_process_sort(unsorted_array, process_workers = Parallel.processor_count, &block)
    Parallel.map(chunk_array(unsorted_array, process_workers), in_processes: process_workers) do |sub_array|
      sub_array.sort(&block)
    end.inject(&method(:merge))
  end

  def self.chunk_array(array, workers)
    array.each_slice([(array.size / workers), 1].max)
  end

  private_class_method :chunk_array

  def self.merge(left, right)
    result = []
    result << (left[0] <= right[0] ? left : right).shift until left.empty? || right.empty?
    result.concat(left).concat(right)
  end

  private_class_method :merge
end
