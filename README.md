# osg_npcs

# Description
With this script you will be able to add peds wherever you want, and set the times when the NPC spawns
        startHour = 8, -- NPC appears at 8:00 AM
        endHour = 20   -- NPC disappears at 8:00 PM

In order for the npc to be at ground level, the Z coordinates must be lowered according to the character's height: vector4(X, Y, Z - CHARACTER HEIGHT, H)

In the Config file you can change:
- Npc coordinates
- Npc model
- Choose the weapon that will be equipped or without a weapon (false)
- Outfit number or random (false)
- Choose the scenario that the npc will perform or disable the scenario (false)
- Choose animation or disable animation by putting false in animDict or animName
- set start time
- set end time

## Instructions to incorporate script
- Copy the script into a folder (to choose) from the 'resources' folder.
- Add 'ensure osg_npcs' in the 'resources.cfg' document.

this script was modifed and added time logics. 

orginal script owner "https://github.com/XakraD/xakra_npcs"