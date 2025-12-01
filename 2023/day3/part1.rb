input = File.open("input1.txt", "r")

schematic = input.readlines

rows = schematic.length
cols = schematic.first.length

total = 0

for i in (0...rows)
  number = ''
  is_number = false
  for j in (0...cols)
    c = schematic[i][j]
    if c.match(/\d/)
      is_number = true
      number += c
    else
      if is_number
        is_valid = false
        j0 = j - number.length
        if !is_valid && i-1 > -1
          for k in (j0-1..j)
            if k > -1
              if !schematic[i-1][k].match?(/[\d\.\n]/)
                is_valid = true
                break
              end
            end
          end
        end
        if !is_valid && i+1 < rows
          for k in (j0-1..j)
            if k > -1
              if !schematic[i+1][k].match?(/[\d\.\n]/)
                is_valid = true
                break
              end
            end
          end
        end
        if !is_valid && j0-1 > -1
          is_valid = !schematic[i][j0-1].match?(/[\d\.\n]/)
        end
        if !is_valid && j < cols
          is_valid = !schematic[i][j].match?(/[\d\.\n]/)
        end
        if is_valid
          total += number.to_i
        end
      end
      number = ''
      is_number = false
    end
  end
end


puts total
