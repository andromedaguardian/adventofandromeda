function is_safe_report(r)
	local safe = true
	local decreasing
	for i = 1, #r - 1 do
		local dt = math.abs(r[i + 1] - r[i])
		if dt < 1 or dt > 3 then
			safe = false
			break
		end
		if r[i] > r[i + 1] then
			if decreasing == nil then
				decreasing = true
			elseif decreasing == false then
				safe = false
				break
			end
		else
			if decreasing == nil then
				decreasing = false
			elseif decreasing == true then
				safe = false
				break
			end
		end
	end
	return safe
end

function stage1(reports)
	local count = 0
	for _, r in ipairs(reports) do
		if is_safe_report(r) then
			count = count + 1
		end
	end
	return count
end

function stage2(reports)
	local count = 0
	for _, r in ipairs(reports) do
		local safe = is_safe_report(r)
		if safe then
			count = count + 1
		else
			for id, _ in ipairs(r) do
				local fix_report = table.move(r, 1, id - 1, 1, {})
				table.move(r, id + 1, #r, id, fix_report)
				safe = is_safe_report(fix_report)
				if safe then
					count = count + 1
					break
				end
			end
		end
	end
	return count
end

local reports = {}
local i = 1
for line in io.lines("input") do
	reports[i] = {}
	for data in string.gmatch(line, "(%d+)") do
		table.insert(reports[i], tonumber(data))
	end
	i = i + 1
end

print("stage1")
print(stage1(reports))
print("stage2")
print(stage2(reports))
