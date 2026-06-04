return {
    option = {
        type = "checkbox",
        alias = "ETFix",
        label = "ET Fix",
        default = true,
        tooltip =
        "Fixes ET working with Anubis by creating a 3rd OAtk field. Fixes Anubis OAtk distance based on casting angle."
    },
    patches = {
        {
            key = "ETFix",
            fn = function(plan)
                if not TraitData.DoubleExManaBoon then return end
                plan:appendUnique(
                    TraitData.DoubleExManaBoon.PropertyChanges[1],
                    "FalseTraitNames",
                    "StaffRaiseDeadAspect"
                )
                plan:set(TraitData.DoubleExManaBoon, "OnWeaponFiredFunctions", {
                    ValidWeapons = { "WeaponStaffSwing5" },
                    FunctionName = "CreateSecondAnubisWall",
                    FunctionArgs = { Distance = 340 },
                    ExcludeLinked = true,
                })
            end
        },
    },
    hooks = {
        function(module)
            module.hooks.wrap("CreateSecondAnubisWall", function(host, runtime, baseFunc, weaponData, args, triggerArgs)
                if not runtime.data.read("ETFix") or not host.isEnabled() then
                    return baseFunc(weaponData, args, triggerArgs)
                end

                local weaponName = "WeaponStaffSwing5"
                local projectileName = "ProjectileStaffWall"
                local derivedValues = GetDerivedPropertyChangeValues({
                    ProjectileName = projectileName,
                    WeaponName = weaponName,
                    Type = "Projectile",
                })

                local angle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
                local radAngle = math.rad(angle)

                local baseDistance = 520
                local gapDistance = args.Distance - 520
                local isoRatio = 0.7

                local baseX = math.cos(radAngle) * baseDistance
                local baseY = -math.sin(radAngle) * baseDistance * isoRatio

                local gapX = math.cos(radAngle) * gapDistance
                local gapY = -math.sin(radAngle) * gapDistance

                CreateProjectileFromUnit({
                    WeaponName = weaponName,
                    Name = projectileName,
                    OffsetX = baseX + gapX,
                    OffsetY = baseY + gapY,
                    Angle = angle,
                    Id = CurrentRun.Hero.ObjectId,
                    DestinationId = MapState.FamiliarLocationId,
                    FireFromTarget = true,
                    DataProperties = derivedValues.PropertyChanges,
                    ThingProperties = derivedValues.ThingPropertyChanges,
                    ExcludeFromCap = true,
                })
            end)
        end,
    },
}
