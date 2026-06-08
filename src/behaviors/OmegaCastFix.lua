return {
    option = {
        type = "checkbox",
        alias = "OmegaCastFix",
        label = "Omega Cast Fix",
        default = true,
        tooltip =
        "Adds missing omega-cast projectiles to the cast-damage projectile set."
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
