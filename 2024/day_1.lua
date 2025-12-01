function stage1(list)
	local sumDistances = 0
	table.sort(list.left)
	table.sort(list.right)
	for i = 1, #list.left do
		local distance = math.abs(list.left[i] - list.right[i])
		sumDistances = sumDistances + distance
	end
	return sumDistances
end

function stage2(list)
	local visited = {}
	local sumSimilarity = 0
	for i = 1, #list.left do
		local count = visited[list.left[i]] or 0
		if count == 0 then
			for j = 1, #list.right do
				if list.left[i] == list.right[j] then
					count = count + 1
				end
			end
			visited[list.left[i]] = count
		end
		sumSimilarity = sumSimilarity + (list.left[i] * count)
	end
	return sumSimilarity
end

local list = {}
list.left = {}
list.right = {}
for line in io.lines(arg[1]) do
	for left, right in string.gmatch(line, "(%d*)%s*(%d*)") do
		table.insert(list.left, tonumber(left))
		table.insert(list.right, tonumber(right))
	end
end

print("stage1")
print(stage1(list))
print("stage2")
print(stage2(list))
