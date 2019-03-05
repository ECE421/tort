require 'tort'

# code for testing / benchmarking tort vs Ruby Array.sort

def tort_process_sort_time(array)
  start = Time.now
  Tort.tort_process_sort(array, &:<=>)
  finish = Time.now
  total_time = finish - start
  puts('tort_process_sort time: ' + total_time.to_s + 's')
  total_time
end

def tort_thread_sort_time(array)
  start = Time.now
  Tort.tort_thread_sort(array, &:<=>)
  finish = Time.now
  total_time = finish - start
  puts('tort_thread_sort time: ' + total_time.to_s + 's')
  total_time
end

def normal_unoptimized_sort_time(array)
  start = Time.now
  array.sort(&:<=>)
  finish = Time.now
  total_time = finish - start
  puts('normal ruby unoptimized sort time: ' + total_time.to_s + 's')
  total_time
end

def normal_sort_time(array)
  start = Time.now
  array.sort
  finish = Time.now
  total_time = finish - start
  puts('normal ruby sort time: ' + total_time.to_s + 's')
  total_time
end

unsorted_array = Array.new(10_000_000) { rand(-100_000_000...100_000_000) }.to_a

normal_sort_time(unsorted_array)
normal_unoptimized_sort_time(unsorted_array)
tort_thread_sort_time(unsorted_array)
tort_process_sort_time(unsorted_array)
