Config = {}

Config.NPCS = {
    { -- Employee
        coords = vector4(-176.9, 623.21, 113.03, 62.99),
        model = 'S_M_M_StrLumberjack_01',
        weapon = false,
        outfit = false,
        scenario = 'PROP_HUMAN_REPAIR_WAGON_WHEEL_ON_LARGE',
        anim = { animDict = false, animName = '' },
        scale = false,
        startHour = 8, -- NPC appears at 8:00 AM
        endHour = 20   -- NPC disappears at 8:00 PM
    },
    { -- Guard
        coords = vector4(-266.84, 674.53, 112.31, 260.97),
        model = 'S_M_M_SkpGuard_01',
        weapon = 'WEAPON_RIFLE_BOLTACTION',
        outfit = 8,
        scenario = 'WORLD_HUMAN_GUARD_LANTERN_NERVOUS',
        anim = { animDict = false, animName = '' },
        scale = false,
        startHour = 18, -- NPC appears at 6:00 PM
        endHour = 6     -- NPC disappears at 6:00 AM
    }
}
