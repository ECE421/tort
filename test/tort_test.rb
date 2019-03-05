require_relative 'helper'

# Compare runtimes between tort's sort and a standard Ruby **unoptimized** sort
def tort_sort_faster?(unsorted_array)
  # multi-threaded sort
  sorter = Tort.new
  start = Time.now
  sorter.tort_sort(unsorted_array, &:<=>)
  finish = Time.now
  tort_time = finish - start

  # normal sort
  start = Time.now
  unsorted_array.sort(&:<=>)
  finish = Time.now
  normal_unoptimized_time = finish - start
  tort_time < normal_unoptimized_time
end

class TortTest < Test::Unit::TestCase
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_initialization
    sorter = Tort.new
    assert_true(sorter.is_a?(Tort))
  end

  def test_tort_sort
    unsorted_array = [2, 1, 3]
    sorter = Tort.new
    assert_equal(unsorted_array.sort, sorter.tort_sort(unsorted_array))
  end

  def test_tort_sort_rand
    unsorted_array = Array.new(10_000) { rand(1...10_000) }
    sorter = Tort.new
    assert_equal(unsorted_array.sort, sorter.tort_sort(unsorted_array))
  end

  def benchmark_tort_sort_small
    unsorted_array = Array.new(10_000) { rand(1...10_000_000) }
    assert_false(tort_sort_faster?(unsorted_array))
  end

  def benchmark_tort_sort_large
    unsorted_array = Array.new(10_000_000) { rand(1...10_000_000) }
    assert_true(tort_sort_faster?(unsorted_array))
  end
end
