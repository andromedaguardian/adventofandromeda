-- 0 to 99
-- circle
-- count each time it hits 0
--
dir = { ["L"] = -1, ["R"] = 1 }
range = 100
count = 0
rotation = 50
for line in io.lines(arg[1]) do
	for rl, value in string.gmatch(line, "(%w)(%d+)") do
		rotation = (rotation + tonumber(value) * dir[rl]) % range
		if rotation == 0 then
			count = count + 1
		end
	end
end

print(count)

count = 0
rotation = 50

for line in io.lines(arg[1]) do
	for rl, value in string.gmatch(line, "(%w)(%d+)") do
		value = tonumber(value) * dir[rl]
		if dir[rl] > 0 then
			i = value // range
			count = count + i
			mod = value % range
			if rotation + mod >= range then
				count = count + 1
			end
		else
			i = value // -range
			count = count + i
			mod = value % -range
			if rotation ~= 0 and (rotation + mod <= 0) then
				count = count + 1
			end
		end
		rotation = (rotation + value) % range
		-- print(rotation)
	end
end

print(count)
