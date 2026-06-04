local module = {}

local function buildCheckboxOptions(options)
    local optsByAlias = {}
    for _, option in ipairs(options) do
        if option.type == "checkbox" then
            optsByAlias[option.alias] = {
                label = option.label,
                tooltip = option.tooltip,
            }
        end
    end
    return optsByAlias
end

local function drawOptions(draw, state, options, checkboxOptsByAlias)
    for _, option in ipairs(options) do
        if option.type == "checkbox" then
            draw.widgets.checkbox(state.get(option.alias), checkboxOptsByAlias[option.alias])
        end
    end
end

function module.drawTab(draw, state, options, checkboxOptsByAlias)
    drawOptions(draw, state, options, checkboxOptsByAlias)
end

function module.attach(libModule, options)
    local checkboxOptsByAlias = buildCheckboxOptions(options)
    libModule.ui.tab(function(_, ui)
        return module.drawTab(ui.draw, ui.data, options, checkboxOptsByAlias)
    end)
end

return module
