input = File.open("input1.txt", "r")

# races = input.readlines(chomp: true).map{|line| line.split(':').last.split.map(&:to_i)}
# races = races[0].zip(races[1])
races = [input.readlines(chomp: true).map{|line| line.split(':').last.split.join('').to_i}]


# counts = races.map do |t, d|
#   t.times.reduce{|c, x| (t - x) * x > d ? c += 1 : c}
# end

counts = races.map do |t, d|
  c = 0
  c += 1 until (t - c) * c > d
  (t - c) - c + 1
end

puts counts.reduce(&:*)

