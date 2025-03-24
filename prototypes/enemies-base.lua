local titan_biter_scale = 2
local titan_biter_tint1 = {0.2, 0.25, 0.2, 1}
local titan_biter_tint2 = {0.82, 0.45, 0.1, 0.7}

local titan_biter = table.deepcopy(data.raw.unit['behemoth-biter'])
titan_biter.name = 'titan-biter'
titan_biter.max_health = 30000
titan_biter.attack_parameters.animation = biterattackanimation(titan_biter_scale, titan_biter_tint1, titan_biter_tint2)
titan_biter.run_animation = biterrunanimation(titan_biter_scale, titan_biter_tint1, titan_biter_tint2)
titan_biter.water_reflection = biter_water_reflection(titan_biter_scale)



local scale_spitter_titan = 1.2
local tint_1_spitter_titan = {0.3, 0.2, 0.06, 1}
local tint_2_spitter_titan = {0.7, 0.45, 0.12, 0.75}

local titan_spitter = table.deepcopy(data.raw.unit['behemoth-spitter'])
titan_spitter.name = 'titan-spitter'
titan_spitter.max_health = 30000
-- print(serpent.block(titan_spitter.attack_parameters))
titan_spitter.run_animation = spitterrunanimation(scale_spitter_titan, tint_1_spitter_titan, tint_2_spitter_titan)
titan_spitter.water_reflection = spitter_water_reflection(scale_spitter_titan)



data:extend{ titan_biter, titan_spitter, titan_stomper, titan_strafer }
