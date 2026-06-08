return {
    option = {
        type = "checkbox",
        alias = "SufferingFix",
        label = "Suffering Fix",
        default = true,
        tooltip =
        "Fixes Suffering on Sight not bypassing Wards vow when dealing damage."
    },
    hooks = {
        function(module)
            module.hooks.wrap("CheckSpawnCurseDamage", function(host, runtime, baseFunc, enemy, traitArgs)
                if not runtime.data.read("SufferingFix") or not host.isEnabled() then
                    return baseFunc(enemy, traitArgs)
                end

                if enemy.IsBoss or enemy.UseBossHealthBar or enemy.IgnoreCurseDamage or enemy.AlwaysTraitor then
                    return
                end
                local damageAmount = 0
                for _, data in ipairs(traitArgs.DamageArgs) do
                    if not data.Chance or RandomChance(data.Chance * GetTotalHeroTraitValue("LuckMultiplier", { IsMultiplier = true })) then
                        damageAmount = RandomInt(data.MinDamage, data.MaxDamage)
                        break
                    end
                end
                thread(DoCurseDamage, enemy, traitArgs, damageAmount, { IgnoreHitShields = true })
            end)
        end,
    },
}
