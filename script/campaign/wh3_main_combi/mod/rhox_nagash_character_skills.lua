
local skill_to_anc ={
    nag_skill_unique_nagash_alakanash = "nag_anc_arcane_item_alakanash_staff_of_power",
    nag_skill_unique_nagash_book_two = "nag_anc_talisman_books_of_nagash_book_two",
    nag_skill_unique_nagash_book_three = "nag_anc_talisman_books_of_nagash_book_three",
    nag_skill_unique_nagash_book_eight = "nag_anc_talisman_books_of_nagash_book_eight"
} --husk and boss both have these skill, so to remove the duplicate ancillary
	






core:add_listener(
	"rhox_nagash_CharacterSkillPointAllocated",
	"CharacterSkillPointAllocated",
	function(context)
		local skill = context:skill_point_spent_on()
		local character = context:character()
		local faction = character:faction()
		return skill_to_anc[skill]
	end,
	function(context)
		local skill = context:skill_point_spent_on()
		local anc = skill_to_anc[skill]
		local character = context:character()
		local faction = character:faction()
		
		
		if faction:ancillary_exists(anc) ==false then
            cm:force_add_ancillary(
                context:character(),
                anc,
                true,
                false
            )
        end
	end,
	true
)

