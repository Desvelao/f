local M = {}

-- function M.new()
--     return setmetatable()
-- end

function M.starts_with(s, str)
    return s:sub(1, #str) == str
end

function M.ends_with(s, str)
    return s:sub(#s-#str+1, #s) == str
end

function M.split(text, patron)
    local split = {}
    for i in string.gmatch(text, patron) do
        table.insert(split, i)
    end
    return split
end

return M
-- return setmetatable({},{
--     __index = M,
--     __call = function(cls, s)
--         return M.new(s)
--     end
-- })
