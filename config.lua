Config = {}

Config.FarmJobs = {
    barrel = {
        label = "hello barrel",
        prop = "prop_barrel_01a", -- ชื่อพรอพ
        reward = "barrel", -- ไอเทมที่จะได้รับ
        maxTimes = 25, -- เก็บได้กี่ครั้งต่อจุด
        timePerCollect = 2000, -- ระยะเวลาในการเก็บแต่ละครั้ง (มิลลิวินาที)
        locations = {
           vector3(2200.0, 4900.0, 45.0),
            vector3(2202.0, 4902.0, 45.0),
            vector3(2204.0, 4901.0, 45.0),
            vector3(2206.0, 4903.0, 45.0),
            vector3(2206.0, 4909.0, 45.0)
        }
    }
}
