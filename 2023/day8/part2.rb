# frozen_string_literal: true

# performace improvement based on https://github.com/hyper-neutrino/advent-of-code/blob/main/2023/day08p2.py

input = File.open('input.txt', 'r')

instructions, directions = input.read.split("\n\n")
map = {}
directions.split("\n").each do |dir|
  from, to = dir.split('=')
  from.strip!
  map[from] = to.strip.slice(1...-1).split(',').map(&:strip)
end

locations = map.each_key.filter { |k| k[-1] == 'A' }

cycles = locations.map do |location|
  cycle = [] 
  step_count = 0
  i = 0
  first_z = nil

  loop do
    while step_count == 0 || location[-1] != 'Z'
      step_count += 1
      if instructions[i] == 'L'
        location = map[location][0]
      else
        location = map[location][1]
      end
      i = (i + 1) % instructions.length
    end
    cycle.push(step_count)
    if first_z.nil?
      first_z = location
      step_count = 0
    elsif location == first_z
      break
    end
  end
  cycle
end

nums = cycles.map { |cycle| cycle[0] }

lcm = nums.pop

nums.each { |num| lcm = lcm * num / lcm.gcd(num) }

puts lcm
