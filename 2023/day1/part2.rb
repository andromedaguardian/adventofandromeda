input = File.open("input2.txt", "r")

total = 0

input.each_line do |s|
  ns = ''
  s.each_char do |c|
    ns += c
    # the values need to be equal 'number + last letter' for it to work in cases like
    # sevenine = 79 
    [
      [/one/, '1e'],
      [/two/, '2o'],
      [/three/, '3e'],
      [/four/, '4r'],
      [/five/, '5e'],
      [/six/, '6x'],
      [/seven/, '7n'],
      [/eight/, '8t'],
      [/nine/, '9e'],
    ].each do |pattern, value|
        ns.gsub!(pattern, value)
      end
  end
  ns.chomp!.gsub!(/[a-z]/, '')
  next unless ns.length > 0
  n = ns[0] + ns[-1]
  total += n.to_i 
end

puts total
