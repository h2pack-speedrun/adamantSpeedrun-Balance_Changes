return {
    option = {
        type = "checkbox",
        alias = "OmegaCastFix",
        label = "Omega Cast Fix",
        default = true,
        tooltip =
        "Fixes OCast moves not counting as cast damage."
    },
    patches = {
        {
            key = "OmegaCastFix",
            fn = function(plan)
                local missingCastProjectiles = {
                    "ApolloCastRapid",
                    "AresProjectile",
                    "ZeusApolloSynergyStrike",
                    "DemeterCastStorm",
                    "AthenaCastProjectile",
                }
                for _, projectileName in ipairs(missingCastProjectiles) do
                    plan:appendUnique(WeaponSets, "CastProjectileNames", projectileName)
                end
            end
        },
    },
}
