return {
    option = {
        type = "checkbox",
        alias = "StagedOmegaFix",
        label = "Axe Omega Channel Fix",
        default = true,
        tooltip =
        "Fixes Axe omega attack not benefiting correctly from channeling bonuses."
    },
    patches = {
        {
            key = "StagedOmegaFix",
            fn = function(plan)
                plan:set(WeaponData.WeaponAxeSpin, "MinWeaponChargeTime", 0.05)
            end
        },
    },
}
