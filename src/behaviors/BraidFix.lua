return {
    option = {
        type = "checkbox",
        alias = "BraidFix",
        label = "Braid Fix",
        default = true,
        tooltip =
        "Fixes Braid of Atlas to properly buff casts."
    },
    patches = {
        {
            key = "BraidFix",
            fn = function(plan)
                if not TraitData.TemporaryImprovedCastTrait then return end
                local mods = TraitData.TemporaryImprovedCastTrait.AddOutgoingDamageModifiers
                plan:set(mods, "ValidProjectiles", WeaponSets.CastProjectileNames)
                plan:set(mods, "WeaponOrProjectileRequirement", true)
            end
        },
    },
}
