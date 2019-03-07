require_relative 'helper'

class TortTest < Test::Unit::TestCase
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_tort_thread_sort_rand
    unsorted_array = Array.new(10) { rand(-10_000_000...10_000_000) }
    assert_equal(unsorted_array.sort, Tort.thread_sort(unsorted_array, Parallel.processor_count, 10_000))
  end

  def test_tort_thread_sort_timeout
    unsorted_array = Array.new(100_000) { rand(-10_000_000...10_000_000) }
    assert_raise(Parallel::Kill) { Tort.thread_sort(unsorted_array, Parallel.processor_count, 1000) }
  end

  def test_tort_process_sort_rand
    unsorted_array = Array.new(10) { rand(-10_000_000...10_000_000) }
    assert_equal(unsorted_array.sort, Tort.process_sort(unsorted_array, Parallel.processor_count, 10_000))
  end

  def test_tort_process_sort_timeout
    unsorted_array = Array.new(100_000) { rand(-10_000_000...10_000_000) }
    assert_raise(Parallel::Kill) { Tort.process_sort(unsorted_array, Parallel.processor_count, 1000) }
  end
end
