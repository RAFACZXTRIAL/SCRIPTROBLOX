--[[ 
    ================================================
    MOUNT TARANJANG, JAPANESE & SIBUATAN AUTO SUMMIT
    LOGIKA: Teleport -> Reset -> Delay (Patokan user).
    Urutan: Teleport ke Summit -> 2 Detik Jeda -> Reset Karakter -> Wait Respawn -> Delay.
    ================================================
]]

-- UBAH INI SESUAI KEINGINANMU
local Author = "v2.3 Summit with Sibuatan - FINAL"

-- CFRAME SUMMIT
local TARANJANG_CFRAME = CFrame.new(8711.95215, 1637.02124, 1343.46667, 0.375418901, -4.74302198e-09, 0.926855266, 1.80503723e-10, 1, 5.04421527e-09, -0.926855266, -1.72639292e-09, 0.375418901)
local JAPANESE_CFRAME = CFrame.new(-18.1628742, 1019.05713, 7.24377155, -0.809797227, -9.46244825e-08, 0.586709857, -4.64653951e-08, 1, 9.71467173e-08, -0.586709857, 5.14074365e-08, -0.809797227)
local SIBUATAN_CFRAME = CFrame.new(5392.64893, 8109.02441, 2202.86572, 0.0890931934, 6.88869548e-08, -0.996023297, -8.87670311e-08, 1, 6.12218756e-08, 0.996023297, 8.29595805e-08, 0.0890931934) -- CFRAME BARU
-- ================================================

