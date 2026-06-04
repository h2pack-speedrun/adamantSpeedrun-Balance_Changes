return {
    option = {
        type = "checkbox",
        alias = "GGGFix",
        label = "GGG Echo Fix",
        default = true,
        tooltip =
        "Allows GGG to be offered in Jpom runs."
    },
    patches = {
        {
            key = "GGGFix",
            fn = function(plan)
                if not TraitData.EchoRepeatKeepsakeBoon then return end
                plan:transform(TraitData, "EchoRepeatKeepsakeBoon", function(trait)
                    if trait == nil then return trait end
                    local copy = rom.game.DeepCopyTable(trait)
                    copy.GameStateRequirements[2].HasNone = { "AthenaEncounterKeepsake", "FountainRarityKeepsake" }
                    table.insert(copy.GameStateRequirements, {
                        Path = { "CurrentRun", "Hero", "SlottedTraits", "Keepsake" },
                        IsNone = { "HadesAndPersephoneKeepsake", "EscalatingKeepsake" }
                    })
                    return copy
                end)
            end
        },
    },
}
