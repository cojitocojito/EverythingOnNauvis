local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")

local function lerp_color(a, b, amount)
  return
  {
    a[1] + amount * (b[1] - a[1]),
    a[2] + amount * (b[2] - a[2]),
    a[3] + amount * (b[3] - a[3]),
    a[4] + amount * (b[4] - a[4]),
  }
end

local function fade(tint, amount) -- fades to minimal opacity grey. Low opacity is good for the mask to let the base layer show htough (instead of having a grey mask)
  return lerp_color(tint, {1, 1, 1, 2}, amount)
end

local function grey_overlay(tint, amount) -- fades to opaque grey. Full opacity is required for body.
  return lerp_color(tint, {127, 127, 127, 255}, amount)
end

local gleba_titan_mask_tint  = {216,0,35,255}
local gleba_titan_mask2_tint  = {216,100,35,255}
local gleba_titan_body_tint = {117,116,104,255}
local gleba_titan_scale = 2
make_strafer("titan-", gleba_titan_scale, 30000, 1.6, 5.5, 26, 31, 36,
  {
    mask = fade(gleba_titan_mask_tint, 0.4),
    mask_thigh = fade(gleba_titan_mask2_tint, 0.2),
    body = grey_overlay(gleba_titan_body_tint, 0.1),
    projectile_mask = big_wriggler_mask_tint, -- same as wriggler mask tint
    projectile = big_wriggler_body_tint  -- same as wriggler body tint
  }, simulations.factoriopedia_gleba_enemy_big_strafer, space_age_sounds.strafer_pentapod.big)
make_stomper("titan-", gleba_titan_scale, 30000, 1.6, 2.8,
  {
    mask = fade(gleba_titan_mask_tint, 0.4),
    mask_thigh = fade(gleba_titan_mask2_tint, 0.3),
    body = grey_overlay(gleba_titan_body_tint, 0.1),
    body_thigh = lerp_color(gleba_titan_body_tint, grey_overlay({250,108,0,255}, 0.7), 0.1) -- more orange/yellow
  }, simulations.factoriopedia_gleba_enemy_big_stomper, space_age_sounds.stomper_pentapod.big)
make_wriggler("titan-", gleba_titan_scale, 4000, 1.8,
  {
    mask = fade(gleba_titan_mask_tint, 0.5),
    body = gleba_titan_body_tint
  }, simulations.factoriopedia_gleba_enemy_big_wriggler, simulations.factoriopedia_gleba_enemy_big_wriggler_premature, space_age_sounds.wriggler_pentapod.big)

local k = 'titan'
-- data.raw["segmented-unit"][k.."-demolisher"].icon = "__space-age__/graphics/icons/big-demolisher.png"
-- data.raw["segmented-unit"][k.."-demolisher"].vision_distance = math.min(100, data.raw["segmented-unit"][k.."-demolisher"].vision_distance)
data.raw["spider-unit"][k.."-strafer-pentapod"].icon = "__space-age__/graphics/icons/big-strafer.png"
data.raw["spider-unit"][k.."-stomper-pentapod"].icon = "__space-age__/graphics/icons/big-stomper.png"
data.raw["simple-entity"][k.."-stomper-shell"].icon = "__space-age__/graphics/icons/big-stomper.png"
data.raw["unit"][k.."-wriggler-pentapod-premature"].icon = "__space-age__/graphics/icons/big-wriggler.png"
data.raw["unit"][k.."-wriggler-pentapod"].icon = "__space-age__/graphics/icons/big-wriggler.png"
data.raw["corpse"][k .. "-wriggler-pentapod-corpse"].icon = "__space-age__/graphics/icons/big-wriggler-corpse.png"
data.raw["corpse"][k .. "-stomper-corpse"].icon = "__space-age__/graphics/icons/big-stomper.png"
data.raw["corpse"][k .. "-strafer-corpse"].icon = "__space-age__/graphics/icons/big-strafer.png"
data.raw["spider-leg"][k .. "-stomper-pentapod-leg"].icon = "__space-age__/graphics/icons/big-stomper.png"
data.raw["spider-leg"][k .. "-strafer-pentapod-leg"].icon = "__space-age__/graphics/icons/big-strafer.png"
