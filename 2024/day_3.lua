function stage1(corrupted_memory)
	local sum_multiplications = 0
	for _, instructions in ipairs(corrupted_memory) do
		local pattern = "mul%((%d%d?%d?),(%d%d?%d?)%)"
		for a, b in string.gmatch(instructions, pattern) do
			local mul = tonumber(a) * tonumber(b)
			sum_multiplications = sum_multiplications + mul
		end
	end
	return sum_multiplications
end

function insertsort(t, value)
	local id = #t + 1
	for i, v in ipairs(t) do
		if value.id < v.id then
			id = i
			break
		end
	end
	table.insert(t, id, value)
end

function stage2(corrupted_memory)
	local sum_multiplications = 0
	local enable = true
	for _, instructions in ipairs(corrupted_memory) do
		local table_instructions = {}
		local patterns = {
			"mul%(%d%d?%d?,%d%d?%d?%)",
			"do%(%)",
			"don't%(%)",
		}
		for _, pattern in ipairs(patterns) do
			local i = 1
			repeat
				local matchid, endid = string.find(instructions, pattern, i)
				if matchid then
					local str = string.sub(instructions, matchid, endid)
					insertsort(table_instructions, { id = matchid, exec = str })
					i = endid + 1
				end
			until matchid == nil
		end
		for _, instruction in ipairs(table_instructions) do
			local match, _, a, b = string.find(instruction.exec, "mul%((%d%d?%d?),(%d%d?%d?)%)")
			if match then
				if enable then
					local mult = tonumber(a) * tonumber(b)
					sum_multiplications = sum_multiplications + mult
				end
			end
			if instruction.exec == "do()" then
				enable = true
			end
			if instruction.exec == "don't()" then
				enable = false
			end
		end
	end
	return sum_multiplications
end

local corrupted_memory = {}

for line in io.lines("input") do
	table.insert(corrupted_memory, line)
end

print("stage1")
print(stage1(corrupted_memory))
print("stage2")
print(stage2(corrupted_memory))
