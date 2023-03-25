ATH = {}
ATH.Resource = GetCurrentResourceName()

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

ATH.FormatDate = function(string)
	return os.date('%d/%m/%Y 	%H:%M:%S', string)
end