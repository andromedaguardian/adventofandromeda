-- PART 1
invalid = {}

for line in io.lines(arg[1]) do
	for i, j in string.gmatch(line, "(%d+)-(%d+)") do
		for n = tonumber(i), tonumber(j), 1 do
			s = tostring(n)
			ls = string.sub(s, 1, string.len(s) // 2)
			rs = string.sub(s, (string.len(s) // 2) + 1, string.len(s))
			if ls == rs then
				table.insert(invalid, tonumber(n))
			end
		end
	end
end

sum = 0
for _, value in ipairs(invalid) do
	sum = sum + tonumber(value)
end

print(sum)

-- PART 2
invalid = {}

for line in io.lines(arg[1]) do
	for i, j in string.gmatch(line, "(%d+)-(%d+)") do
		for n = tonumber(i), tonumber(j), 1 do
			s = tostring(n)
			for k = 2, string.len(s), 1 do
				if string.len(s) % k == 0 and string.rep(string.sub(s, 1, string.len(s) // k), k) == s then
					table.insert(invalid, n)
					break
				end
			end
		end
	end
end

sum = 0
for _, value in ipairs(invalid) do
	sum = sum + tonumber(value)
end

print(sum)
