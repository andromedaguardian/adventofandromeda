# frozen_string_literal: true

arr = [
  [10, 20, 30],
  [40, 50, 60],
  [70, 80, 90]
]

arr.each.with_index do |x, i|
x.each.with_index do |n, j|
  puts "%d %d == %d" % [i, j, n]
end
end
