input = File.open("input1.txt", "r")

total = 0

input.each_line do |card|
  card_numbers, guess_numbers = card.chomp.split(':').last.split('|').map(&:split)
  total_valid_numbers = (card_numbers & guess_numbers).size - 1
  total += 2.pow(total_valid_numbers) if total_valid_numbers > -1
end

puts total
