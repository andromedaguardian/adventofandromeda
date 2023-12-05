input = File.open("input1.txt", "r")

max_red   = 12
max_green = 13
max_blue  = 14

total = 0

input.each_line do |game|
  game_id, game_data = game.chomp.split(':')
  game_id.gsub!(/Game /, '')
  valid_game = true
  hands = game_data.split(';')
  for hand in hands
    cubes = hand.split(',')
    for cube in cubes
      value, color = cube.split(' ')
      if color == 'red'
        valid_game = value.to_i <= max_red
        break unless valid_game
      elsif color == 'green'
        valid_game = value.to_i <= max_green
        break unless valid_game
      elsif color == 'blue'
        valid_game = value.to_i <= max_blue
        break unless valid_game
      end
    end
    break unless valid_game
  end
  if valid_game
    total += game_id.to_i
  end
end

puts total
