input = File.open("input1.txt", "r")
cards = {'2'=>0,'3'=>1,'4'=>2,'5'=>3,'6'=>4,'7'=>5,'8'=>6,'9'=>7,'T'=>8,'J'=>9,'Q'=>10,'K'=>11,'A'=>12}
# cards = {'J'=>0,'2'=>1,'3'=>2,'4'=>3,'5'=>4,'6'=>5,'7'=>6,'8'=>7,'9'=>8,'T'=>9,'Q'=>10,'K'=>11,'A'=>12}
rank = []

input.each_line do |game|
  hand, bid = game.chomp.split
  counts = [0] * cards.size
  hand.each_char{|c| counts[cards[c]] += 1}
  pt = 0
  pt = 1 if counts.include?(2)
  pt = 2 if counts.count(2) == 2
  pt = 3 if counts.include?(3) && !counts.include?(2)
  pt = 4 if counts.include?(3) && counts.include?(2)
  pt = 5 if counts.include?(4)
  pt = 6 if counts.include?(5)
  rank << [pt, bid.to_i, hand]
end

rank.sort! do |a,b|
  r = 0
  if a.first != b.first
    r = a.first <=> b.first
  else
    h1 = a[2]
    h2 = b[2]
    h1.size.times do |i|
      if h1[i] != h2[i] 
        r = cards[h1[i]] <=> cards[h2[i]]
        break
      end
    end
  end
  r
end

puts rank.each_index.map{|i| rank[i][1] * (i + 1)}.sum
