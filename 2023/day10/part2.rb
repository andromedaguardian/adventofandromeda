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

def next_position(pos, step)
  dir = $directions[step]
  pos.zip(dir).map { |d, offset| d + offset }
end

def next_step(from_tile, step)
  $tiles[from_tile].include?($connections[step]) ? ($tiles[from_tile] - [$connections[step]]).pop : nil
end

def hit_edge(pipes, pos)
  pos[0] < 0 || pos[0] >= pipes.size || pos[1] < 0 || pos[1] >=  pipes.first.size
end

def find_loop(pipes, pos, step)
  loop_path = []
  find = false
  loop do
    tile = pipes[pos[0]][pos[1]]
    if tile == 'S'
      find = true
      break
    end
    break if tile == '.'
    loop_path <<  pos
    step = next_step(tile, step)
    break if step.nil?
    pos = next_position(pos, step)
    break if hit_edge(pipes, pos)
  end
  return loop_path.push(pos) if find
  loop_path = []
end

start_pos = nil
pipes.size.times do |i|
  pipes[i].size.times do |j|
    if pipes[i][j] == 'S'
      start_pos = [i, j]
      break
    end
  end
end

loop_path = nil
$connections.each_value do |step|
  loop_path = find_loop(pipes, next_position(start_pos, step), step)
  break unless loop_path.empty?
end

moves = []
start_and_end_of_loop = [loop_path[0], loop_path[-2]]
start_and_end_of_loop.each do |pos|
  p1, p2 = pos
  step1 = p1 - start_pos[0]
  step2 = p2 - start_pos[1]
  $directions.each {|k, v| moves << k if [step1, step2] == v}
end
$tiles.each do |k, v|
  if v == moves
    pipes[start_pos[0]][start_pos[1]] = k
    break
  end
end

dots_grid = Array.new(pipes.size) { |i| Array.new(pipes[i].size) { '.' } }
loop_path.each { |i, j| dots_grid[i][j] = pipes[i][j] }
pipes = dots_grid

outside = []

# reference https://github.com/hyper-neutrino/advent-of-code/blob/main/2023/day10p2.py
pipes.each.with_index do |row, i|
  inside = false
  pass_wall = nil
  row.each.with_index do |c, j|
    if c == '|' && pass_wall.nil?
      inside = !inside
    elsif %w[L F].include?(c)
      pass_wall = c == 'L'
    elsif %w[J 7].include?(c)
      if !pass_wall.nil? 
        inside = !inside if c != (pass_wall ? 'J' : '7')
      end
      pass_wall = nil
    end
    unless inside
      outside << [i, j]
    end 
  end
end

puts (pipes.size * pipes.first.size) - (outside | loop_path).size
