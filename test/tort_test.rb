require_relative 'helper'

class TortTest < Test::Unit::TestCase
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  # Thread sort tests

  def test_thread_sort_rand
    unsorted_array = Array.new(10) { rand(-10_000_000...10_000_000) }
    assert_equal(unsorted_array.sort, Tort.thread_sort(unsorted_array, 1))
  end

  def test_thread_sort_timeout
    unsorted_array = Array.new(100_000_000) { rand(-10_000_000...10_000_000) }
    assert_raise(Timeout::Error) { Tort.thread_sort(unsorted_array, 0.1) }
  end

  def test_thread_sort_enum
    unsorted_enum = Array.new(10) { rand(-10_000_000...10_000_000) }.to_enum
    assert_equal(unsorted_enum.sort, Tort.thread_sort(unsorted_enum, 1))
  end

  def test_thread_sort_unsortable
    assert_raise(ArgumentError) { Tort.thread_sort([1, 'foo'], 10) }
    assert_raise(ArgumentError) { Tort.thread_sort('foo', 10) }
  end

  def test_thread_sort_invalid_workers
    assert_raise(ArgumentError) { Tort.thread_sort([], 10, -1) }
  end

  # Process sort tests

  def test_process_sort_rand
    unsorted_array = Array.new(10) { rand(-10_000_000...10_000_000) }
    assert_equal(unsorted_array.sort, Tort.process_sort(unsorted_array, 1))
  end

  def test_process_sort_timeout
    unsorted_array = Array.new(100_000_000) { rand(-10_000_000...10_000_000) }
    assert_raise(Timeout::Error) { Tort.process_sort(unsorted_array, 0.1) }
  end

  def test_process_sort_enum
    unsorted_enum = Array.new(10) { rand(-10_000_000...10_000_000) }.to_enum
    assert_equal(unsorted_enum.sort, Tort.process_sort(unsorted_enum, 1))
  end

  def test_process_sort_unsortable
    assert_raise(ArgumentError) { Tort.process_sort([1, 'foo'], 10) }
    assert_raise(ArgumentError) { Tort.process_sort('foo', 10) }
  end

  def test_process_sort_invalid_workers
    assert_raise(ArgumentError) { Tort.process_sort([], 10, -1) }
  end
end
