input = File.open("input2.txt", "r")

total = 0

input.each_line do |game|
  game_id, game_data = game.chomp.split(':')
  game_id.gsub!(/Game /, '')
  hands = game_data.split(';')
  max_red = 0
  max_green = 0
  max_blue = 0
  for hand in hands
    cubes = hand.split(',')
    for cube in cubes
      value, color = cube.split(' ')
      if color == 'red'
        max_red = [max_red, value.to_i].max
      elsif color == 'green'
        max_green = [max_green, value.to_i].max
      elsif color == 'blue'
        max_blue = [max_blue, value.to_i].max
      end
    end
  end
    total += max_red * max_green * max_blue
end

puts total
