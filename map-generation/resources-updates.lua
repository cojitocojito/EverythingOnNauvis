--------------------------------------------------------------------------------
-- Fixes map generation for resources
--------------------------------------------------------------------------------
local terrain = require("map-generation.terrain")

util =
{
  table = {}
}

function util.spritesheets_to_pictures(spritesheets)
  local pictures = {}
  for _, spritesheet in pairs(spritesheets) do
    for i = 1, spritesheet.frame_count or 1, 1 do
      table.insert(pictures, util.sprite_load(spritesheet.path,
        {
          frame_index = i - 1,
          scale = spritesheet.scale or 0.5,
          dice_y = spritesheet.dice_y
        })
      )
    end
  end
  return pictures
end

--------------------------------------------------------------------------------
-- MARK: Fix Nauvis resources
--------------------------------------------------------------------------------

-- Remove resources spawning on ammonia ocean
-- terrain.mask_off_ammonia_ocean("iron-ore", "resource")
-- terrain.mask_off_ammonia_ocean("copper-ore", "resource")
-- terrain.mask_off_ammonia_ocean("stone", "resource")
-- terrain.mask_off_ammonia_ocean("coal", "resource")
-- terrain.mask_off_ammonia_ocean("uranium-ore", "resource")
-- terrain.mask_off_ammonia_ocean("crude-oil", "resource")

terrain.mask_nauvis_territory("crude-oil", "resource")
terrain.mask_nauvis_territory("iron-ore", "resource")
terrain.mask_nauvis_territory("copper-ore", "resource")
terrain.mask_nauvis_territory("coal", "resource")
terrain.mask_nauvis_territory("uranium-ore", "resource")
terrain.mask_nauvis_territory("scrap", "resource")
terrain.mask_off_aquilo_territory("stone", "resource")
terrain.mask_off_vulcano_terrain("stone", "resource")
-- Mask resources from ammonia ocean
-- terrain.mask_off_aquilo_territory("calcite", "resource")
-- terrain.mask_off_gleba_territory("calcite", "resource")
-- terrain.mask_off_aquilo_territory("tungsten-ore", "resource")
-- terrain.mask_off_gleba_territory("tungsten-ore", "resource")
-- terrain.mask_vulcano_coverage("calcite", "resource")
-- terrain.mask_vulcano_coverage("tungsten-ore", "resource")

--------------------------------------------------------------------------------
-- MARK: Remove Aquilo resources to from Aquilo -- Dunno why i have to do this only for this planet...
--------------------------------------------------------------------------------

data.raw["noise-expression"]["aquilo_crude_oil_spots"].expression = "0"  --  This removes aquilo islands for crude oil
data.raw.planet["aquilo"].map_gen_settings.autoplace_controls = {nil}

--------------------------------------------------------------------------------
-- MARK: Add Fulgora resources to Nauvis
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- MARK: Gleba
--------------------------------------------------------------------------------

data.raw["autoplace-control"]["gleba_plants"].localised_description = {"autoplace-control-names.gleba_plants_description"}

--------------------------------------------------------------------------------
-- MARK: Add Vulcanus resources to Nauvis
--------------------------------------------------------------------------------

-- property_expression_names
data.raw.planet["nauvis"].map_gen_settings.property_expression_names["entity:sulfuric-acid-geyser:probability"] = "vulcanus_sulfuric_acid_geyser_probability"
data.raw.planet["nauvis"].map_gen_settings.property_expression_names["entity:sulfuric-acid-geyser:richness"] = "vulcanus_sulfuric_acid_geyser_richness"

-- Set vulcane as resource
data.raw["autoplace-control"]["vulcanus_volcanism"].order = "z-volcanism"
data.raw["autoplace-control"]["vulcanus_volcanism"].localised_description = {"autoplace-control-names.vulcanus_volcanism_description"}
data.raw["autoplace-control"]["vulcanus_volcanism"].category = "resource"

-- reorder autoplace controls
data.raw["autoplace-control"]["sulfuric_acid_geyser"].order = "b-z"

-- Add resources to nauvis
data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["calcite"] = {}
data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["sulfuric-acid-geyser"] = {}
data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["tungsten-ore"] = {}
data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["scrap"] = {}

-- autoplace_controls
data.raw.planet["nauvis"].map_gen_settings.autoplace_controls["sulfuric_acid_geyser"] = {}

