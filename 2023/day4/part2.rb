input = File.open("input2.txt", "r")

scratchcards = Hash.new{|hash,key| hash[key] = 1}

input.each_line do |game|
  gameid, cards = game.chomp.split(':')
  i = gameid.split.last.to_i
  win_numbers, my_numbers = cards.split('|').map(&:split)
  valid_numbers = (win_numbers & my_numbers).size
  valid_numbers.times {scratchcards[i + _1 + 1] += scratchcards[i]}
end

puts scratchcards.each_value.sum
