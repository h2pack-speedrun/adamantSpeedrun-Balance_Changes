return {
    option = {
        type = "checkbox",
        alias = "ShimmeringFix",
        label = "Shimmering Moonshot Fix",
        default = true,
        tooltip =
        "Fixes Shimmering Moonshot not applying damage bonus to omega special."
    },
    patches = {
        {
            key = "ShimmeringFix",
            fn = function(plan)
                if not TraitData.StaffJumpSpecialTrait then return end
                local mods = TraitData.StaffJumpSpecialTrait.AddOutgoingDamageModifiers
                plan:set(mods, "ProjectileName", nil)
                plan:set(mods, "ValidProjectiles", { "ProjectileStaffBall", "ProjectileStaffBallCharged" })
                plan:transform(TraitData.StaffJumpSpecialTrait, "PropertyChanges", function(list)
                    local copy = rom.game.DeepCopyTable(list or {})
                    for _, propertyChange in ipairs(copy) do
                        propertyChange.ProjectileNames = { "ProjectileStaffBall", "ProjectileStaffBallCharged" }
                    end
                    return copy
                end)
            end
        },
    },
}
