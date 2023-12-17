# frozen_string_literal: true

input = File.open('input.txt', 'r')

pipes = input.read.split("\n").map { |t| t.split('') }

$tiles = { 
  '|' => ['N', 'S'],
  '-' => ['E', 'W'],
  'L' => ['N', 'E'],
  'J' => ['N', 'W'],
  '7' => ['S', 'W'],
  'F' => ['S', 'E'],
  '.' => ['Ground'],
  'S' => ['Start']
}

$directions = {
  'N' => [-1,  0],
  'S' => [ 1,  0],
  'E' => [ 0,  1],
  'W' => [ 0, -1]
}

$connections = {
  'N' => 'S',
  'S' => 'N',
  'E' => 'W',
  'W' => 'E'
}

def next_position(pos, con)
  dir = $directions[con]
  pos.zip(dir).map { |d, offset| d + offset }
end

def next_connection(from_tile, con)
  ($tiles[from_tile] - [$connections[con]]).pop
end

def hit_edge(pipes, pos)
  pos[0] < 0 || pos[0] >= pipes.size || pos[1] < 0 || pos[1] >=  pipes.size
end

def find_path(pipes, pos, con)
  path_size = 0
  loop do
    tile = pipes[pos[0]][pos[1]]
    break if tile == 'S'
    break if tile == '.'
    con = next_connection(tile, con)
    pos = next_position(pos, con)
    if hit_edge(pipes, pos)
      path_size = 0
      break
    end
    path_size += 1
  end
  return path_size + 1
end

pos = nil
pipes.size.times do |i|
  pipes[i].size.times do |j|
    if pipes[i][j] == 'S'
      pos = [i, j]
      break
    end
  end
end
paths = []
$connections.each_value { paths << find_path(pipes, next_position(pos, _1), _1) / 2 }

puts paths.max
