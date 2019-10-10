local M = {}

function M.new(t)
    return setmetatable(t or {}, {
        __index = M,
        __tostring = function(t) return M.tostring(t) end
    })
end

local function is_from_module(t, new_t)
    local mt = getmetatable(t)
    if(mt and mt.__index == M and new_t) then
        return M.new(new_t)
    end
    return new_t or t
end

function M.for_each(t, fn)
    for k, v in pairs(t) do
        fn(v, k , t)
    end
end

function M.for_each_reverse(t, fn)
    local length = #t
    for i = length, 1, -1 do
        fn(v, k , t)
    end
end

function M.map(t, fn)
    local new_t = {}
    for k, v in pairs(t) do
        new_t[k] = fn(v, k, t)
    end
    return is_from_module(t, new_t)
end

function M.filter(t, fn)
    local new_t = {}
    for k, v in pairs(t) do
        if(fn(v, k, t)) then table.insert(new_t, v) end
    end
    return is_from_module(t, new_t)
end

function M.find(t, fn)
    local found, index = nil, -1
    for k, v in pairs(t) do
        if(fn(v, k, t)) then found = v;index = k break end
    end
    return found, index
end

function M.find_index(t, fn)
    local _, index = M.find(t, fn)
    return index
end

function M.index_of(t, value)
    local _, index = M.find(t, function(v) return v == value end)
    return index
end

function M.reduce(t, fn, accumulator)
    M.for_each(t, function(v, k, a)
        accumulator = fn(accumulator, v, k, a)
    end)
    return accumulator
end

function M.reduce_reverse(t, fn, accumulator)
    M.for_each_reverse(t, function(v, k, a)
        accumulator = fn(accumulator, v, k, a)
    end)
    return accumulator
end

function M.push(t, value)
    table.insert(t, value)
    return #t
end

function M.pop(t)
    return table.remove(t, #t)
end

function M.unshift(t, value)
    table.insert(t, 1, value)
    return #t
end

function M.shift(t)
    return table.remove(t, 1)
end

function M.reverse(t)
    local new_t = {}
    local legnth = M.length(t)
    for i=length, 1, -1 do
        M.push(new_t, t[i])
    end
    return is_from_module(t, new_t)
end

function M.flat(t, depth, new_t, level)
    depth = depth or 1
    new_t = new_t or {}
    level = level or 0
    M.for_each(t, function(v, k)
        if (type(v) == "table" and depth > level) then
            M.flat(v, depth, new_t, level + 1)
        else
            M.push(new_t, v)
        end
    end)
    return is_from_module(t, new_t)
end

function M.flat_map(t, fn)
    local flat = M.flat(t, 1)
    return M.map(flat, fn)
end

function M.slice(t, start, endv)
    start = start or 1
    endv = endv or #t
    local new_t = {}
    for i = start, endv do
        M.push(new_t, t[i])
    end
    return is_from_module(t, new_t)
end

function M.sort(t, fn)
    table.sort(t, fn)
    return t
end

-- TODO
function M.splice(t, start, delete, ...)
    local length = #t
    if (start > length) then start = length + 1
    elseif (start < 0) then start = length + start end

    local items = ...
    if(#items < 1) then return t end
    local endv = start + delete
    local items_count = 1
    local t_before_start = M.slice(t, 1, start)
    for i = start, endv do

    end
end

function M.some(t, fn)
    if(M.find(t, fn)) then return true else return false end
end

function M.every(t, fn)
    local result = true
    for k, v in pairs(t) do
        if(not fn(v, k, t)) then result = false; break end
    end
    return result
end

function M.concat(t, ot)
    local new_t = {}
    M.for_each(t, function(v)
        M.push(new_t, v)
    end)
    M.for_each(ot, function(v)
        M.push(new_t, v)
    end)
    return is_from_module(t, new_t)
end

function M.fill(t, value, start, endv)
    start = start or 1
    endv = endv or #t
    for i = start, endv do
        t[i] = value
    end
    return is_from_module(t, t)
end

function M.includes(t, value)
    return M.some(t, function(v) return v == value end)
end

function M.join(t, separator)
    separator = separator or ""
    local result = ""
    M.for_each(t, function(v,k) result = result .. ((k > 1 and separator) or "") .. v end)
    return result
end

function M.keys(t, separator)
    return M.map(t, function(_, k) return k end)
end

function M.values(t, separator)
    return M.map(t, function(v) return v end)
end

function M.length(t)
    return #t
end

function pvalue(value)
    if(type(value) == "string") then return "\"" .. value .. "\""
    else return tostring(value) end
end

function M.tostring(t, level)
    level = level or 1
    local sep = " "
    local result = "{\n"
    M.for_each(t, function(v, k)
        if(type(v) == "table") then
            result = result .. (sep:rep(level)) .. "[" .. k .. "] = " .. M.tostring(v, level + 1) .. ",\n"
        else
            result = result .. (sep:rep(level)) .. "[" .. k .. "] = " .. pvalue(v) .. ",\n"
        end
    end)
    return result .. (sep:rep(level-1)) .. "}"
end

function M.print(t)
    print(M.tostring(t))
end

return setmetatable({},{
    __index = M,
    __call = function(cls, t)
        return M.new(t)
    end
})