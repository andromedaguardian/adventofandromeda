input = File.open("input.txt", "r")

total = 0

input.each_line do |s|
  ns = s.chomp.gsub(/[a-z]/, '')
  next unless ns.length > 0
  n = ns[0] + ns[-1]
  total += n.to_i 
end

puts total
