# Original source and reference https://www.youtube.com/watch?v=NmxHw_bHhGM
input = File.open("input1.txt", "r")

pairs, *blocks = input.read.split("\n\n")

seeds = []
pairs.split(':').last.split.map(&:to_i).each_slice(2){|s, r| seeds << [s, s + r]}

for block in blocks
  ranges = []
  for line in block.split("\n")[1..]
    ranges << line.split.map(&:to_i)
  end
  new = []
  until seeds.empty?
    s, e = seeds.pop
    mapped = false
    for a, b, c in ranges
      os = [s, b].max
      oe = [e, b + c].min
      if os < oe
        mapped = true
        new << [os - b + a, oe - b + a]
        if os > s
          seeds << [s, os]
        end
        if oe > e
          seeds << [oe, e]
        end
      end
    end
    if !mapped
      new << [s, e]
    end
  end
  seeds = new
end

p seeds.min.first
