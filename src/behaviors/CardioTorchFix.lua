return {
    option = {
        type = "checkbox",
        alias = "CardioTorchFix",
        label = "Cardio Torch Fix",
        default = true,
        tooltip =
        "Fixes Cardio Gain interactions with Torch specials."
    },
    patches = {
        {
            key = "CardioTorchFix",
            fn = function(plan)
                if not TraitData.HestiaManaBoon then return end
                local args = TraitData.HestiaManaBoon.OnEnemyDamagedAction.Args
                plan:appendUnique(args, "MultihitProjectileWhitelist", "ProjectileTorchOrbit")
                plan:set(args.MultihitProjectileConditions, "ProjectileTorchOrbit", { Cooldown = 0.01 })
            end
        },
    },
}