-- 1. MEMUAT LIBRARY STELLAR
local StellarLibrary = (loadstring(Game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/NewUiStellar.lua")))();

if StellarLibrary:LoadAnimation() then
	StellarLibrary:StartLoad();
end;
if StellarLibrary:LoadAnimation() then
	StellarLibrary:Loaded();
end;

-- 2. LOGIKA TELEPORTASI & KONTROL
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- Variabel Kontrol Global
local runningTaranjang = false
local teleportsLeftTaranjang = 10 
local delayTimeTaranjang = 2
local infiniteTaranjang = false 

local runningJapanese = false
local teleportsLeftJapanese = 10 
local delayTimeJapanese = 2
local infiniteJapanese = false 

local runningSibuatan = false -- BARU
local teleportsLeftSibuatan = 10 -- BARU
local delayTimeSibuatan = 2 -- BARU
local infiniteSibuatan = false -- BARU

-- FUNGSI INTI: MELAKUKAN SATU SIKLUS LOOP
local function executeCycle(summitCFrame, delay)
    local success = pcall(function()
        
        local char = player.Character or player.CharacterAdded:Wait(1)
        if not char then return end 

        local root = char:WaitForChild("HumanoidRootPart", 1)
        if not root then return end
        
        local newCharWait = player.CharacterAdded:Once() 
        
        -----------------------------------
        -- 1. TELEPORT KE SUMMIT
        -----------------------------------
        root.CFrame = summitCFrame
        
        -- ** JEDA 2 DETIK SETELAH TELEPORT **
        task.wait(2) 
        
        -----------------------------------
        -- 2. RESET/KILL KARAKTER
        -----------------------------------
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            humanoid.Health = 0
        end
        
        -----------------------------------
        -- 3. TUNGGU RESPOND KARAKTER BARU (WAJIB)
        -----------------------------------
        newCharWait:Wait() 
        
        -----------------------------------
        -- 4. DELAY (PATOKAN USER)
        -----------------------------------
        if delay > 0 then task.wait(delay) end
    end)
    
    if not success then
        task.wait(2)
        StellarLibrary:Notify("RUNNING SCRIPT ERROR", 2)
    end
    return success
end


-- Fungsi Utama: Memulai loop teleportasi Mount Taranjang
local function startTaranjangLoop(count, delay, isInfinite) 
    -- Hentikan loop lain sebelum memulai
    if runningJapanese then stopJapaneseLoop() end
    if runningSibuatan then stopSibuatanLoop() end 
    if runningTaranjang then stopTaranjangLoop(); task.wait(delay * 0.5) end

    -- Update variabel kontrol
    teleportsLeftTaranjang = count
    delayTimeTaranjang = delay
    infiniteTaranjang = isInfinite
    runningTaranjang = true
    
    local displayCount = isInfinite and "Infinite" or count
    StellarLibrary:Notify("Auto Summit Taranjang Dimulai! Count: " .. displayCount, 3);

    task.spawn(function()
        while runningTaranjang and (infiniteTaranjang or teleportsLeftTaranjang > 0) do
            executeCycle(TARANJANG_CFRAME, delayTimeTaranjang)
            
            if not infiniteTaranjang and teleportsLeftTaranjang > 0 then
                teleportsLeftTaranjang -= 1
            end
        end
        runningTaranjang = false
        StellarLibrary:Notify("Auto Summit Taranjang Selesai.", 2);
    end)
end

local function stopTaranjangLoop()
    runningTaranjang = false
    StellarLibrary:Notify("Auto Summit Taranjang Dihentikan Manual.", 2);
end


-- Fungsi Utama: Memulai loop teleportasi Mount Japanese
local function startJapaneseLoop(count, delay, isInfinite) 
    -- Hentikan loop lain sebelum memulai
    if runningTaranjang then stopTaranjangLoop() end
    if runningSibuatan then stopSibuatanLoop() end 
    if runningJapanese then stopJapaneseLoop(); task.wait(delay * 0.5) end

    -- Update variabel kontrol
    teleportsLeftJapanese = count
    delayTimeJapanese = delay
    infiniteJapanese = isInfinite
    runningJapanese = true
    
    local displayCount = isInfinite and "Infinite" or count
    StellarLibrary:Notify("Auto Summit Japanese Dimulai! Count: " .. displayCount, 3);

    task.spawn(function()
        while runningJapanese and (infiniteJapanese or teleportsLeftJapanese > 0) do
            executeCycle(JAPANESE_CFRAME, delayTimeJapanese)
            
            if not infiniteJapanese and teleportsLeftJapanese > 0 then
                teleportsLeftJapanese -= 1
            end
        end
        runningJapanese = false
        StellarLibrary:Notify("Auto Summit Japanese Selesai.", 2);
    end)
end

local function stopJapaneseLoop()
    runningJapanese = false
    StellarLibrary:Notify("Auto Summit Japanese Dihentikan Manual.", 2);
end

-- ===================================================================
-- FUNGSI BARU UNTUK MOUNT SIBUATAN
-- ===================================================================
local function startSibuatanLoop(count, delay, isInfinite) 
    -- Hentikan loop lain sebelum memulai
    if runningTaranjang then stopTaranjangLoop() end
    if runningJapanese then stopJapaneseLoop() end
    if runningSibuatan then stopSibuatanLoop(); task.wait(delay * 0.5) end

    -- Update variabel kontrol
    teleportsLeftSibuatan = count
    delayTimeSibuatan = delay
    infiniteSibuatan = isInfinite
    runningSibuatan = true
    
    local displayCount = isInfinite and "Infinite" or count
    StellarLibrary:Notify("Auto Summit Sibuatan Dimulai! Count: " .. displayCount, 3);

    task.spawn(function()
        while runningSibuatan and (infiniteSibuatan or teleportsLeftSibuatan > 0) do
            
            executeCycle(SIBUATAN_CFRAME, delayTimeSibuatan) -- Menggunakan SIBUATAN_CFRAME
            
            if not infiniteSibuatan and teleportsLeftSibuatan > 0 then
                teleportsLeftSibuatan -= 1
            end
        end
        runningSibuatan = false
        StellarLibrary:Notify("Auto Summit Sibuatan Selesai.", 2);
    end)
end

local function stopSibuatanLoop()
    runningSibuatan = false
    StellarLibrary:Notify("Auto Summit Sibuatan Dihentikan Manual.", 2);
end
-- ===================================================================


-- 3. PEMBUATAN WINDOW DAN TAB
local UserInputService = game:GetService("UserInputService")
local Window = StellarLibrary:Window({
	SubTitle = "Rafaczx HUB - " .. Author,
	Size = game:GetService("UserInputService").TouchEnabled and UDim2.new(0, 380, 0, 260) or UDim2.new(0, 500, 0, 320),
	TabWidth = 140
})

local MainTab = Window:Tab("MAIN", "rbxassetid://6032049611")
local TaranjangTab = Window:Tab("Mount Taranjang", "rbxassetid://10723407389")
local JapaneseTab = Window:Tab("Mount Japanese", "rbxassetid://10723407389")
local SibuatanTab = Window:Tab("Mount Sibuatan", "rbxassetid://10723407389") -- TAB BARU

-- 4. KONTROL UMUM DI TAB MAIN
MainTab:Seperator("General Control");

MainTab:Label("Welcome to Summit Auto Farm by " .. Author);
MainTab:Label("Pilih Mount yang ingin di Farm pada Tab di samping.");
MainTab:Line();

MainTab:Button("STOP SEMUA LOOP", function()
    stopTaranjangLoop();
    stopJapaneseLoop();
    stopSibuatanLoop(); -- MEMASTIKAN SIBUATAN JUGA DIHENTIKAN
end);

-- 5. KONTROL AUTO SUMMIT TARANJANG (TIDAK BERUBAH)
TaranjangTab:Seperator("Auto Summit Taranjang Settings by " .. Author);

-- TOGGLE INFINITE MASIH ADA
TaranjangTab:Toggle("INFINITE SUMMIT", false, function(state)
    infiniteTaranjang = state
    TeleportCountTextboxTaranjang:SetDisabled(state)
    if state then
        TeleportCountTextboxTaranjang:SetValue("Infinite")
    else
        TeleportCountTextboxTaranjang:SetValue(tostring(teleportsLeftTaranjang))
    end
end);

local TeleportCountTextboxTaranjang = TaranjangTab:Textbox("JUMLAH SUMMIT", "10", function(value)
    local count = tonumber(value)
    if count and count >= 0 then
        teleportsLeftTaranjang = math.floor(count) 
    end
end)

local DelayTextboxTaranjang = TaranjangTab:Textbox("DELAY", "2", function(value)
    local delay = tonumber(value)
    if delay and delay >= 0.1 then
        delayTimeTaranjang = delay
    end
end)

TaranjangTab:Line();

TaranjangTab:Button("START AUTO SUMMIT TARANJANG", function()
    local count = teleportsLeftTaranjang 
    local delay = delayTimeTaranjang
    local isInfinite = infiniteTaranjang
    
    startTaranjangLoop(count, delay, isInfinite);
end);

TaranjangTab:Button("STOP AUTO LOOP", function()
    stopTaranjangLoop();
end);

---
--- KONTROL UNTUK MOUNT JAPANESE (TIDAK BERUBAH)
---

JapaneseTab:Seperator("Auto Summit Japanese Settings by " .. Author);
JapaneseTab:Toggle("INFINITE SUMMIT", false, function(state)
    infiniteJapanese = state
    TeleportCountTextboxJapanese:SetDisabled(state)
    if state then
        TeleportCountTextboxJapanese:SetValue("Infinite")
    else
        TeleportCountTextboxJapanese:SetValue(tostring(teleportsLeftJapanese))
    end
end);

local TeleportCountTextboxJapanese = JapaneseTab:Textbox("JUMLAH SUMMIT", "10", function(value)
    local count = tonumber(value)
    if count and count >= 0 then
        teleportsLeftJapanese = math.floor(count) 
    end
end)

local DelayTextboxJapanese = JapaneseTab:Textbox("DELAY", "2", function(value)
    local delay = tonumber(value)
    if delay and delay >= 0.1 then
        delayTimeJapanese = delay
    end
end)

JapaneseTab:Line();

JapaneseTab:Button("START AUTO SUMMIT JAPANESE", function()
    local count = teleportsLeftJapanese 
    local delay = delayTimeJapanese
    local isInfinite = infiniteJapanese
    
    startJapaneseLoop(count, delay, isInfinite);
end);

JapaneseTab:Button("STOP AUTO LOOP", function()
    stopJapaneseLoop();
end);


-- ===================================================================
-- KONTROL UNTUK MOUNT SIBUATAN (BARU)
-- ===================================================================

SibuatanTab:Seperator("Auto Summit Sibuatan Settings by " .. Author);

-- TOGGLE INFINITE SIBUATAN
SibuatanTab:Toggle("INFINITE SUMMIT", false, function(state)
    infiniteSibuatan = state
    TeleportCountTextboxSibuatan:SetDisabled(state)
    if state then
        TeleportCountTextboxSibuatan:SetValue("Infinite")
    else
        TeleportCountTextboxSibuatan:SetValue(tostring(teleportsLeftSibuatan))
    end
end);

-- Textbox Loop Count SIBUATAN
local TeleportCountTextboxSibuatan = SibuatanTab:Textbox("JUMLAH SUMMIT", "10", function(value)
    local count = tonumber(value)
    if count and count >= 0 then
        teleportsLeftSibuatan = math.floor(count) 
    end
end)

-- Textbox Delay SIBUATAN
local DelayTextboxSibuatan = SibuatanTab:Textbox("DELAY", "2", function(value)
    local delay = tonumber(value)
    if delay and delay >= 0.1 then
        delayTimeSibuatan = delay
    end
end)

SibuatanTab:Line();

-- TOMBOL RUN UTAMA SIBUATAN
SibuatanTab:Button("START AUTO SUMMIT SIBUATAN", function()
    local count = teleportsLeftSibuatan 
    local delay = delayTimeSibuatan
    local isInfinite = infiniteSibuatan
    
    startSibuatanLoop(count, delay, isInfinite);
end);

-- TOMBOL STOP SIBUATAN
SibuatanTab:Button("STOP AUTO LOOP", function()
    stopSibuatanLoop();
end);
