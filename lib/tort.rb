require 'parallel'

# Multi-threaded / multi-processed (merge sort based) sorting for Ruby
class Tort
  # Sort an array utilizing concurrency via multiple processes.
  def self.thread_sort(unsorted_array, duration, thread_workers = Parallel.processor_count, &block)
    Timeout.timeout(duration) do
      Parallel.map(chunk_array(unsorted_array, thread_workers), in_threads: thread_workers) do |sub_array|
        sub_array.sort(&block)
      end.reduce(&method(:merge))
    end
  end

  # Sort an array utilizing concurrency via multiple processes.
  def self.process_sort(unsorted_array, duration, process_workers = Parallel.processor_count, &block)
    Timeout.timeout(duration) do
      Parallel.map(chunk_array(unsorted_array, process_workers), in_processes: process_workers) do |sub_array|
        sub_array.sort(&block)
      end.reduce(&method(:merge))
    end
  end

  # Chunk an array into a list of sub arrays optimal for processing
  # by the number of workers specified.
  def self.chunk_array(array, workers)
    array.each_slice([(array.size / workers), 1].max)
  end

  private_class_method :chunk_array

  # Merge two **sorted** arrays.
  def self.merge(left, right)
    result = []
    result << (left[0] <= right[0] ? left : right).shift until left.empty? || right.empty?
    result.concat(left).concat(right)
  end

  private_class_method :merge
end
