function count_words(t, word)
	local str = table.concat(t)
	local count = 0
	for _ in string.gmatch(str, word) do
		count = count + 1
	end
	for _ in string.gmatch(str, string.reverse(word)) do
		count = count + 1
	end
	return count
end

function stage1(words)
	local search_word = "XMAS"
	local xmas_count = 0
	-- horizontal
	for _, row in ipairs(words) do
		xmas_count = xmas_count + count_words(row, search_word)
	end
	-- vertical
	for i = 1, #words[1] do
		local t = {}
		for j = 1, #words do
			table.insert(t, words[j][i])
		end
		xmas_count = xmas_count + count_words(t, search_word)
	end
	-- first diagonal
	for i = 1, #words do
		y = i
		x = 1
		local t = {}
		while x <= #words[1] and y <= #words do
			table.insert(t, words[y][x])
			y = y + 1
			x = x + 1
		end
		xmas_count = xmas_count + count_words(t, search_word)
	end

	for i = 2, #words[1] do
		y = 1
		x = i
		local t = {}
		while x <= #words[1] and y <= #words do
			table.insert(t, words[y][x])
			y = y + 1
			x = x + 1
		end
		xmas_count = xmas_count + count_words(t, search_word)
	end
	-- second diagonal
	for i = 1, #words do
		y = i
		x = 1
		local t = {}
		while x <= #words[1] and y > 0 do
			table.insert(t, words[y][x])
			y = y - 1
			x = x + 1
		end
		xmas_count = xmas_count + count_words(t, search_word)
	end

	for i = 2, #words[1] do
		y = #words
		x = i
		local t = {}
		while x <= #words[1] and y > 0 do
			table.insert(t, words[y][x])
			y = y - 1
			x = x + 1
		end
		xmas_count = xmas_count + count_words(t, search_word)
	end
	return xmas_count
end

function stage2(words)
	local search_word = "MAS"
	local xmas_count = 0

	for i = 2, #words - 1 do
		for j = 2, #words[1] - 1 do
			local d1 = {
				words[i - 1][j - 1],
				words[i][j],
				words[i + 1][j + 1],
			}

			local d2 = {
				words[i + 1][j - 1],
				words[i][j],
				words[i - 1][j + 1],
			}

			local count = count_words(d1, search_word) + count_words(d2, search_word)
			if count == 2 then
				xmas_count = xmas_count + 1
			end
		end
	end
	return xmas_count
end

local words = {}
local i = 0
for line in io.lines("input") do
	i = i + 1
	words[i] = {}
	for j = 1, #line do
		words[i][j] = string.sub(line, j, j)
	end
end

print("stage1")
print(stage1(words))
print("stage2")
print(stage2(words))
