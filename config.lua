Config = {}

Config.Desk = { 1846.41, 2585.91, 45.67 }
Config.ReleasePrison = { 1846.41, 2585.91, 45.67 }
Config.InPrison = { 1662.51, 2605.90, 45.56 }
Config.EscortOut = { 1852.60, 2586.12, 45.67 }

Config.TimeLeftX = 0.660
Config.TimeLeftY = 1.378

Config.defaultsecs = 60
Config.maxsecs = 300

Config.minBail = 1000
Config.maxBail = 2000
Config.overPayLimit = 150

Config.staffAcePerm = "jd.staff"

Config.PoliceStation = {
    {-448.22, 6012.47, 31.72, 15}, -- Paleto PD
    {1852.86, 3689.21, 34.27, 15}, -- Sandy Shores PD
    {382.54, 789.29, 187.67, 15}, -- Ranger Station
    {650.07, -10.54, 82.80, 15}, -- Vinewood Station
    {-557.35, -141.46, 38.43, 15}, -- Rockford Station
    {-1093.58, -808.72, 19.28, 15}, -- Vespucci Station
    {-1629.33, -1015.61, 13.13, 15}, -- DelPerro Station
    {463.95, -997.89, 24.91, 15}, -- Mission Row Station
    {825.17, -1290.18, 28.24, 15}, -- La Mesa Station
    {1831.04, 2607.99, 45.59, 15}, -- Prison Entrance
    --{STATION_X, STATION_Y, STATION_Z, STATION_RADIUS}, -- Template Station
}

Config.Zones = {
    {
        {1818.45, 2611.60, 45.67}, -- Prison Zone
        {1809.37, 2611.65, 45.67}, -- This will mark out the zone from point to point
        {1809.40, 2620.69, 45.67}, -- This is set up for the inner fence of the prison
        {1817.80, 2642.32, 45.67},
        {1834.40, 2688.87, 45.67},
        {1829.39, 2703.25, 45.67},
        {1776.49, 2746.40, 45.67},
        {1761.95, 2751.73, 45.67},
        {1662.50, 2748.09, 45.67},
        {1648.50, 2740.81, 45.67},
        {1585.35, 2679.40, 45.67},
        {1576.11, 2666.74, 45.67},
        {1548.48, 2591.62, 45.67},
        {1547.82, 2576.09, 45.67},
        {1551.37, 2483.35, 45.67},
        {1559.03, 2469.66, 45.67},
        {1652.85, 2410.46, 45.67},
        {1668.09, 2408.40, 45.67}, 
        {1748.59, 2420.63, 45.67},
        {1762.12, 2427.29, 45.67},
        {1808.14, 2474.48, 45.67},
        {1812.84, 2488.88, 45.67},
        {1805.69, 2535.65, 45.67},
        {1807.59, 2568.37, 45.67},
        {1808.22, 2592.08, 45.67},
        {1818.65, 2592.08, 45.67}
    }
}

-- for the /unjail command you need the Ace Permission jd.staff
-- add_ace group.admin jd.staff allow