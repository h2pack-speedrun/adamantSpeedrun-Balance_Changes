return {
    option = {
        type = "checkbox",
        alias = "PoseidonWavesFix",
        label = "Poseidon Waves Fix",
        default = true,
        tooltip =
        "Fixes Poseidon waves on Axe special and Hidden Helix Torch."
    },
    patches = {
        {
            key = "PoseidonWavesFix",
            fn = function(plan)
                if not TraitData.PoseidonSpecialBoon then return end
                local args = TraitData.PoseidonSpecialBoon.OnEnemyDamagedAction.Args
                plan:appendUnique(args, "MultihitProjectileWhitelist", "ProjectileAxeSpecial")
                plan:set(args.MultihitProjectileConditions, "ProjectileAxeSpecial", { Count = 4, Window = 0.3 })
                plan:transform(args.MultihitProjectileConditions, "ProjectileTorchOrbit", function(value)
                    local copy = rom.game.DeepCopyTable(value or {})
                    copy.Count = 4
                    return copy
                end)
            end
        },
    },
}
