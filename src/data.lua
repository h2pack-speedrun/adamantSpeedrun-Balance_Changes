local PACK_ID = "speedrun"

local data = {}

function data.buildStorage(options)
    local storage = {}
    for _, option in ipairs(options) do
        if option.type == "checkbox" then
            table.insert(storage, {
                type = "bool",
                alias = option.alias,
                default = option.default == true,
            })
        else
            error(("Unsupported option type '%s' in %s"):format(tostring(option.type), PACK_ID .. ".Balance_Changes"))
        end
    end
    return storage
end

return data
