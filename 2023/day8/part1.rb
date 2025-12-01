# frozen_string_literal: true

input = File.open('input.txt', 'r')

instructions, directions = input.read.split("\n\n")
map = {}
directions.split("\n").each do |dir|
  from, to = dir.split('=')
  from.strip!
  map[from] = to.gsub(/[\(\)]/, '').split(',').map(&:strip)
end

def traverse(from, target, instructions, map)
  path = []
  location = from
  i = 0
  until location == target
    path << location
    if instructions[i] == 'L'
      location = map[location][0]
    else
      location = map[location][1]
    end
    i = (i + 1) % instructions.length
  end
  return path
end

puts traverse('AAA', 'ZZZ', instructions, map).size
