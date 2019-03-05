require_relative 'helper'

# Compare the sorting run-times of a specified unsorted_array between tort's sort
# and a standard Ruby **unoptimized** sort.
def tort_sort_faster?(unsorted_array)
  # multi-threaded sort
  sorter = Tort.new
  start = Time.now
  tort_sorted_array = sorter.tort_sort(unsorted_array, &:<=>)
  finish = Time.now
  tort_time = finish - start
  puts('tort sort time: ' + tort_time.to_s)

  # normal sort
  start = Time.now
  normal_unoptimized_sorted_array = unsorted_array.sort(&:<=>)
  finish = Time.now
  normal_unoptimized_time = finish - start
  puts('normal ruby unoptimized sort time: ' + normal_unoptimized_time.to_s)

  assert_equal(normal_unoptimized_sorted_array, tort_sorted_array)

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
    unsorted_array = Array.new(10_000) { rand(1...10_000_000) }
    sorter = Tort.new
    assert_equal(unsorted_array.sort, sorter.tort_sort(unsorted_array))
  end

  def test_benchmark_tort_sort_small
    unsorted_array = Array.new(10_000) { rand(1...10_000_000) }
    assert_false(tort_sort_faster?(unsorted_array))
  end

  ## TODO: this fails on travis as its multi core performance is poor
  # def test_benchmark_tort_sort_large
  #   unsorted_array = Array.new(100_000_000) { rand(1...10_000_000) }
  #   assert_true(tort_sort_faster?(unsorted_array))
  # end
end
