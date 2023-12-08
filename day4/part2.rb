input = File.open("input2.txt", "r")

total = Hash.new{|hash,key| hash[key] = 1}
i     = 1

input.each_line do |card|
  total[i] = total[i] || 1
  card_numbers, guess_numbers = card.chomp.split(':').last.split('|').map(&:split)
  total_valid_numbers = (card_numbers & guess_numbers).size
  total[i].times { total_valid_numbers.times {total[i + _1 + 1] += 1}}
  i += 1
end

puts total.each_value.sum