-- START: Fix Resource spawning
data.raw.resource["calcite"].autoplace.has_starting_area_placement = false -- Does nothing but noise expression vulcanus_starting_calcite removes starter spot
data.raw.resource["sulfuric-acid-geyser"].autoplace.has_starting_area_placement = false -- Does nothing but noise expression vulcanus_starting_sulfur removes starter spot
data.raw.resource["tungsten-ore"].autoplace.has_starting_area_placement = false -- Does nothing but noise expression vulcanus_starting_tungsten removes starter spot

data.raw["noise-expression"]["vulcanus_starting_calcite"].expression = "-inf"
data.raw["noise-expression"]["vulcanus_starting_sulfur"].expression = "-inf"
data.raw["noise-expression"]["vulcanus_starting_tungsten"].expression = "-inf"

data.raw["noise-expression"]["vulcanus_starting_calcite"].expression = "-inf"
data.raw["noise-expression"]["vulcanus_starting_sulfur"].expression = "-inf"
data.raw["noise-expression"]["vulcanus_starting_tungsten"].expression = "-inf"

local NE = data.raw["noise-expression"]
NE['vulcanus_calcite_region'].expression = "mask_updated_volcanic_folds_flat(\z
                                            spot_noise{x = x,\z
                                                       y = abs_y,\z
                                                       seed0 = map_seed,\z
                                                       seed1 = 749,\z
                                                       candidate_spot_count = 3,\z
                                                       suggested_minimum_candidate_point_spacing = 0,\z
                                                       skip_span = 1,\z
                                                       skip_offset = 0,\z
                                                       region_size = 600,\z
                                                       density_expression = 80,\z
                                                       spot_quantity_expression = 1000,\z
                                                       spot_radius_expression = 32,\z
                                                       hard_region_target_quantity = 0,\z
                                                       spot_favorability_expression = updated_volcanic_folds_flat,\z
                                                       basement_value = -1,\z
                                                       maximum_spot_basement_radius = 200})"
-- NE['vulcanus_calcite_region'].local_expressions = {radius = "vulcanus_calcite_size * min(1.2, vulcanus_ore_dist) * 25"}
data.raw["noise-expression"]["vulcanus_calcite_probability"].expression = "vulcanus_calcite_region * 1000"

NE['vulcanus_sulfuric_acid_region_patchy'].expression = "mask_updated_volcanic_folds_flat(\z
                                                         spot_noise{x = x,\z
                                                         y = abs_y,\z
                                                         seed0 = map_seed,\z
                                                         seed1 = 759,\z
                                                         candidate_spot_count = 1,\z
                                                         suggested_minimum_candidate_point_spacing = 0,\z
                                                         skip_span = 1,\z
                                                         skip_offset = 0,\z
                                                         region_size = 600,\z
                                                         density_expression = 80,\z
                                                         spot_quantity_expression = 1000,\z
                                                         spot_radius_expression = 32,\z
                                                         hard_region_target_quantity = 0,\z
                                                         spot_favorability_expression = updated_volcanic_folds_flat * 1000000,\z
                                                         basement_value = -1,\z
                                                         maximum_spot_basement_radius = 32})"
-- NE['vulcanus_sulfuric_acid_region_patchy'].local_expressions = {radius = "vulcanus_sulfuric_acid_geyser_size * min(1.2, vulcanus_ore_dist) * 25"}

NE['vulcanus_tungsten_ore_region'].expression = "mask_updated_volcanic_folds_flat(\z
                                                 spot_noise{x = x,\z
                                                            y = abs_y,\z
                                                            seed0 = map_seed,\z
                                                            seed1 = 789,\z
                                                            candidate_spot_count = 1,\z
                                                            suggested_minimum_candidate_point_spacing = 0,\z
                                                            skip_span = 1,\z
                                                            skip_offset = 0,\z
                                                            region_size = 600,\z
                                                            density_expression = 80,\z
                                                            spot_quantity_expression = 1000,\z
                                                            spot_radius_expression = 32,\z
                                                            hard_region_target_quantity = 0,\z
                                                            spot_favorability_expression = updated_volcanic_folds_flat,\z
                                                            basement_value = -1,\z
                                                            maximum_spot_basement_radius = 200})"
-- NE['vulcanus_tungsten_ore_region'].local_expressions = {radius = "vulcanus_tungsten_ore_size * min(1.2, vulcanus_ore_dist) * 25"}

-- END: Fix Resource spawning
