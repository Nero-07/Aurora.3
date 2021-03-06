var/list/flooring_types

/proc/get_flooring_data(var/flooring_path)
	if(!flooring_types)
		flooring_types = list()
	if(!flooring_types["[flooring_path]"])
		flooring_types["[flooring_path]"] = new flooring_path
	return flooring_types["[flooring_path]"]

// State values:
// [icon_base]: initial base icon_state without edges or corners.
// if has_base_range is set, append 0-has_base_range ie.
//   [icon_base][has_base_range]
// [icon_base]_broken: damaged overlay.
// if has_damage_range is set, append 0-damage_range for state ie.
//   [icon_base]_broken[has_damage_range]
// [icon_base]_edges: directional overlays for edges.
// [icon_base]_corners: directional overlays for non-edge corners.

/decl/flooring
	var/name
	var/desc
	var/icon
	var/icon_base

	var/has_base_range
	var/has_damage_range
	var/has_burn_range
	var/damage_temperature
	var/apply_thermal_conductivity
	var/apply_heat_capacity

	var/build_type      // Unbuildable if not set. Must be /obj/item/stack.
	var/build_cost = 1  // Stack units.
	var/build_time = 0  // BYOND ticks.

	var/descriptor = "tiles"
	var/flags
	var/can_paint

/decl/flooring/grass
	name = "grass"
	desc = "Do they smoke grass out in space, Bowie? Or do they smoke AstroTurf?"
	icon = 'icons/turf/flooring/grass.dmi'
	icon_base = "grass"
	has_base_range = 3
	damage_temperature = T0C+80
	flags = TURF_HAS_EDGES | TURF_REMOVE_SHOVEL
	build_type = /obj/item/stack/tile/grass

/decl/flooring/asteroid
	name = "coarse sand"
	desc = "Gritty and unpleasant."
	icon = 'icons/turf/flooring/asteroid.dmi'
	icon_base = "asteroid"
	flags = TURF_HAS_EDGES | TURF_REMOVE_SHOVEL
	build_type = null

/decl/flooring/carpet
	name = "carpet"
	desc = "Imported and comfy."
	icon = 'icons/turf/flooring/carpet.dmi'
	icon_base = "carpet"
	build_type = /obj/item/stack/tile/carpet
	damage_temperature = T0C+200
	flags = TURF_HAS_EDGES | TURF_HAS_CORNERS | TURF_REMOVE_CROWBAR | TURF_CAN_BURN

/decl/flooring/carpet/blue
	name = "carpet"
	icon_base = "bcarpet"
	build_type = null
	flags = TURF_HAS_EDGES

/decl/flooring/tiling
	name = "floor"
	desc = "Scuffed from the passage of countless greyshirts."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "steel"
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
	build_type = /obj/item/stack/tile/floor
	can_paint = 1

/decl/flooring/linoleum
	name = "linoleum"
	desc = "It's like the 2390's all over again."
	icon = 'icons/turf/flooring/linoleum.dmi'
	icon_base = "lino"
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK
	can_paint = 1

/decl/flooring/tiling/red
	name = "floor"
	icon_base = "white"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor_red

/decl/flooring/tiling/steel
	name = "floor"
	icon_base = "steel"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor_steel

/decl/flooring/tiling/white
	name = "floor"
	desc = "How sterile."
	icon_base = "white"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor_white

/decl/flooring/tiling/yellow
	name = "floor"
	icon_base = "white"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor_yellow

/decl/flooring/tiling/dark
	name = "floor"
	desc = "How ominous."
	icon_base = "dark"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor_dark

/decl/flooring/tiling/freezer
	name = "floor"
	desc = "Don't slip."
	icon_base = "freezer"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor_freezer

/decl/flooring/wood
	name = "wooden floor"
	desc = "Polished redwood planks."
	icon = 'icons/turf/flooring/wood.dmi'
	icon_base = "wood"
	has_damage_range = 6
	damage_temperature = T0C+200
	descriptor = "planks"
	build_type = /obj/item/stack/tile/wood
	flags = TURF_CAN_BREAK | TURF_IS_FRAGILE | TURF_REMOVE_SCREWDRIVER | TURF_CAN_BURN

/decl/flooring/reinforced
	name = "reinforced floor"
	desc = "Heavily reinforced with steel rods."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "reinforced"
	flags = TURF_REMOVE_WRENCH | TURF_ACID_IMMUNE
	build_type = /obj/item/stack/rods
	build_cost = 2
	build_time = 30
	apply_thermal_conductivity = 0.025
	apply_heat_capacity = 325000
	can_paint = 1

/decl/flooring/reinforced/circuit
	name = "processing strata"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_base = "bcircuit"
	build_type = null
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK | TURF_REMOVE_CROWBAR
	can_paint = 1

/decl/flooring/reinforced/circuit/green
	name = "processing strata"
	icon_base = "gcircuit"

/decl/flooring/reinforced/circuit/red
	icon_base = "rcircuit"
	flags = TURF_ACID_IMMUNE
	can_paint = 0

/decl/flooring/reinforced/cult
	name = "engraved floor"
	desc = "Unsettling whispers waver from the surface..."
	icon = 'icons/turf/flooring/cult.dmi'
	icon_base = "cult"
	build_type = null
	has_damage_range = 6
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK
	can_paint = null

/decl/flooring/reinforced/ramp
	name = "foot ramp"
	desc = "An archaic means of locomotion along the Z axis."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "ramptop"
	build_type = null
	has_damage_range = 1
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK
	can_paint = 1

/decl/flooring/reinforced/ramp/bottom
	icon_base = "rampbot"

/decl/flooring/diona
	name = "biomass"
	desc = "A mass of small intertwined aliens forming a floor... Creepy."
	icon = 'icons/turf/floors.dmi'
	icon_base = "diona"
	flags = TURF_ACID_IMMUNE | TURF_REMOVE_SHOVEL

//material turfs

/decl/flooring/silver
	name = "silver floor"
	desc = "A fancy floor with silver plating."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "silver"
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK
	build_type = /obj/item/stack/tile/silver

/decl/flooring/gold
	name = "golden floor"
	desc = "A fancy floor with golden plating."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "gold"
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK
	build_type = /obj/item/stack/tile/gold

/decl/flooring/uranium
	name = "uranium floor"
	desc = "An unsafe floor with uranium plating."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "uranium"
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK
	build_type = /obj/item/stack/tile/uranium

/decl/flooring/phoron
	name = "phoron floor"
	desc = "A flammable floor with phoron plating."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "plasma"
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK
	build_type = /obj/item/stack/tile/phoron

/decl/flooring/diamond
	name = "diamond floor"
	desc = "An expensive floor with diamond plating."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "diamond"
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK
	build_type = /obj/item/stack/tile/diamond

//Shuttle turfs

/decl/flooring/shuttle
	name = "shuttle floor"
	desc = "Typical shuttle flooring."
	icon = 'icons/turf/shuttle.dmi'
	icon_base = "floor"
	flags = TURF_ACID_IMMUNE
	apply_thermal_conductivity = 0.025
	apply_heat_capacity = 325000
	can_paint = 1

/decl/flooring/shuttle/yellow
	icon_base = "floor2"

/decl/flooring/shuttle/white
	icon_base = "floor3"

/decl/flooring/shuttle/red
	icon_base = "floor4"

/decl/flooring/shuttle/dark_red
	icon_base = "floor6"

/decl/flooring/shuttle/black
	icon_base = "floor7"

/decl/flooring/shuttle/tan
	icon_base = "floor8"

/decl/flooring/shuttle/dark_blue
	icon_base = "floor9"