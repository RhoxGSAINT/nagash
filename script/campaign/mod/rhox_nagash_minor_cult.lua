--using same structure Chaos Robie has used to reduce the confusion.
require("wh3_campaign_minor_cults")


local function get_cult(key)
    for i = 1, #MINOR_CULT_LIST do
        if MINOR_CULT_LIST[i].key == key then
            return MINOR_CULT_LIST[i]
        end
    end
end


local mc_carnival_of_chaos = get_cult("mc_carnival_of_chaos")
if mc_carnival_of_chaos then 
    mc_carnival_of_chaos.valid_subcultures["mixer_nag_nagash"]=true
end

local mc_chaos_portal = get_cult("mc_chaos_portal")
if mc_chaos_portal then 
    mc_chaos_portal.valid_subcultures["mixer_nag_nagash"]=true
end

local mc_crimson_plague = get_cult("mc_crimson_plague")
if mc_crimson_plague then 
    mc_crimson_plague.valid_subcultures["mixer_nag_nagash"]=true
end

local mc_crimson_skull = get_cult("mc_crimson_skull")
if mc_crimson_skull then 
    mc_crimson_skull.valid_subcultures["mixer_nag_nagash"]=true
end

local mc_cult_of_pleasure = get_cult("mc_cult_of_pleasure")
if mc_cult_of_pleasure then 
    mc_cult_of_pleasure.valid_subcultures["mixer_nag_nagash"]=true
end

local mc_dark_gift = get_cult("mc_dark_gift")
if mc_dark_gift then 
    mc_dark_gift.valid_subcultures["mixer_nag_nagash"]=true
end

local mc_doomsphere = get_cult("mc_doomsphere")
if mc_doomsphere then 
    mc_doomsphere.valid_subcultures["mixer_nag_nagash"]=true
end

local mc_forge_of_hashut = get_cult("mc_forge_of_hashut")
if mc_forge_of_hashut then 
    mc_forge_of_hashut.valid_subcultures["mixer_nag_nagash"]=true
end

--mc_elven_enclave VC doesn't have access to it

local mc_ogre_mercs = get_cult("mc_ogre_mercs")
if mc_ogre_mercs then 
    mc_ogre_mercs.valid_subcultures["mixer_nag_nagash"]=true
end

local mc_purple_hand = get_cult("mc_purple_hand")
if mc_purple_hand then 
    mc_purple_hand.valid_subcultures["mixer_nag_nagash"]=true
end

--mc_sartosan_vault TK doesn't have access to it

local mc_the_cabal = get_cult("mc_the_cabal")
if mc_the_cabal then 
    mc_the_cabal.valid_subcultures["mixer_nag_nagash"]=true
end

local mc_underworld_sea = get_cult("mc_underworld_sea")
if mc_underworld_sea then 
    mc_underworld_sea.valid_subcultures["mixer_nag_nagash"]=true
end

local mc_warpstone_meteor = get_cult("mc_warpstone_meteor")
if mc_warpstone_meteor then 
    mc_warpstone_meteor.valid_subcultures["mixer_nag_nagash"]=true
end




