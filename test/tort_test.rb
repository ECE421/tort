require_relative 'helper'

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
    unsorted_array = Array.new(10000) { rand(1...10000) }
    sorter = Tort.new
    assert_equal(unsorted_array.sort, sorter.tort_sort(unsorted_array))
  end
end
