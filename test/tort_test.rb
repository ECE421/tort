require_relative 'helper'

class TortTest < Test::Unit::TestCase
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_thread_sort_rand
    unsorted_array = Array.new(10) { rand(-10_000_000...10_000_000) }
    assert_equal(unsorted_array.sort, Tort.thread_sort(unsorted_array, 10))
  end

  def test_thread_sort_timeout
    unsorted_array = Array.new(100_000) { rand(-10_000_000...10_000_000) }
    assert_raise(Parallel::Kill) { Tort.thread_sort(unsorted_array, 0.1) }
  end

  def test_process_sort_rand
    unsorted_array = Array.new(10) { rand(-10_000_000...10_000_000) }
    assert_equal(unsorted_array.sort, Tort.process_sort(unsorted_array, 10))
  end

  def test_process_sort_timeout
    unsorted_array = Array.new(100_000) { rand(-10_000_000...10_000_000) }
    assert_raise(Parallel::Kill) { Tort.process_sort(unsorted_array, 0.1) }
  end
end
