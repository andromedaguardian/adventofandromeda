# frozen_string_literal: true

input = File.open('input.txt', 'r')

def next_seq(seq)
  1.upto(seq.size - 1).map { |i| seq[i] - seq[i - 1] }
end

def next_value(seq)
  return 0 if seq.all?(&:zero?)
  # seq.last + next_value(next_seq(seq)) # part1
  seq.first - next_value(next_seq(seq)) # part2
end

total = 0
input.each_line do |line|
  seq = line.chomp.split.map(&:to_i)
  total += next_value(seq)
end

puts(total)
