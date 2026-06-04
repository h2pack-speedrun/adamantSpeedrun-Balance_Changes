local behaviors = {
    patches = {},
    hooks = {},
    options = {},
}

local function register(path)
    local behavior = import(path)
    if behavior.option then
        table.insert(behaviors.options, behavior.option)
    end
    for _, patch in ipairs(behavior.patches or {}) do
        table.insert(behaviors.patches, patch)
    end
    for _, hook in ipairs(behavior.hooks or {}) do
        table.insert(behaviors.hooks, hook)
    end
end

register("behaviors/BraidFix.lua")
register("behaviors/CardioTorchFix.lua")
register("behaviors/ETFix.lua")
register("behaviors/OmegaCastFix.lua")
register("behaviors/PoseidonWavesFix.lua")
register("behaviors/SecondStageChanneling.lua")
register("behaviors/ShimmeringFix.lua")
register("behaviors/ExtraDoseFix.lua")
register("behaviors/SeleneFix.lua")
register("behaviors/StagedOmegaFix.lua")
register("behaviors/TidalRingFix.lua")
register("behaviors/GGGFix.lua")
register("behaviors/SufferingFix.lua")

return behaviors
