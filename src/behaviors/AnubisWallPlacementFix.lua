return {
    option = {
        type = "checkbox",
        alias = "ETFix",
        label = "Anubis Wall Placement Fix",
        default = true,
        tooltip =
        "Fixes Mirrored Ankh omega attack wall placement based on casting angle."
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

                local count = 1
                if HeroHasTrait("DoubleExManaBoon") then
                    count = 2
                end

                for _ = 1, count do
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
                end
            end)
        end,
    },
}
