# This Library was made by:
#
# Group 4:
#   Nathan Klapstein (1449872)
#   Tony Qian (1396109)
#   Thomas Lorincz (1461567)
#   Zach Drever (1446384)
#

require_relative 'lib/tort'

unsorted_array = Array.new(10) { rand(-10_000_000...10_000_000) }
assert_equal(unsorted_array.sort, Tort.thread_sort(unsorted_array, 1))
