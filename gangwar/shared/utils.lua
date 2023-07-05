ATH = {}
ATH.Resource = GetCurrentResourceName()

ATH.GetLevel = function(xp)
    for i=1, table.length(Levels.List) do
        local needed = Levels.List[i]
        if xp >= needed and (Levels.List[i+1] ~= nil and (Levels.List[i+1] > xp)) then
            return i, Levels.List[i+1]-needed, xp-needed
        end
    end
    return 0, Levels.List[1], xp
end
exports('CalcLevel', ATH.GetLevel)

toPlus = function(int)
	local str = tostring(int)
	return tonumber(str:sub(2))
end

isLongSleeve = function(draw)
	for _, i in pairs({
		96, 107, 108, 111, 117, 134, 141, 154, 171,
		172, 182, 257, 273, 305, 308, 332,
	}) do
		if i == draw then
			return true
		end
	end
    return false
end

_U = function(str)
	return (str):gsub("^%l", string.upper)
end

table.merge = function(t1, t2)
	local t = t1
	for i, v in pairs(t2) do
		table.insert(t, v)
	end
	return t
end

table.match = function(v, t)
    for k, v2 in pairs(t) do
        if v2 == v then
            return true
        end
    end
    return false
end

table.length = function(t)
	local c = 0
	for _, i in pairs(t) do
		c = c + 1
	end
	return c
end

math.trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	end
	return nil
end

math.gennum = function(min, max)
	return math.random(min, max)
end

math.round = function(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

table.dump = function(t, nb)
	if nb == nil then
		nb = 0
	end

	if type(t) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '{\n'
		for k,v in pairs(t) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '['..k..'] = ' .. table.dump(v, nb + 1) .. ',\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. '}'
	else
		return tostring(t)
	end
end

ATH.FormatDate = function(string)
	return os.date('%d/%m/%Y 	%H:%M:%S', string)
end