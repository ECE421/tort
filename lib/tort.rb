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

  # merge two sorted sub arrays
  #
  # Note: this method supports TCO
  def merge(part_a, part_b)
    array = []
    offset_a = 0
    offset_b = 0
    while offset_a < part_a.count && offset_b < part_b.count
      a = part_a[offset_a]
      b = part_b[offset_b]

      # Take the smallest of the two, and push it on our array
      if a <= b
        array << a
        offset_a += 1
      else
        array << b
        offset_b += 1
      end
    end

    # There is at least one element left in either part_a or part_b (not both)
    while offset_a < part_a.count
      array << part_a[offset_a]
      offset_a += 1
    end

    while offset_b < part_b.count
      array << part_b[offset_b]
      offset_b += 1
    end

    array
  end
end
