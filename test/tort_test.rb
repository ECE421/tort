require_relative 'helper'

class TortTest < Test::Unit::TestCase
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_tort_thread_sort
    unsorted_array = [-3, 0, 2, 1, 3, -1, -2]
    assert_equal(unsorted_array.sort, Tort.tort_thread_sort(unsorted_array))
  end

  def test_tort_thread_sort_rand
    unsorted_array = Array.new(10) { rand(-10_000_000...10_000_000) }
    assert_equal(unsorted_array.sort, Tort.tort_thread_sort(unsorted_array))
  end

  def test_tort_process_sort
    unsorted_array = [-3, 0, 2, 1, 3, -1, -2]
    assert_equal(unsorted_array.sort, Tort.tort_process_sort(unsorted_array))
  end

  def test_tort_process_sort_rand
    unsorted_array = Array.new(10) { rand(-10_000_000...10_000_000) }
    assert_equal(unsorted_array.sort, Tort.tort_process_sort(unsorted_array))
  end
end
