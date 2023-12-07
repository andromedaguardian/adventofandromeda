input = File.open("input2.txt", "r")

engine = input.readlines

rows = engine.length
cols = engine.first.length

total = 0

for i in (0...rows)
  for j in (0...cols)
    if engine[i][j] == "*"
      numbers = []
      i0 = i - 1
      if i0 > -1 
        n1 = ''
        n2 = ''
        n3 = ''
        j0 = j - 1
        if j0 > -1
          if engine[i0][j0].match?(/\d/)
            n = ''
            while j0 > -1
              if engine[i0][j0].match?(/\d/)
                n += engine[i0][j0]
              else
                break
              end
              j0 -= 1
            end
            n1 = n.reverse
          end
        end
        if engine[i0][j].match?(/\d/)
          n2 = engine[i0][j]
        end
        j0 = j + 1
        if j0 < cols
          if engine[i0][j0].match?(/\d/)
            n = ''
            while j0 < cols
              if engine[i0][j0].match?(/\d/)
                n += engine[i0][j0]
              else
                break
              end
              j0 += 1
            end
            n3 = n
          end
        end
        if !n2.empty?
          numbers << (n1 + n2 + n3).to_i
        else
          if !n1.empty?
            numbers << n1.to_i 
          end
          if !n3.empty?
            numbers << n3.to_i
          end
        end
      end
      i0 = i + 1
      if i0 < rows
        n1 = ''
        n2 = ''
        n3 = ''
        j0 = j - 1
        if j0 > -1
          if engine[i0][j0].match?(/\d/)
            n = ''
            while j0 > -1
              if engine[i0][j0].match?(/\d/)
                n += engine[i0][j0]
              else
                break
              end
              j0 -= 1
            end
            n1 = n.reverse
          end
        end
        if engine[i0][j].match?(/\d/)
          n2 = engine[i0][j]
        end
        j0 = j + 1
        if j0 < cols
          if engine[i0][j0].match?(/\d/)
            n = ''
            while j0 < cols
              if engine[i0][j0].match?(/\d/)
                n += engine[i0][j0]
              else
                break
              end
              j0 += 1
            end
            n3 = n
          end
        end
        if !n2.empty?
          numbers << (n1 + n2 + n3).to_i
        else
          if !n1.empty?
            numbers << n1.to_i 
          end
          if !n3.empty?
            numbers << n3.to_i
          end
        end
        j0 = j - 1
        if j0 > -1
          if engine[i][j0].match?(/\d/)
            n = ''
            while j0 > -1
              if engine[i][j0].match?(/\d/)
                n += engine[i][j0]
              else
                break
              end
              j0 -= 1
            end
            if !n.empty?
              numbers << n.reverse.to_i
            end
          end
        end
        j0 = j + 1
        if j0 < cols
          if engine[i][j0].match?(/\d/)
            n = ''
            while j0 < cols
              if engine[i][j0].match?(/\d/)
                n += engine[i][j0]
              else
                break
              end
              j0 += 1
            end
            if !n.empty?
              numbers << n.to_i
            end
          end
        end
        # p numbers
        if numbers.size == 2
          product = numbers.reduce(&:*)
          # p product
          total += product if !product.nil?
        end
      end
    end
  end
end

puts total
