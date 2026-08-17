--[[
    RXZ CODE Sniper
    Code Sniper + Riddle Solver

    Config file : rxz_code_sniper_config.json
    Stop script : getgenv().StopRXZ()
]]

local cloneref = cloneref or function(object)
    return object
end
local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local HttpService = cloneref(game:GetService("HttpService"))
local TweenService = cloneref(game:GetService("TweenService"))
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
if getgenv and getgenv().StopRXZ then
    pcall(getgenv().StopRXZ)
end

-- ===================== Config =====================

local CONFIG_FILE = "rxz_code_sniper_config.json"
local savedConfig = {
    codeSniper = true, autoSubmit = true, submitAfter = 3, riddleSolver = false,
}
pcall(function()
    if type(isfile) == "function" and type(readfile) == "function" and isfile(CONFIG_FILE) then
        local decoded = HttpService:JSONDecode(readfile(CONFIG_FILE))
        if type(decoded) == "table" then
            if type(decoded.codeSniper) == "boolean" then
                savedConfig.codeSniper = decoded.codeSniper
            end
            if type(decoded.autoSubmit) == "boolean" then
                savedConfig.autoSubmit = decoded.autoSubmit
            end
            if type(decoded.submitAfter) == "number" then
                savedConfig.submitAfter = math.max(1, math.floor(decoded.submitAfter))
            end
            if type(decoded.riddleSolver) == "boolean" then
                savedConfig.riddleSolver = decoded.riddleSolver
            end
        end
    end
end)
local function saveConfig()
    if type(writefile) ~= "function" then
        return
    end
    pcall(function()
        writefile(CONFIG_FILE, HttpService:JSONEncode({
            codeSniper = savedConfig.codeSniper, autoSubmit = savedConfig.autoSubmit, submitAfter = savedConfig.submitAfter,
            riddleSolver = savedConfig.riddleSolver,
        }
        ))
    end)
end

-- ===================== Executor Helpers =====================

local getupvalues = (debug and debug.getupvalues)
or getupvalues
local getconns = getconnections or(debug and debug.getconnections)
local setupv = (debug and debug.setupvalue)
or setupvalue
local httpRequest = (syn and syn.request)
or http_request or request or(http and http.request)
local env = typeof(getgenv) == "function" and getgenv()
or _G

-- ===================== Groq AI =====================

local GROQ_API_KEY = env.GROQ_API_KEY or env.GROQ_API_KEY or "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"

-- ===================== String Helpers =====================

local function stripRich(s)
    if type(s) ~= "string" then
        return tostring(s)
    end
    return(s:gsub("<[^>]->", ""))
end
local function trim(s)
    return(s or "") : gsub("^%s+", "") : gsub("%s+$", "")
end

-- ===================== GUI Detection =====================

local function isOurGui(instance)
    local p = instance
    for _ = 1, 10 do
        if not p then
            break
        end
        if p.Name == "RXZCodeSniperUI" or p.Name == "RXZRiddleUI" then
            return true
        end
        p = p.Parent
    end
    return false
end
local function isVisibleChain(inst)
    local current = inst
    while current do
        if current:IsA("GuiObject")
        and not current.Visible then
            return false
        end
        if current:IsA("ScreenGui") then
            return current.Enabled
        end
        current = current.Parent
    end
    return true
end

-- ===================== Code UI Discovery =====================

local function findAllTextBoxes(pg)
    local boxes = {
    }
    for _, gui in ipairs(pg:GetChildren())
    do
    if gui:IsA("ScreenGui")
    and gui.Enabled and not isOurGui(gui) then
        for _, d in ipairs(gui:GetDescendants())
        do
        if d:IsA("TextBox")
        and not isOurGui(d) then
            boxes [# boxes + 1] = d
        end
    end
end
end
return boxes
end
local function findCodeButtons(pg)
    local btns = {
    }
    for _, gui in ipairs(pg:GetChildren())
    do
    if gui:IsA("ScreenGui")
    and gui.Enabled and not isOurGui(gui) then
        for _, d in ipairs(gui:GetDescendants())
        do
        if(d:IsA("TextButton")
        or d:IsA("ImageButton"))
        and not isOurGui(d) then
            local n = d.Name:lower()
            local pn = (d.Parent and d.Parent.Name or "") : lower()
            if(n:find("code")
            or n:find("redeem")
            or pn:find("code")
            or pn:find("redeem"))
            and isVisibleChain(d) then
                btns [# btns + 1] = d
            end
        end
    end
end
end
return btns
end

-- ===================== Input Simulation =====================

local function clickButton(btn)
    if not btn then
        return false
    end
    local fired = false pcall(function()
        btn.MouseButton1Click:Fire()
        fired = true
    end)
    pcall(function()
        btn.Activated:Fire()
        fired = true
    end)
    if typeof(firesignal) == "function" then
        pcall(function()
            firesignal(btn.MouseButton1Click)
            fired = true
        end)
        pcall(function()
            firesignal(btn.Activated)
            fired = true
        end)
    end
    if typeof(getconns) == "function" then
        pcall(function()
            local ok, cs = pcall(getconns, btn.MouseButton1Click)
            if ok and type(cs) == "table" then
                for _, c in ipairs(cs)
                do
                pcall(function()
                    c:Fire()
                end)
            end
        end
        local ok2, cs2 = pcall(getconns, btn.Activated)
        if ok2 and type(cs2) == "table" then
            for _, c in ipairs(cs2)
            do
            pcall(function()
                c:Fire()
            end)
        end
    end
end)
end
if typeof(fireclick) == "function" then
    pcall(function()
        fireclick(btn)
        fired = true
    end)
end
return fired
end
local function fireBoxFocusLost(box)
    if not box then
        return false
    end
    local fired = false pcall(function()
        firesignal(box.FocusLost, true)
        fired = true
    end)
    if typeof(getconns) == "function" then
        pcall(function()
            local ok, cs = pcall(getconns, box.FocusLost)
            if ok and type(cs) == "table" then
                for _, c in ipairs(cs)
                do
                pcall(function()
                    if c.Enabled ~= false then
                        c:Fire(true)
                    end
                end)
            end
        end
    end)
end
return fired
end

-- ===================== Code Redeem =====================

local function typeAndSubmitCode(code)
    local pg = playerGui or player:FindFirstChildOfClass("PlayerGui")
    if not pg then
        return false, "no PlayerGui"
    end
    local codesGui = pg:FindFirstChild("Codes")
    if codesGui then
        pcall(function()
            codesGui.Enabled = true
        end)
        local codesFrame = codesGui:FindFirstChild("Codes")
        or codesGui
        if codesFrame then
            pcall(function()
                if codesFrame:IsA("GuiObject") then
                    codesFrame.Visible = true
                end
                local cur = codesFrame
                while cur and cur ~= codesGui do
                    if cur:IsA("GuiObject") then
                        cur.Visible = true
                    end
                    cur = cur.Parent
                end
            end)
            local box = nil
            for _, d in ipairs(codesFrame:GetDescendants())
            do
            if d:IsA("TextBox")
            and not isOurGui(d) then
                box = d break
            end
        end
        local submitBtn = nil
        for _, d in ipairs(codesFrame:GetDescendants())
        do
        if(d:IsA("TextButton")
        or d:IsA("ImageButton"))
        and not isOurGui(d) then
            local n = d.Name:lower()
            local txt = "" pcall(function()
                txt = d.Text:lower()
            end)
            if n:find("submit")
            or txt:find("submit")
            or n:find("redeem")
            or txt:find("redeem")
            or n:find("claim")
            or txt:find("confirm")
            or n:find("enter") then
                submitBtn = d break
            end
        end
    end
    if not submitBtn then
        for _, d in ipairs(codesFrame:GetDescendants())
        do
        if(d:IsA("TextButton")
        or d:IsA("ImageButton"))
        and not isOurGui(d) then
            local n = d.Name:lower()
            if not n:find("close")
            and not n:find("x")
            and not n:find("toggle") then
                submitBtn = d break
            end
        end
    end
end
if box then
    pcall(function()
        box.Text = code
    end)
    if submitBtn then
        clickButton(submitBtn)
    end
    fireBoxFocusLost(box)
    return true, "submitted"
end
end
end
local btns = findCodeButtons(pg)
for _, btn in ipairs(btns)
do
clickButton(btn)
end
local box = nil
local allBoxes = findAllTextBoxes(pg)
for _, d in ipairs(allBoxes)
do
if isVisibleChain(d) then
    local n = d.Name:lower()
    local pn = (d.Parent and d.Parent.Name or "") : lower()
    if n:find("code")
    or pn:find("code")
    or n:find("redeem")
    or pn:find("redeem")
    or n:find("input")
    or pn:find("textbox")
    or n:find("enter") then
        box = d break
    end
end
end
if not box then
    for _, d in ipairs(allBoxes)
    do
    if isVisibleChain(d) then
        box = d
        break
    end
end
end
if not box then
    return false, "no codebox visible"
end
pcall(function()
    box.Text = code
end)
local redeemBtn = nil
local searchNames = {
    "submit", "redeem", "claim", "confirm", "enter", "send", "apply", "ok", "use", "go", "check"
}
local p = box.Parent
for _ = 1, 6 do
    if not p then
        break
    end
    for _, d in ipairs(p:GetDescendants())
    do
    if(d:IsA("TextButton")
    or d:IsA("ImageButton"))
    and not isOurGui(d)
    and d ~= box then
        local n = d.Name:lower()
        local txt = "" pcall(function()
            txt = d.Text:lower()
        end)
        for _, sn in ipairs(searchNames)
        do
        if n:find(sn)
        or txt:find(sn) then
            if isVisibleChain(d) then
                redeemBtn = d break
            end
        end
    end
    if redeemBtn then
        break
    end
end
end
if redeemBtn then
    break
end
p = p.Parent
end
if redeemBtn then
    clickButton(redeemBtn)
end
fireBoxFocusLost(box)
return true, "submitted"
end
local function aceCodeBox()
    local pg = playerGui
    local allBoxes = findAllTextBoxes(pg)
    for _, box in ipairs(allBoxes)
    do
    if isVisibleChain(box) then
        return box
    end
end
return nil
end

-- ===================== Local Riddle Database =====================

local SAB_DB = {
    ["real name"] = "SAMMY", ["sammy real name"] = "SAMMY", ["sammys real name"] = "SAMMY", ["my real name"] = "SAMMY",
    ["creator real name"] = "SAMMY", ["owner real name"] = "SAMMY", ["creator name"] = "SAMMY", ["who created sab"] = "SAMMY",
    ["who made sab"] = "SAMMY", ["who made steal a brainrot"] = "SAMMY", ["who is the owner"] = "SAMMY",
    ["who owns sab"] = "SAMMY", ["owner"] = "SAMMY", ["creator"] = "SAMMY", ["roblox username"] = "SPYDERSAMMY",
    ["my roblox username"] = "SPYDERSAMMY", ["sammy username"] = "SPYDERSAMMY", ["sammy roblox name"] = "SPYDERSAMMY",
    ["roblox name"] = "SPYDERSAMMY", ["username"] = "SPYDERSAMMY", ["my username"] = "SPYDERSAMMY",
    ["how old am i"] = "24", ["how old is sammy"] = "24", ["my age"] = "24", ["sammy age"] = "24",
    ["age"] = "24", ["birth year"] = "2002", ["year born"] = "2002", ["year i was born"] = "2002",
    ["born year"] = "2002", ["birth day"] = "FRIDAY", ["day i was born"] = "FRIDAY", ["day born"] = "FRIDAY",
    ["birthday"] = "FRIDAY", ["born on"] = "FRIDAY", ["birth month"] = "FEBRUARY", ["month born"] = "FEBRUARY",
    ["month i was born"] = "FEBRUARY", ["where was i born"] = "ALGERIA", ["where was i born at"] = "ALGERIA",
    ["birthplace"] = "ALGERIA", ["where i was born"] = "ALGERIA", ["where am i from"] = "BRAZIL",
    ["where is sammy from"] = "BRAZIL", ["my country"] = "BRAZIL", ["sammy country"] = "BRAZIL",
    ["country"] = "BRAZIL", ["where do i live"] = "BRAZIL", ["where does sammy live"] = "BRAZIL",
    ["sammy location"] = "BRAZIL", ["nationality"] = "BRAZILIAN", ["sammy nationality"] = "BRAZILIAN",
    ["my nationality"] = "BRAZILIAN", ["state"] = "SAOPAULO", ["my state"] = "SAOPAULO", ["sammy state"] = "SAOPAULO",
    ["city"] = "SAOPAULO", ["my city"] = "SAOPAULO", ["sammy city"] = "SAOPAULO", ["favorite color"] = "BLUE",
    ["fav color"] = "BLUE", ["my color"] = "BLUE", ["sammy color"] = "BLUE", ["color"] = "BLUE",
    ["favourite color"] = "BLUE", ["favorite color is blue"] = "BLUE", ["fav color is blue"] = "BLUE",
    ["my color is blue"] = "BLUE", ["sammy color is blue"] = "BLUE", ["my favorite color is blue"] = "BLUE",
    ["color is blue"] = "BLUE", ["favorite sport"] = "FOOTBALL", ["fav sport"] = "FOOTBALL", ["sport"] = "FOOTBALL",
    ["my sport"] = "FOOTBALL", ["favorite food"] = "PIZZA", ["fav food"] = "PIZZA", ["my food"] = "PIZZA",
    ["food"] = "PIZZA", ["how much do i weigh"] = "250", ["how much do I weigh"] = "250", ["my weight"] = "250",
    ["weight"] = "250", ["where am i going after this"] = "GYM", ["where am I going after this"] = "GYM",
    ["where am i going"] = "GYM", ["where am I going"] = "GYM", ["where do i go after this"] = "GYM",
    ["where do I go after this"] = "GYM", ["going after this"] = "GYM", ["where is sammy going"] = "GYM",
    ["where is Sammy going"] = "GYM", ["what's my favorite color"] = "BLUE", ["whats my favorite color"] = "BLUE",
    ["what is my favorite color"] = "BLUE", ["my favorite color"] = "BLUE", ["when was sab made"] = "MAY162025",
    ["when was sab created"] = "MAY162025", ["when was the game made"] = "MAY162025", ["when was the game created"] = "MAY162025",
    ["sab release date"] = "MAY162025", ["game release date"] = "MAY162025", ["release date"] = "MAY162025",
    ["when made"] = "MAY162025", ["when created"] = "MAY162025", ["sab made"] = "MAY162025", ["what color is a leaf"] = "GREEN",
    ["what colour is a leaf"] = "GREEN", ["leaf color"] = "GREEN", ["leaf colour"] = "GREEN", ["color of a leaf"] = "GREEN",
    ["colour of a leaf"] = "GREEN", ["leaves color"] = "GREEN", ["leaves colour"] = "GREEN", ["what color are leaves"] = "GREEN",
    ["what colour are leaves"] = "GREEN", ["what color is a blueberry"] = "BLUE", ["what colour is a blueberry"] = "BLUE",
    ["blueberry color"] = "BLUE", ["blueberry colour"] = "BLUE", ["color of a blueberry"] = "BLUE",
    ["colour of a blueberry"] = "BLUE", ["what color are blueberries"] = "BLUE", ["what colour are blueberries"] = "BLUE",
    ["blueberries color"] = "BLUE", ["blueberries colour"] = "BLUE", ["what color is the sky"] = "BLUE",
    ["what colour is the sky"] = "BLUE", ["sky color"] = "BLUE", ["sky colour"] = "BLUE", ["color of the sky"] = "BLUE",
    ["colour of the sky"] = "BLUE", ["what color is grass"] = "GREEN", ["what colour is grass"] = "GREEN",
    ["grass color"] = "GREEN", ["grass colour"] = "GREEN", ["color of grass"] = "GREEN", ["colour of grass"] = "GREEN",
    ["what color is an apple"] = "RED", ["what colour is an apple"] = "RED", ["apple color"] = "RED",
    ["apple colour"] = "RED", ["color of an apple"] = "RED", ["colour of an apple"] = "RED", ["what color are apples"] = "RED",
    ["what colour are apples"] = "RED", ["what color is a banana"] = "YELLOW", ["what colour is a banana"] = "YELLOW",
    ["banana color"] = "YELLOW", ["banana colour"] = "YELLOW", ["color of a banana"] = "YELLOW",
    ["colour of a banana"] = "YELLOW", ["what color are bananas"] = "YELLOW", ["what colour are bananas"] = "YELLOW",
    ["what color is an orange"] = "ORANGE", ["what colour is an orange"] = "ORANGE", ["orange color"] = "ORANGE",
    ["orange colour"] = "ORANGE", ["color of an orange"] = "ORANGE", ["colour of an orange"] = "ORANGE",
    ["what color are oranges"] = "ORANGE", ["what colour are oranges"] = "ORANGE", ["what color is a strawberry"] = "RED",
    ["what colour is a strawberry"] = "RED", ["strawberry color"] = "RED", ["strawberry colour"] = "RED",
    ["color of a strawberry"] = "RED", ["colour of a strawberry"] = "RED", ["what color are strawberries"] = "RED",
    ["what colour are strawberries"] = "RED", ["what color is a grape"] = "PURPLE", ["what colour is a grape"] = "PURPLE",
    ["grape color"] = "PURPLE", ["grape colour"] = "PURPLE", ["color of a grape"] = "PURPLE", ["colour of a grape"] = "PURPLE",
    ["what color are grapes"] = "PURPLE", ["what colour are grapes"] = "PURPLE", ["what color is a watermelon"] = "GREEN",
    ["what colour is a watermelon"] = "GREEN", ["watermelon color"] = "GREEN", ["watermelon colour"] = "GREEN",
    ["color of a watermelon"] = "GREEN", ["colour of a watermelon"] = "GREEN", ["what color is a lemon"] = "YELLOW",
    ["what colour is a lemon"] = "YELLOW", ["lemon color"] = "YELLOW", ["lemon colour"] = "YELLOW",
    ["color of a lemon"] = "YELLOW", ["colour of a lemon"] = "YELLOW", ["what color is a cherry"] = "RED",
    ["what colour is a cherry"] = "RED", ["cherry color"] = "RED", ["cherry colour"] = "RED", ["color of a cherry"] = "RED",
    ["colour of a cherry"] = "RED", ["what color is snow"] = "WHITE", ["what colour is snow"] = "WHITE",
    ["snow color"] = "WHITE", ["snow colour"] = "WHITE", ["color of snow"] = "WHITE", ["colour of snow"] = "WHITE",
    ["what color is coal"] = "BLACK", ["what colour is coal"] = "BLACK", ["coal color"] = "BLACK",
    ["coal colour"] = "BLACK", ["color of coal"] = "BLACK", ["colour of coal"] = "BLACK", ["what color is the sun"] = "YELLOW",
    ["what colour is the sun"] = "YELLOW", ["sun color"] = "YELLOW", ["sun colour"] = "YELLOW", ["color of the sun"] = "YELLOW",
    ["colour of the sun"] = "YELLOW", ["what color is a pumpkin"] = "ORANGE", ["what colour is a pumpkin"] = "ORANGE",
    ["pumpkin color"] = "ORANGE", ["pumpkin colour"] = "ORANGE", ["color of a pumpkin"] = "ORANGE",
    ["colour of a pumpkin"] = "ORANGE", ["what color is chocolate"] = "BROWN", ["what colour is chocolate"] = "BROWN",
    ["chocolate color"] = "BROWN", ["chocolate colour"] = "BROWN", ["color of chocolate"] = "BROWN",
    ["colour of chocolate"] = "BROWN", ["how many colors in a rainbow"] = "SEVEN", ["how many colours in a rainbow"] = "SEVEN",
    ["colors in a rainbow"] = "SEVEN", ["colours in a rainbow"] = "SEVEN", ["rainbow colors"] = "SEVEN",
    ["rainbow colours"] = "SEVEN", ["how many days in a week"] = "SEVEN", ["days in a week"] = "SEVEN",
    ["how many months in a year"] = "TWELVE", ["months in a year"] = "TWELVE", ["how many sides does a triangle have"] = "THREE",
    ["sides of a triangle"] = "THREE", ["triangle sides"] = "THREE", ["how many sides does a square have"] = "FOUR",
    ["sides of a square"] = "FOUR", ["square sides"] = "FOUR", ["what sound does a dog make"] = "BARK",
    ["dog sound"] = "BARK", ["sound of a dog"] = "BARK", ["what sound does a cat make"] = "MEOW",
    ["cat sound"] = "MEOW", ["sound of a cat"] = "MEOW", ["what sound does a cow make"] = "MOO",
    ["cow sound"] = "MOO", ["sound of a cow"] = "MOO", ["what sound does a pig make"] = "OINK", ["pig sound"] = "OINK",
    ["sound of a pig"] = "OINK", ["what is 1 plus 1"] = "2", ["1+1"] = "2", ["what is one plus one"] = "2",
    ["one plus one"] = "2", ["what is 2 plus 2"] = "4", ["2+2"] = "4", ["what is two plus two"] = "4",
    ["two plus two"] = "4", ["what is 5 plus 5"] = "10", ["5+5"] = "10", ["what is five plus five"] = "10",
    ["five plus five"] = "10", ["what is 10 plus 10"] = "20", ["10+10"] = "20", ["what is ten plus ten"] = "20",
    ["ten plus ten"] = "20",
}

-- ===================== Local Answer Lookup =====================

local function localExactAnswer(text)
    if not text or text == "" then
        return nil
    end
    local l = text:lower()
    local clean = l clean = clean:gsub("what%s+is", "") : gsub("what%s+are", "") : gsub("what%s+was",
    "") : gsub("what%s+were", "")
    clean = clean:gsub("who%s+is", "") : gsub("who%s+was", "") : gsub("when%s+is",
    "") : gsub("when%s+was", "")
    clean = clean:gsub("where%s+is", "") : gsub("where%s+are",
    "") : gsub("how%s+old", "") : gsub("how%s+tall", "")
    clean = clean:gsub("how%s+many", "") : gsub("how%s+much",
    "") : gsub("do%s+you%s+know", "") : gsub("can%s+you%s+tell", "")
    clean = clean:gsub("tell%s+me",
    "") : gsub("i%s+need", "") : gsub("give%s+me", "") : gsub("what's", "") : gsub("whats",
    "")
    clean = clean:gsub("am%s+i", "") : gsub("do%s+i", "") : gsub("did%s+i", "") : gsub("have%s+i",
    "")
    clean = clean:gsub("^my%s+", "") : gsub("%s+my%s+", " ") : gsub("^sammy[s]?%s+", "") : gsub("^sammys%s+",
    "")
    clean = clean:gsub("the%s+", "") : gsub("%f[%a]a%f[%A]", "") : gsub("%f[%a]an%f[%A]",
    "") : gsub("of%s+", "") : gsub("for%s+", "")
    clean = clean:gsub("[%?%.%,!]", "") : gsub("^%s+",
    "") : gsub("%s+$", "")
    clean = clean:gsub("%d+", "") : gsub("%s+", " ")
    clean = trim(clean)
    if SAB_DB [clean] then
        return SAB_DB [clean]
    end
    local raw = trim(l:gsub("[%?%.%,!]", "") : gsub("%s+", " "))
    if SAB_DB [raw] then
        return SAB_DB [raw]
    end
    return nil
end

-- ===================== AI System Prompt =====================

local AI_SYSTEM = table.concat({
    "You are a riddle-answering bot for the Roblox game STEAL A BRAINROT(SAB).", "", "=== CRITICAL OUTPUT RULES ===",
    "1. Reply with ONE single word in ALL CAPS. NOTHING else. No punctuation.", "2. NEVER include spaces. Write HEADLESSHORSEMAN not HEADLESS HORSEMAN.",
    "3. NEVER repeat the answer. Return the BASE answer exactly once.", "4. NEVER spell out numbers as words. If the answer is a number, write it as digits: 24 not TWENTYFOUR.",
    "5. No explanation, no extra text, just the single answer word.", "", "=== CONTEXT ===", "All personal questions refer to the game owner SAMMY(SpyderSammy).",
    "", "=== OWNER: SAMMY ===", "Real name: SAMMY | Roblox username: SPYDERSAMMY | Age: 24 | Birth year: 2001",
    "Born day: FRIDAY | Birth month: JANUARY | Country: BRAZIL | State+City: SAOPAULO", "Favorite color: BLUE | Favorite sport: FOOTBALL | Favorite food: PIZZA",
    "Favorite football player: RONALDO | Favorite animal: SPIDER", "Weight: 250 lbs", "", "=== GAME INFO ===",
    "Full name: STEALABRAINROT | Genre: SIMULATOR | Release date: MAY 16 2025", "Max server size: EIGHT players | First trait: LIGHTNING | Lightning strike trait: MATEO",
    "Total mutations: THIRTEEN | Total machines: EIGHTEEN | Total rarities: SIX", "", "=== RARITIES ===",
    "COMMON < UNCOMMON < RARE < EPIC < LEGENDARY < OG", "Highest/rarest: OG | Lowest: COMMON", "Rarest/unobtainable brainrot: HEADLESSHORSEMAN",
    "", "=== MUTATIONS ===", "1=GOLD 2=DIAMOND 3=BLOODROT 4=RAINBOW 5=CANDY 6=LAVA 7=GALAXY", "8=YINYANG 9=RADIOACTIVE 10=CURSED 11=DIVINE 12=CYBER 13=PHANTOM 14=CRYSTAL",
    "Newest: CRYSTAL | Evil: CURSED | Angelic: DIVINE", "", "=== MACHINES ===", "1=RAINBOWMACHINE 2=BUBBLEGUMMACHINE 3=FUSEMACHINE 4=CRAFTMACHINE 5=WITCHFUSE",
    "6=BRAINROTDEALER 7=BRAINROTTRADER 8=SANTASFUSE 9=SANTASSHOP 10=NEWYEARSMACHINE", "11=DUELSMACHINE 12=CUPIDSMACHINE 13=TRADEMACHINE 14=DIVINEFUSE 15=EGGINCUBATOR",
    "16=CYBERCRAFTMACHINE 17=SUMMERFUSE 18=LOSTRADERS", "Newest: LOSTRADERS",
},
"\n")

-- ===================== AI Query =====================

local function queryAI(question, statusCb)
    local function stat(msg)
        if statusCb then
            statusCb(msg)
        end
    end
    if not httpRequest then
        return nil, nil, "no http executor"
    end
    if not GROQ_API_KEY or GROQ_API_KEY == "" then
        return nil, nil, "GROQ_API_KEY is empty"
    end
    stat("calling AI...")
    local body = HttpService:JSONEncode({
        model = "llama-3.3-70b-versatile", messages = {
            {
                role = "system", content = AI_SYSTEM
            },
            {
                role = "user", content = "/no_think\n".. tostring(question).. "\n\nRules: ONE word, ALL CAPS, NO spaces, NO repetition.",
            },
        },
        temperature = 0, max_tokens = 64,
    }
    )
    local ok, res = pcall(httpRequest, {
        Url = "https://api.groq.com/openai/v1/chat/completions", Method = "POST", Headers = {
            ["Content-Type"] = "application/json", ["Authorization"] = "Bearer ".. GROQ_API_KEY,
        },
        Body = body,
    }
    )
    if not ok then
        return nil, nil, "http_err: ".. tostring(res) : sub(1, 100)
    end
    if not res or not res.Body then
        return nil, nil, "empty body"
    end
    local sc = tonumber(res.StatusCode)
    if sc and sc ~= 200 then
        local bOk, bP = pcall(HttpService.JSONDecode, HttpService, res.Body)
        local detail = (bOk and bP and bP.error and bP.error.message)
        or res.Body:sub(1, 120)
        return nil, nil, ("HTTP %d: %s") : format(sc, tostring(detail) : gsub("\n", " "))
    end
    local pOk, parsed = pcall(HttpService.JSONDecode, HttpService, res.Body)
    if not pOk or not parsed then
        return nil, nil, "JSON parse failed"
    end
    if parsed.error then
        return nil, nil, "API: ".. (parsed.error.message or "unknown error")
    end
    local choice = parsed.choices and parsed.choices [1]
    if not choice then
        return nil, nil, "no choices in response"
    end
    local answer = (choice.message and choice.message.content)
    or "" answer = trim(answer) : upper() : gsub("[%s%?%.%,!\"'`\n\r]+",
    "")
    if answer == "" then
        return nil, nil, "empty answer from model"
    end
    if answer:find(":") then
        answer = answer:match(":([^:]+)$")
        or answer
    end
    if # answer > 25 then
        local best = nil
        for _, v in pairs(SAB_DB)
        do
        local clean = v:upper() : gsub("%s+", "")
        if # clean > 0 and answer:sub(- # clean) == clean then
            if not best or # clean > # best then
                best = clean
            end
        end
    end
    answer = best or answer:sub(- 25)
end
return answer, nil, nil
end

-- ===================== Riddle Parsing =====================

local function extractNumber(text)
    for num in text:gmatch("%d+")
    do
    local n = tonumber(num)
    if n and n > 13 then
        return num
    end
end
return nil
end
local function splitAllParts(text)
    local clean = text or "" clean = clean:gsub("%s+add%s+", " and ")
    clean = clean:gsub("%s*,%s*",
    " and ")
    clean = clean:gsub("%s+at%s+the%s+end", " ")
    clean = clean:gsub("%s+at%s+the%s+start",
    " ")
    local parts = {
    }
    for part in(clean.. " and ") : gmatch("(.-)%s+and%s+")
    do
    part = trim(part)
    if part ~= "" then
        parts [# parts + 1] = part
    end
end
if # parts == 0 then
    parts [1] = trim(text or "")
end
return parts
end
local function resolvePart(part, statusCb)
    local q = trim(part)
    if q == "" then
        return nil
    end
    local onlyNum = q:match("^%d+$")
    if onlyNum then
        return onlyNum
    end
    local a = localExactAnswer(q)
    if not a then
        if statusCb then
            statusCb("AI: ".. q:sub(1, 40))
        end
        a = select(1, queryAI(q, statusCb))
    end
    if not a then
        return nil
    end
    local clean = tostring(a) : upper() : gsub("%s+", "") : gsub("[%?%.%,!\"'`]", "")
    if clean:find("ATTHEEND")
    or clean:find("ATTHESTART")
    or clean == "AND" then
        return nil
    end
    if clean == "" then
        return nil
    end
    return clean
end

-- ===================== Riddle Solver =====================

local function solveRiddle(text, statusCb)
    local suffix = extractNumber(text)
    local parts = splitAllParts(text)
    local answers = {
    }
    for _, part in ipairs(parts)
    do
    local ok, result = pcall(resolvePart, part, statusCb)
    if ok and result and result ~= "" then
        answers [# answers + 1] = result
    end
end
if # answers == 0 then
    if statusCb then
        statusCb("AI full question")
    end
    local a = select(1, queryAI(text, statusCb))
    if a then
        local clean = tostring(a) : upper() : gsub("%s+", "") : gsub("[%?%.%,!\"'`]", "")
        clean = clean:gsub("ATTHEEND",
        "") : gsub("ATTHESTART", "")
        if suffix and clean:sub(- # suffix) ~= suffix then
            clean = clean.. suffix
        end
        return clean, nil, nil
    end
    return nil, nil, "no answer"
end
local out = table.concat(answers, "")
if suffix and out:sub(- # suffix) ~= suffix then
    out = out.. suffix
end
return out, nil, nil
end
local function submitRiddleAnswer(answer)
    local success, msg = typeAndSubmitCode(answer)
    return success, msg
end
local function looksLikeAnnouncement(...)
    local args = table.pack(...)
    if args.n == 0 or typeof(args [1]) ~= "string" then
        return false
    end
    for i = 2, args.n do
        local value = args [i]
        if typeof(value) == "string" and(value:find("Sounds%.")
        or value:find("rbxassetid")
        or value:find("Top")
        or value:find("Bottom")
        or value:find("Center")) then
            return true
        end
    end
    return false
end

-- ===================== UI Theme =====================

local COLORS = {
    Window = Color3.fromRGB(10, 10, 10), Row = Color3.fromRGB(26, 26, 26), Control = Color3.fromRGB(40,
    40, 40), Log = Color3.fromRGB(16, 16, 16), Border = Color3.fromRGB(255, 255, 255),
    White = Color3.fromRGB(255, 255, 255), Text = Color3.fromRGB(235, 235, 235), Dim = Color3.fromRGB(150,
    150, 150), Accent = Color3.fromRGB(255, 255, 255), Green = Color3.fromRGB(255, 255, 255),
    Red = Color3.fromRGB(120, 120, 120), Black = Color3.fromRGB(0, 0, 0), Highlight = Color3.fromRGB(70,
    70, 70), DarkAccent = Color3.fromRGB(45, 45, 45), Purple = Color3.fromRGB(255, 255,
    255),
}

-- ===================== UI Builders =====================

local function addCorner(parent, radius)
    local value = Instance.new("UICorner")
    value.CornerRadius = UDim.new(0, radius)
    value.Parent = parent
    return value
end
local function addStroke(parent, color, thickness, transparency)
    local value = Instance.new("UIStroke")
    value.ApplyStrokeMode = Enum.ApplyStrokeMode.Border value.Color = color value.Thickness = thickness or 1 value.Transparency = transparency or 0 value.Parent = parent
    return value
end
local ASSET_ID = "rbxassetid://129855376130670"
local function addLogo(parent)
    local logo = Instance.new("ImageLabel")
    logo.Name = "Logo"
    logo.Size = UDim2.fromOffset(34, 34)
    logo.Position = UDim2.fromOffset(18, 14)
    logo.BackgroundTransparency = 1
    logo.Image = ASSET_ID
    logo.ScaleType = Enum.ScaleType.Fit
    logo.ZIndex = 6
    logo.Parent = parent
    addCorner(logo, 10)
    return logo
end
local function addSettingsBackground(parent)
    local bg = Instance.new("ImageLabel")
    bg.Name = "SettingsBackground"
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.Position = UDim2.fromOffset(0, 0)
    bg.BackgroundTransparency = 1
    bg.Image = ASSET_ID
    bg.ScaleType = Enum.ScaleType.Fit
    bg.ImageTransparency = 0.3
    bg.ZIndex = 0
    bg.Parent = parent
    return bg
end
local function addMinimizeButton(header, window, header_height, full_height, hiddenParts)
    local button = Instance.new("TextButton")
    button.Name = "Minimize"
    button.Size = UDim2.fromOffset(28, 28)
    button.Position = UDim2.new(1, - 114, 0.5, - 14)
    button.BackgroundColor3 = COLORS.Control
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Active = true
    button.Text = "-"
    button.TextSize = 20
    button.TextColor3 = COLORS.White
    button.Font = Enum.Font.GothamBold
    button.ZIndex = 6
    button.Parent = header
    addCorner(button, 14)
    addStroke(button, COLORS.Border, 1, 0.5)
    local collapsed = false
    local lastPress = 0
    local function toggleMinimize()
        if tick() - lastPress < 0.15 then
            return
        end
        lastPress = tick()
        collapsed = not collapsed
        button.Text = collapsed and "+" or "-"
        for _, part in ipairs(hiddenParts) do
            if part then
                part.Visible = not collapsed
            end
        end
        local targetHeight = collapsed and header_height or full_height
        window:TweenSize(UDim2.fromOffset(window.Size.X.Offset, targetHeight),
        Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.18, true)
    end
    button.MouseButton1Click:Connect(toggleMinimize)
    button.Activated:Connect(toggleMinimize)
    return button
end
local function makeLabel(parent, name, text, size, position, textSize, color, font)
    local label = Instance.new("TextLabel")
    label.Name = name label.Size = size label.Position = position label.BackgroundTransparency = 1 label.Text = text label.TextSize = textSize label.TextColor3 = color label.Font = font or Enum.Font.GothamMedium label.TextXAlignment = Enum.TextXAlignment.Left label.TextYAlignment = Enum.TextYAlignment.Center label.Parent = parent
    return label
end
local function makeToggleButton(parent, enabled, onToggle)
    local button = Instance.new("TextButton")
    button.Name = "Toggle" button.Size = UDim2.fromOffset(50,
    24)
    button.Position = UDim2.new(1, - 60, 0.5, - 12)
    button.BackgroundColor3 = enabled and COLORS.Purple or Color3.fromRGB(35, 35, 35)
    button.BorderSizePixel = 0 button.AutoButtonColor = false button.Active = true button.Text = enabled and "ON" or "OFF" button.TextSize = 10 button.TextColor3 = enabled and Color3.fromRGB(0, 0, 0)
    or Color3.fromRGB(140, 140, 140)
    button.Font = Enum.Font.GothamBold button.ZIndex = 5 button.Parent = parent addCorner(button,
    12)
    addStroke(button, COLORS.Border, 1, enabled and 0.4 or 0.7)
    local state = enabled
    local lastSubToggle = 0
    local function toggleState()
        if tick() - lastSubToggle < 0.15 then
            return
        end
        lastSubToggle = tick()
        state = not state button.BackgroundColor3 = state and COLORS.Purple or Color3.fromRGB(35, 35, 35)
        button.Text = state and "ON" or "OFF" button.TextColor3 = state and Color3.fromRGB(0, 0, 0)
    or Color3.fromRGB(140, 140, 140)
        if onToggle then
            onToggle(state)
        end
    end
    button.MouseButton1Click:Connect(toggleState)
    button.Activated:Connect(toggleState)
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggleState()
        end
    end)
    return button
end
pcall(function()
    for _, name in ipairs({
        "RXZCodeSniperUI", "RXZRiddleUI", "AutoTypeCodesUI", "ACEPaste"
    }
    )
    do
    local previous = game.CoreGui:FindFirstChild(name)
    if previous then
        previous:Destroy()
    end
end
end)
for _, name in ipairs({
    "RXZCodeSniperUI", "RXZRiddleUI", "AutoTypeCodesUI", "ACEPaste"
}
)
do
local previous = playerGui:FindFirstChild(name)
if previous then
    previous:Destroy()
end
end

-- ===================== Code Sniper UI =====================

local SniperGUI = Instance.new("ScreenGui")
SniperGUI.Name = "RXZCodeSniperUI" SniperGUI.ResetOnSpawn = false SniperGUI.IgnoreGuiInset = true SniperGUI.DisplayOrder = 999
if not pcall(function()
    SniperGUI.Parent = game.CoreGui
end) then
    SniperGUI.Parent = playerGui
end
local SniperWindow = Instance.new("Frame")
SniperWindow.Name = "Window" SniperWindow.Size = UDim2.fromOffset(340,
210)
SniperWindow.AnchorPoint = Vector2.new(0.5, 0.5)
SniperWindow.Position = UDim2.new(0.5,
0, 0.5, 0)
SniperWindow.BackgroundColor3 = COLORS.Window SniperWindow.BorderSizePixel = 0 SniperWindow.ClipsDescendants = true SniperWindow.Parent = SniperGUI addCorner(SniperWindow,
16)
addStroke(SniperWindow, COLORS.Border, 1, 0.15)
local SniperScale = Instance.new("UIScale")
SniperScale.Name = "InterfaceScale" SniperScale.Scale = 0.92 SniperScale.Parent = SniperWindow
local viewportConnection
local function updateSniperScale()
    local camera = workspace.CurrentCamera
    if not camera then
        SniperScale.Scale = 0.92
        return
    end
    local viewport = camera.ViewportSize
    local fitScale = math.min((viewport.X - 16) / 340, (viewport.Y - 16) / 210)
    if UserInputService.TouchEnabled then
        local mobileTarget = 0.72 SniperScale.Scale = math.max(0.45, math.min(mobileTarget, fitScale))
    else
        SniperScale.Scale = 0.92
    end
end
local function watchSniperViewport()
    if viewportConnection then
        viewportConnection:Disconnect()
        viewportConnection = nil
    end
    local camera = workspace.CurrentCamera
    if camera then
        viewportConnection = camera:GetPropertyChangedSignal("ViewportSize") : Connect(updateSniperScale)
    end
    updateSniperScale()
end
workspace:GetPropertyChangedSignal("CurrentCamera") : Connect(watchSniperViewport)
watchSniperViewport()
local SniperHeader = Instance.new("Frame")
SniperHeader.Name = "Header" SniperHeader.Size = UDim2.new(1,
0, 0, 70)
SniperHeader.BackgroundTransparency = 1 SniperHeader.Active = true SniperHeader.ZIndex = 3 SniperHeader.Parent = SniperWindow
local TopLine = Instance.new("Frame")
TopLine.Name = "TopLine" TopLine.Size = UDim2.new(1,
- 40, 0, 2)
TopLine.Position = UDim2.fromOffset(20, 10)
TopLine.BackgroundColor3 = COLORS.Border TopLine.BackgroundTransparency = 0.3 TopLine.BorderSizePixel = 0 TopLine.Parent = SniperHeader addCorner(TopLine,
1)
makeLabel(SniperHeader, "Title", "RXZ CODE Sniper", UDim2.fromOffset(220, 30), UDim2.fromOffset(20,
14), 16, COLORS.White, Enum.Font.GothamBold)
makeLabel(SniperHeader, "Subtitle", "Code Sniper",
UDim2.fromOffset(220, 20), UDim2.fromOffset(20, 40), 11, COLORS.Dim, Enum.Font.GothamMedium)
local SniperToggleButton = Instance.new("TextButton")
SniperToggleButton.Name = "MainToggle" SniperToggleButton.Size = UDim2.fromOffset(70,
30)
SniperToggleButton.Position = UDim2.new(1, - 80, 0.5, - 15)
SniperToggleButton.BackgroundColor3 = savedConfig.codeSniper and COLORS.Purple or Color3.fromRGB(35, 35, 35)
SniperToggleButton.BorderSizePixel = 0 SniperToggleButton.AutoButtonColor = false SniperToggleButton.Active = true SniperToggleButton.Text = savedConfig.codeSniper and "ON" or "OFF" SniperToggleButton.TextSize = 12 SniperToggleButton.TextColor3 = savedConfig.codeSniper and Color3.fromRGB(0, 0, 0)
    or Color3.fromRGB(140, 140, 140)
SniperToggleButton.Font = Enum.Font.GothamBold SniperToggleButton.ZIndex = 5 SniperToggleButton.Parent = SniperHeader addCorner(SniperToggleButton,
15)
addStroke(SniperToggleButton, COLORS.Border, 1, 0.45)
local SniperHeaderDivider = Instance.new("Frame")
SniperHeaderDivider.Name = "HeaderDivider" SniperHeaderDivider.Size = UDim2.new(1,
- 40, 0, 1)
SniperHeaderDivider.Position = UDim2.fromOffset(20, 66)
SniperHeaderDivider.BackgroundColor3 = COLORS.Border SniperHeaderDivider.BackgroundTransparency = 0.4 SniperHeaderDivider.BorderSizePixel = 0 SniperHeaderDivider.Parent = SniperHeader
local SniperSettings = Instance.new("Frame")
SniperSettings.Name = "Settings" SniperSettings.Size = UDim2.new(1,
- 20, 0, 110)
SniperSettings.Position = UDim2.fromOffset(10, 75)
SniperSettings.BackgroundTransparency = 1 SniperSettings.ZIndex = 3 SniperSettings.Parent = SniperWindow
addSettingsBackground(SniperSettings)
local function makeCard(name, position, size)
    local card = Instance.new("Frame")
    card.Name = name card.Position = position card.Size = size card.BackgroundColor3 = COLORS.Row card.BackgroundTransparency = 0 card.BorderSizePixel = 0 card.Parent = SniperSettings addCorner(card,
    10)
    addStroke(card, COLORS.Border, 1, 0.25)
    return card
end
local AutoCard = makeCard("AutoSubmit", UDim2.fromOffset(0, 0), UDim2.fromOffset(290, 42))
makeLabel(AutoCard,
"Title", "Auto Type", UDim2.fromOffset(200, 42), UDim2.fromOffset(15, 0), 13, COLORS.Text,
Enum.Font.GothamMedium)
makeToggleButton(AutoCard, savedConfig.autoSubmit, function(state)
    savedConfig.autoSubmit = state saveConfig()
end)
local DelayCard = makeCard("SubmitAfter", UDim2.fromOffset(0, 48), UDim2.fromOffset(290,
52))
makeLabel(DelayCard, "Title", "Capture Count", UDim2.fromOffset(200, 52), UDim2.fromOffset(15,
0), 13, COLORS.Text, Enum.Font.GothamMedium)
local CounterContainer = Instance.new("Frame")
CounterContainer.Name = "CounterContainer" CounterContainer.Size = UDim2.fromOffset(100,
30)
CounterContainer.Position = UDim2.new(1, - 115, 0.5, - 15)
CounterContainer.BackgroundTransparency = 1 CounterContainer.Parent = DelayCard
local MinusBtn = Instance.new("TextButton")
MinusBtn.Name = "Minus" MinusBtn.Size = UDim2.fromOffset(28,
30)
MinusBtn.Position = UDim2.fromOffset(0, 0)
MinusBtn.BackgroundColor3 = COLORS.Control MinusBtn.BorderSizePixel = 0 MinusBtn.Text = "-" MinusBtn.TextSize = 18 MinusBtn.TextColor3 = COLORS.White MinusBtn.Font = Enum.Font.GothamBold MinusBtn.Parent = CounterContainer addCorner(MinusBtn,
7)
addStroke(MinusBtn, COLORS.Border, 1, 0.5)
local Count = makeLabel(CounterContainer, "Count", tostring(savedConfig.submitAfter), UDim2.fromOffset(44,
30), UDim2.fromOffset(28, 0), 18, COLORS.White, Enum.Font.GothamBold)
Count.TextXAlignment = Enum.TextXAlignment.Center
local PlusBtn = Instance.new("TextButton")
PlusBtn.Name = "Plus" PlusBtn.Size = UDim2.fromOffset(28,
30)
PlusBtn.Position = UDim2.new(1, - 28, 0, 0)
PlusBtn.BackgroundColor3 = COLORS.Control PlusBtn.BorderSizePixel = 0 PlusBtn.Text = "+" PlusBtn.TextSize = 18 PlusBtn.TextColor3 = COLORS.White PlusBtn.Font = Enum.Font.GothamBold PlusBtn.Parent = CounterContainer addCorner(PlusBtn,
7)
addStroke(PlusBtn, COLORS.Border, 1, 0.5)
local function updateSubmitAfter(newValue)
    savedConfig.submitAfter = math.max(1, newValue)
    saveConfig()
    Count.Text = tostring(savedConfig.submitAfter)
    appendRiddleConsoleLog("system",
    "Capture count set to: ".. savedConfig.submitAfter, "rgb(150,150,150)")
end
MinusBtn.MouseButton1Click:Connect(function()
    updateSubmitAfter(savedConfig.submitAfter - 1)
end)
PlusBtn.MouseButton1Click:Connect(function()
    updateSubmitAfter(savedConfig.submitAfter + 1)
end)
local SniperBottomBar = Instance.new("Frame")
SniperBottomBar.Name = "BottomBar" SniperBottomBar.Size = UDim2.new(1,
0, 0, 28)
SniperBottomBar.Position = UDim2.new(0, 0, 1, - 28)
SniperBottomBar.BackgroundColor3 = COLORS.Row SniperBottomBar.BackgroundTransparency = 0 SniperBottomBar.BorderSizePixel = 0 SniperBottomBar.Parent = SniperWindow addCorner(SniperBottomBar,
16)
SniperBottomBar.ClipsDescendants = true
local SniperMinimizeButton = addMinimizeButton(SniperHeader, SniperWindow, 70, 210, {
    SniperSettings, SniperBottomBar, SniperHeaderDivider
})
makeLabel(SniperBottomBar, "Version", "RXZ CODE Sniper v1",
UDim2.fromOffset(200, 28), UDim2.fromOffset(15, 0), 10, COLORS.Dim, Enum.Font.GothamMedium)
do
local dragging = false
local activeDragInput
local dragStart
local startPosition
local dragMoved = false
local DRAG_THRESHOLD = UserInputService.TouchEnabled and 10 or 3
local function isOverSniperHeaderControl(position)
    for _, control in ipairs({ SniperToggleButton, SniperMinimizeButton }) do
        local cPos = control.AbsolutePosition
        local cSize = control.AbsoluteSize
        if position.X >= (cPos.X - 10) and position.X <= (cPos.X + cSize.X + 10)
        and position.Y >= (cPos.Y - 10) and position.Y <= (cPos.Y + cSize.Y + 10) then
            return true
        end
    end
    local btnPos = SniperToggleButton.AbsolutePosition
    local btnSize = SniperToggleButton.AbsoluteSize
    return position.X >= (btnPos.X - 10)
    and position.X <= (btnPos.X + btnSize.X + 10)
    and position.Y >= (btnPos.Y - 10)
    and position.Y <= (btnPos.Y + btnSize.Y + 10)
end
local function stopSniperDragging(input)
    if input ~= activeDragInput then
        return
    end
    dragging = false activeDragInput = nil dragStart = nil startPosition = nil
end
SniperHeader.InputBegan:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    if dragging or isOverSniperHeaderControl(input.Position) then
        return
    end
    dragging = true activeDragInput = input dragStart = Vector2.new(input.Position.X, input.Position.Y)
    startPosition = SniperWindow.Position dragMoved = false input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End or input.UserInputState == Enum.UserInputState.Cancel then
            stopSniperDragging(input)
        end
    end)
end)
UserInputService.InputChanged:Connect(function(input)
    if not dragging or not activeDragInput then
        return
    end
    local isTrackedTouch = activeDragInput.UserInputType == Enum.UserInputType.Touch and input == activeDragInput
    local isTrackedMouse = activeDragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement
    if not isTrackedTouch and not isTrackedMouse then
        return
    end
    local current = Vector2.new(input.Position.X, input.Position.Y)
    local delta = current - dragStart
    if not dragMoved then
        if delta.Magnitude < DRAG_THRESHOLD then
            return
        end
        dragMoved = true
    end
    SniperWindow.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X,
    startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
end)
end

-- ===================== Riddle Solver UI =====================

local RiddleGUI = Instance.new("ScreenGui")
RiddleGUI.Name = "RXZRiddleUI" RiddleGUI.ResetOnSpawn = false RiddleGUI.IgnoreGuiInset = true RiddleGUI.DisplayOrder = 998
if not pcall(function()
    RiddleGUI.Parent = game.CoreGui
end) then
    RiddleGUI.Parent = playerGui
end
local RiddleWindow = Instance.new("Frame")
RiddleWindow.Name = "Window" RiddleWindow.Size = UDim2.fromOffset(340,
350)
RiddleWindow.AnchorPoint = Vector2.new(0.5, 0.5)
RiddleWindow.Position = UDim2.new(0.5,
- 170, 0.5, 0)
RiddleWindow.BackgroundColor3 = COLORS.Window RiddleWindow.BorderSizePixel = 0 RiddleWindow.ClipsDescendants = true RiddleWindow.Parent = RiddleGUI addCorner(RiddleWindow,
16)
addStroke(RiddleWindow, COLORS.Border, 1, 0.15)
local RiddleScale = Instance.new("UIScale")
RiddleScale.Name = "InterfaceScale" RiddleScale.Scale = 0.92 RiddleScale.Parent = RiddleWindow
local function updateRiddleScale()
    local camera = workspace.CurrentCamera
    if not camera then
        RiddleScale.Scale = 0.92
        return
    end
    local viewport = camera.ViewportSize
    local fitScale = math.min((viewport.X - 16) / 340, (viewport.Y - 16) / 350)
    if UserInputService.TouchEnabled then
        local mobileTarget = 0.72 RiddleScale.Scale = math.max(0.45, math.min(mobileTarget, fitScale))
    else
        RiddleScale.Scale = 0.92
    end
end
local riddleViewportConnection
local function watchRiddleViewport()
    if riddleViewportConnection then
        riddleViewportConnection:Disconnect()
        riddleViewportConnection = nil
    end
    local camera = workspace.CurrentCamera
    if camera then
        riddleViewportConnection = camera:GetPropertyChangedSignal("ViewportSize") : Connect(updateRiddleScale)
    end
    updateRiddleScale()
end
workspace:GetPropertyChangedSignal("CurrentCamera") : Connect(watchRiddleViewport)
watchRiddleViewport()
local RiddleHeader = Instance.new("Frame")
RiddleHeader.Name = "Header" RiddleHeader.Size = UDim2.new(1,
0, 0, 70)
RiddleHeader.BackgroundTransparency = 1 RiddleHeader.Active = true RiddleHeader.ZIndex = 3 RiddleHeader.Parent = RiddleWindow
local RiddleTopLine = Instance.new("Frame")
RiddleTopLine.Name = "TopLine" RiddleTopLine.Size = UDim2.new(1,
- 40, 0, 2)
RiddleTopLine.Position = UDim2.fromOffset(20, 10)
RiddleTopLine.BackgroundColor3 = COLORS.Border RiddleTopLine.BackgroundTransparency = 0.3 RiddleTopLine.BorderSizePixel = 0 RiddleTopLine.Parent = RiddleHeader addCorner(RiddleTopLine,
1)
makeLabel(RiddleHeader, "Title", "RXZ CODE Sniper", UDim2.fromOffset(220, 30), UDim2.fromOffset(20,
14), 16, COLORS.White, Enum.Font.GothamBold)
makeLabel(RiddleHeader, "Subtitle", "Riddle Solver",
UDim2.fromOffset(220, 20), UDim2.fromOffset(20, 40), 11, COLORS.Dim, Enum.Font.GothamMedium)
local RiddleToggleButton = Instance.new("TextButton")
RiddleToggleButton.Name = "MainToggle" RiddleToggleButton.Size = UDim2.fromOffset(70,
30)
RiddleToggleButton.Position = UDim2.new(1, - 80, 0.5, - 15)
RiddleToggleButton.BackgroundColor3 = savedConfig.riddleSolver and COLORS.Purple or Color3.fromRGB(35, 35, 35)
RiddleToggleButton.BorderSizePixel = 0 RiddleToggleButton.AutoButtonColor = false RiddleToggleButton.Active = true RiddleToggleButton.Text = savedConfig.riddleSolver and "ON" or "OFF" RiddleToggleButton.TextSize = 12 RiddleToggleButton.TextColor3 = savedConfig.riddleSolver and Color3.fromRGB(0, 0, 0)
    or Color3.fromRGB(140, 140, 140)
RiddleToggleButton.Font = Enum.Font.GothamBold RiddleToggleButton.ZIndex = 5 RiddleToggleButton.Parent = RiddleHeader addCorner(RiddleToggleButton,
15)
addStroke(RiddleToggleButton, COLORS.Border, 1, 0.45)
local RiddleHeaderDivider = Instance.new("Frame")
RiddleHeaderDivider.Name = "HeaderDivider" RiddleHeaderDivider.Size = UDim2.new(1,
- 40, 0, 1)
RiddleHeaderDivider.Position = UDim2.fromOffset(20, 66)
RiddleHeaderDivider.BackgroundColor3 = COLORS.Border RiddleHeaderDivider.BackgroundTransparency = 0.4 RiddleHeaderDivider.BorderSizePixel = 0 RiddleHeaderDivider.Parent = RiddleHeader
local RiddleSettings = Instance.new("Frame")
RiddleSettings.Name = "Settings" RiddleSettings.Size = UDim2.new(1,
- 20, 0, 55)
RiddleSettings.Position = UDim2.fromOffset(10, 75)
RiddleSettings.BackgroundTransparency = 1 RiddleSettings.ZIndex = 3 RiddleSettings.Parent = RiddleWindow
addSettingsBackground(RiddleSettings)
local SolvedCard = Instance.new("Frame")
SolvedCard.Name = "SolvedCard" SolvedCard.Position = UDim2.fromOffset(0,
0)
SolvedCard.Size = UDim2.fromOffset(280, 42)
SolvedCard.BackgroundColor3 = COLORS.Row SolvedCard.BackgroundTransparency = 0 SolvedCard.BorderSizePixel = 0 SolvedCard.Parent = RiddleSettings addCorner(SolvedCard,
10)
addStroke(SolvedCard, COLORS.Border, 1, 0.25)
makeLabel(SolvedCard, "Title", "Solved",
UDim2.fromOffset(150, 42), UDim2.fromOffset(15, 0), 13, COLORS.Text, Enum.Font.GothamMedium)
local SolvedCount = Instance.new("TextLabel")
SolvedCount.Name = "Count" SolvedCount.Size = UDim2.fromOffset(80,
42)
SolvedCount.Position = UDim2.new(1, - 95, 0, 0)
SolvedCount.BackgroundTransparency = 1 SolvedCount.Text = "0" SolvedCount.TextSize = 18 SolvedCount.TextColor3 = COLORS.White SolvedCount.Font = Enum.Font.GothamBold SolvedCount.TextXAlignment = Enum.TextXAlignment.Right SolvedCount.TextYAlignment = Enum.TextYAlignment.Center SolvedCount.Parent = SolvedCard
local ClearBtn = Instance.new("TextButton")
ClearBtn.Name = "ClearBtn" ClearBtn.Size = UDim2.fromOffset(50,
26)
ClearBtn.Position = UDim2.new(1, - 58, 0.5, - 13)
ClearBtn.BackgroundColor3 = COLORS.Control ClearBtn.BorderSizePixel = 0 ClearBtn.AutoButtonColor = false ClearBtn.Active = true ClearBtn.Text = "CLEAR" ClearBtn.TextSize = 10 ClearBtn.TextColor3 = COLORS.Dim ClearBtn.Font = Enum.Font.GothamBold ClearBtn.ZIndex = 5 ClearBtn.Parent = SolvedCard addCorner(ClearBtn,
10)
addStroke(ClearBtn, COLORS.Border, 1, 0.4)
local RiddleConsole = Instance.new("ScrollingFrame")
RiddleConsole.Name = "Console" RiddleConsole.Size = UDim2.new(1,
- 34, 0, 190)
RiddleConsole.Position = UDim2.fromOffset(17, 138)
RiddleConsole.BackgroundColor3 = COLORS.Log RiddleConsole.BorderSizePixel = 0 RiddleConsole.ClipsDescendants = true RiddleConsole.Active = true RiddleConsole.ScrollingEnabled = true RiddleConsole.ScrollingDirection = Enum.ScrollingDirection.Y RiddleConsole.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable RiddleConsole.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar RiddleConsole.CanvasSize = UDim2.new(0,
0, 0, 0)
RiddleConsole.AutomaticCanvasSize = Enum.AutomaticSize.None RiddleConsole.ScrollBarThickness = 6 RiddleConsole.ScrollBarImageColor3 = COLORS.Dim RiddleConsole.ZIndex = 3 RiddleConsole.Parent = RiddleWindow addCorner(RiddleConsole,
9)
addStroke(RiddleConsole, COLORS.Border, 1, 0.2)
local RiddleConsoleOutput = Instance.new("TextLabel")
RiddleConsoleOutput.Name = "ConsoleOutput" RiddleConsoleOutput.Size = UDim2.new(1,
- 18, 0, 180)
RiddleConsoleOutput.AutomaticSize = Enum.AutomaticSize.Y RiddleConsoleOutput.Position = UDim2.fromOffset(9,
6)
RiddleConsoleOutput.BackgroundTransparency = 1 RiddleConsoleOutput.RichText = true RiddleConsoleOutput.Text = '<font color="rgb(150,150,150)">waiting for codes & riddles...</font>' RiddleConsoleOutput.TextSize = 11 RiddleConsoleOutput.Font = Enum.Font.Code RiddleConsoleOutput.TextColor3 = COLORS.Dim RiddleConsoleOutput.TextXAlignment = Enum.TextXAlignment.Left RiddleConsoleOutput.TextYAlignment = Enum.TextYAlignment.Top RiddleConsoleOutput.TextWrapped = true RiddleConsoleOutput.ZIndex = 4 RiddleConsoleOutput.Parent = RiddleConsole
local RIDDLE_CONSOLE_BOTTOM_PADDING = 30
local function updateRiddleConsoleCanvas()
    if not RiddleConsole or not RiddleConsoleOutput then
        return
    end
    local contentHeight = RiddleConsoleOutput.Position.Y.Offset + RiddleConsoleOutput.AbsoluteSize.Y + RIDDLE_CONSOLE_BOTTOM_PADDING RiddleConsole.CanvasSize = UDim2.new(0,
    0, 0, contentHeight)
end
RiddleConsoleOutput:GetPropertyChangedSignal("AbsoluteSize") : Connect(updateRiddleConsoleCanvas)
task.defer(updateRiddleConsoleCanvas)
local function scrollRiddleConsoleToBottom()
    task.defer(function()
        task.wait()
        if not RiddleConsole then
            return
        end
        updateRiddleConsoleCanvas()
        local bottom = math.max(0, RiddleConsole.AbsoluteCanvasSize.Y - RiddleConsole.AbsoluteWindowSize.Y)
        RiddleConsole.CanvasPosition = Vector2.new(0,
        bottom)
    end)
end
local function appendRiddleConsoleLog(tag, message, color)
    if not RiddleConsoleOutput then
        return
    end
    local tagColors = {
        code = "rgb(255,255,255)", riddle = "rgb(255,255,255)", system = "rgb(150,150,150)", success = "rgb(255,255,255)",
        error = "rgb(120,120,120)", status = "rgb(255,255,255)",
    }
    local tagColor = tagColors [tag] or tagColors.system
    local line = '<font color="'.. tagColor.. '">['.. tag.. ']</font> <font color="'.. (color or "rgb(230,230,230)").. '">'.. message.. '</font>'
    if RiddleConsoleOutput.Text == "" then
        RiddleConsoleOutput.Text = line
    else
        RiddleConsoleOutput.Text = RiddleConsoleOutput.Text.. "\n".. line
    end
    scrollRiddleConsoleToBottom()
end
local RiddleBottomBar = Instance.new("Frame")
RiddleBottomBar.Name = "BottomBar" RiddleBottomBar.Size = UDim2.new(1,
0, 0, 28)
RiddleBottomBar.Position = UDim2.new(0, 0, 1, - 28)
RiddleBottomBar.BackgroundColor3 = COLORS.Row RiddleBottomBar.BackgroundTransparency = 0 RiddleBottomBar.BorderSizePixel = 0 RiddleBottomBar.Parent = RiddleWindow addCorner(RiddleBottomBar,
16)
RiddleBottomBar.ClipsDescendants = true
local RiddleMinimizeButton = addMinimizeButton(RiddleHeader, RiddleWindow, 70, 350, {
    RiddleSettings, RiddleConsole, RiddleBottomBar, RiddleHeaderDivider
})
makeLabel(RiddleBottomBar, "Version", "RXZ CODE Sniper v1",
UDim2.fromOffset(200, 28), UDim2.fromOffset(15, 0), 10, COLORS.Dim, Enum.Font.GothamMedium)
do
local dragging = false
local activeDragInput
local dragStart
local startPosition
local dragMoved = false
local DRAG_THRESHOLD = UserInputService.TouchEnabled and 10 or 3
local function isOverRiddleHeaderControl(position)
    for _, control in ipairs({ RiddleToggleButton, RiddleMinimizeButton }) do
        local cPos = control.AbsolutePosition
        local cSize = control.AbsoluteSize
        if position.X >= (cPos.X - 10) and position.X <= (cPos.X + cSize.X + 10)
        and position.Y >= (cPos.Y - 10) and position.Y <= (cPos.Y + cSize.Y + 10) then
            return true
        end
    end
    local btnPos = RiddleToggleButton.AbsolutePosition
    local btnSize = RiddleToggleButton.AbsoluteSize
    return position.X >= (btnPos.X - 10)
    and position.X <= (btnPos.X + btnSize.X + 10)
    and position.Y >= (btnPos.Y - 10)
    and position.Y <= (btnPos.Y + btnSize.Y + 10)
end
local function stopRiddleDragging(input)
    if input ~= activeDragInput then
        return
    end
    dragging = false activeDragInput = nil dragStart = nil startPosition = nil
end
RiddleHeader.InputBegan:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    if dragging or isOverRiddleHeaderControl(input.Position) then
        return
    end
    dragging = true activeDragInput = input dragStart = Vector2.new(input.Position.X, input.Position.Y)
    startPosition = RiddleWindow.Position dragMoved = false input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End or input.UserInputState == Enum.UserInputState.Cancel then
            stopRiddleDragging(input)
        end
    end)
end)
UserInputService.InputChanged:Connect(function(input)
    if not dragging or not activeDragInput then
        return
    end
    local isTrackedTouch = activeDragInput.UserInputType == Enum.UserInputType.Touch and input == activeDragInput
    local isTrackedMouse = activeDragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement
    if not isTrackedTouch and not isTrackedMouse then
        return
    end
    local current = Vector2.new(input.Position.X, input.Position.Y)
    local delta = current - dragStart
    if not dragMoved then
        if delta.Magnitude < DRAG_THRESHOLD then
            return
        end
        dragMoved = true
    end
    RiddleWindow.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X,
    startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
end)
end

-- ===================== Code Sniper Runtime =====================

local _enabled = savedConfig.codeSniper
local _focused = nil
local _lastBox = nil
local _autoAccept = savedConfig.autoSubmit
local _capturedParts = {
}
local _lastWatchedBox = nil
local _boxTextConn = nil
local _boxAncestryConn = nil
local _boxVisibilityConns = {
}
local ACE_WORD_COUNT = 1
local _isRedeeming = false
local function getSubmitAfter()
    return savedConfig.submitAfter
end
local function resetPasteCounter()
    _capturedParts = {
    }
end
local function clearBoxWatchers()
    if _boxTextConn then
        pcall(function()
            _boxTextConn:Disconnect()
        end)
    end
    if _boxAncestryConn then
        pcall(function()
            _boxAncestryConn:Disconnect()
        end)
    end
    for _, connection in ipairs(_boxVisibilityConns)
    do
    pcall(function()
        connection:Disconnect()
    end)
end
_boxTextConn = nil _boxAncestryConn = nil _boxVisibilityConns = {
}
_lastWatchedBox = nil
end
local function watchBoxForBlankReset(box)
    if not box or _lastWatchedBox == box then
        return
    end
    clearBoxWatchers()
    _lastWatchedBox = box _boxTextConn = box:GetPropertyChangedSignal("Text") : Connect(function()
        if box.Text == "" then
            resetPasteCounter()
            _capturedParts = {
            }
        end
    end)
    _boxAncestryConn = box.AncestryChanged:Connect(function(_, parent)
        if not parent then
            resetPasteCounter()
            _capturedParts = {
            }
            clearBoxWatchers()
        end
    end)
end
UserInputService.TextBoxFocused:Connect(function(box)
    if box:IsDescendantOf(SniperGUI)
    or box:IsDescendantOf(RiddleGUI) then
        return
    end
    if box ~= aceCodeBox() then
        return
    end
    _focused = box _lastBox = box watchBoxForBlankReset(box)
end)
UserInputService.TextBoxFocusReleased:Connect(function(box)
    if box:IsDescendantOf(SniperGUI)
    or box:IsDescendantOf(RiddleGUI) then
        return
    end
    if _focused == box then
        _focused = nil
    end
end)
function appendToBox(text)
    if not text or text == "" then
        return
    end
    if _isRedeeming then
        return
    end
    if _lastWatchedBox and not isVisibleChain(_lastWatchedBox) then
        resetPasteCounter()
        clearBoxWatchers()
        _capturedParts = {
        }
    end
    local box = aceCodeBox()
    _capturedParts [# _capturedParts + 1] = text
    local combinedCode = table.concat(_capturedParts)
    local capturedCount = # _capturedParts
    local targetCount = savedConfig.submitAfter
    if box then
        _lastBox = box watchBoxForBlankReset(box)
        local boxWasFocused = UserInputService:GetFocusedTextBox() == box box.Text = combinedCode
        if boxWasFocused then
            pcall(function()
                local caretEnd = # combinedCode + 1 box.CursorPosition = caretEnd box.SelectionStart = caretEnd
            end)
        end
    else
        return
    end
    appendRiddleConsoleLog("status", "Pasted ".. tostring(capturedCount).. "/".. tostring(targetCount),
    "rgb(255,255,255)")
    appendRiddleConsoleLog("code", combinedCode, "rgb(255,255,255)")
    if capturedCount >= targetCount then
        _isRedeeming = true
        local codeToRedeem = combinedCode resetPasteCounter()
        clearBoxWatchers()
        _capturedParts = {
        }
        if _autoAccept then
            appendRiddleConsoleLog("status", "🚀 Redeeming: ".. codeToRedeem, "rgb(255,255,255)")
            local ok, statusMsg = typeAndSubmitCode(codeToRedeem)
            if ok then
                appendRiddleConsoleLog("success", "✅ Successfully redeemed: ".. codeToRedeem, "rgb(255,255,255)")
            else
                appendRiddleConsoleLog("error", "❌ Failed to redeem: ".. codeToRedeem.. " - ".. tostring(statusMsg),
                "rgb(120,120,120)")
            end
        end
        _isRedeeming = false
    end
end

-- ===================== Notification Remote Hook =====================

local function resolveNotifyRemote()
    if _G.PhiNotifyRemote then
        return _G.PhiNotifyRemote
    end
    local Net = ReplicatedStorage:WaitForChild("Packages") : WaitForChild("Net")
    local getinfo = debug and(debug.getinfo or debug.info)
    if getgc and getinfo and getconnections then
        for _, d in ipairs(Net:GetDescendants())
        do
        if d:IsA("RemoteEvent") then
            local ok, cs = pcall(getconnections, d.OnClientEvent)
            if ok then
                for _, c in ipairs(cs)
                do
                local f, fn = pcall(function()
                    return c.Function
                end)
                if f and type(fn) == "function" then
                    local i, info = pcall(getinfo, fn)
                    if i and tostring(info.short_src or info.source or "") : find("NotificationController", 1,
                    true) then
                        return d
                    end
                end
            end
        end
    end
end
end
return nil
end
local function aceStripRich(text)
    if type(text) ~= "string" then
        return tostring(text)
    end
    return(text:gsub("<[^>]->", ""))
end
local function aceTokenize(text)
    local words = {
    }
    for word in text:gmatch("[%w_]+")
    do
    words [# words + 1] = word
end
return words
end
local aceCollectBuffer = {
}
local function onAceAnnouncement(...)
    local text = aceStripRich(tostring((...)
    or ""))
    text = text:match("^%s*(.-)%s*$")
    or ""
    if text == "" then
        return
    end
    local isCode = text:match("^[A-Z0-9_]+$") and not text:find("%s")
    if not isCode then
        return
    end
    for _, word in ipairs(aceTokenize(text))
    do
    aceCollectBuffer [# aceCollectBuffer + 1] = word
end
local parts = {
}
for index = 1, math.min(# aceCollectBuffer, ACE_WORD_COUNT)
do
parts [index] = aceCollectBuffer [index]
end
if # aceCollectBuffer < ACE_WORD_COUNT then
    return
end
aceCollectBuffer = {
}
local captured = table.concat(parts)
if captured == "" then
    return
end
appendRiddleConsoleLog("code", "detected: ".. captured, "rgb(255,255,255)")
appendToBox(captured)
end
local aceNotifyRemote = resolveNotifyRemote()
local aceListenConnection
if aceNotifyRemote then
    if getgenv then
        local previous = getgenv().RXZCodeSniperNotifyConnection
        if previous then
            pcall(function()
                previous:Disconnect()
            end)
        end
    end
    aceListenConnection = aceNotifyRemote.OnClientEvent:Connect(function(...)
        if not _enabled then
            return
        end
        pcall(onAceAnnouncement,...)
    end)
    if getgenv then
        getgenv().RXZCodeSniperNotifyConnection = aceListenConnection
    end
end

-- ===================== Riddle Listener =====================

local riddleListenConnection = nil
local riddleSolving = false
local riddleSolvedCount = 0
local function onRiddleAnnouncement(...)
    if not savedConfig.riddleSolver then
        return
    end
    local text = stripRich(tostring((...)
    or ""))
    if text == "" or riddleSolving then
        return
    end
    local isCode = text:match("^[A-Z0-9_]+$") and not text:find("%s")
    if isCode then
        return
    end
    riddleSolving = true task.spawn(function()
        appendRiddleConsoleLog("riddle", "solving: ".. text:sub(1, 30).. (text:len() > 30 and "..." or ""),
        "rgb(255,255,255)")
        local answer, thinking, errMsg = solveRiddle(text, function(msg)
        end)
        if answer then
            answer = answer:upper() : gsub("%s+", "")
            appendRiddleConsoleLog("riddle", "answer: ".. answer,
            "rgb(255,255,255)")
            local success, msg = submitRiddleAnswer(answer)
            if success then
                riddleSolvedCount = riddleSolvedCount + 1 SolvedCount.Text = tostring(riddleSolvedCount)
                appendRiddleConsoleLog("success",
                "✅ Successfully redeemed: ".. answer, "rgb(255,255,255)")
            else
                appendRiddleConsoleLog("error", "❌ Failed to redeem: ".. answer.. " - ".. msg, "rgb(120,120,120)")
            end
        else
            appendRiddleConsoleLog("riddle", text:sub(1, 30).. (text:len() > 30 and "..." or "").. " -> failed: ".. (errMsg or "unknown"),
            "rgb(120,120,120)")
        end
        riddleSolving = false
    end)
end
local function startRiddleSolver()
    if riddleListenConnection then
        return
    end
    local function resolveRiddleNotifyRemote()
        local ok, controller = pcall(function()
            if not ReplicatedStorage then
                return
            end
            local controllers = ReplicatedStorage:FindFirstChild("Controllers")
            local notification = controllers and controllers:FindFirstChild("NotificationController", true)
            if notification then
                return require(notification)
            end
        end)
        if ok and type(controller) == "table" and type(controller.Start) == "function" and typeof(getupvalues) == "function" then
            local valuesOk, values = pcall(getupvalues, controller.Start)
            if valuesOk and type(values) == "table" then
                for _, value in pairs(values)
                do
                if typeof(value) == "Instance" and(value:IsA("RemoteEvent")
                or value:IsA("RemoteFunction")
                or value:IsA("UnreliableRemoteEvent")) then
                    return value
                end
            end
        end
    end
    return nil
end
local notifyRemote = resolveRiddleNotifyRemote()
if notifyRemote and(notifyRemote:IsA("RemoteEvent")
or notifyRemote:IsA("UnreliableRemoteEvent")) then
    riddleListenConnection = notifyRemote.OnClientEvent:Connect(function(...)
        if looksLikeAnnouncement(...) then
            pcall(onRiddleAnnouncement,...)
        end
    end)
    appendRiddleConsoleLog("system", "riddle solver started - listening", "rgb(150,150,150)")
else
    appendRiddleConsoleLog("error", "could not find notification remote", "rgb(120,120,120)")
end
end
local function stopRiddleSolver()
    if riddleListenConnection then
        pcall(function()
            riddleListenConnection:Disconnect()
        end)
        riddleListenConnection = nil
    end
    appendRiddleConsoleLog("system", "riddle solver stopped", "rgb(150,150,150)")
end

-- ===================== Toggle Handlers =====================

local lastSniperToggle = 0
local function sniperToggleAction()
    if tick() - lastSniperToggle < 0.15 then
        return
    end
    lastSniperToggle = tick()
    _enabled = not _enabled savedConfig.codeSniper = _enabled saveConfig()
    _capturedParts = {
    }
    _isRedeeming = false resetPasteCounter()
    clearBoxWatchers()
    SniperToggleButton.BackgroundColor3 = _enabled and COLORS.Purple or Color3.fromRGB(35, 35, 35)
    SniperToggleButton.Text = _enabled and "ON" or "OFF" SniperToggleButton.TextColor3 = _enabled and Color3.fromRGB(0, 0, 0)
    or Color3.fromRGB(140, 140, 140)
    appendRiddleConsoleLog("system", "code sniper ".. (_enabled and "enabled" or "disabled"),
    "rgb(150,150,150)")
end
SniperToggleButton.MouseButton1Click:Connect(sniperToggleAction)
SniperToggleButton.Activated:Connect(sniperToggleAction)
SniperToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        sniperToggleAction()
    end
end)
local lastRiddleToggle = 0
local function riddleToggleAction()
    if tick() - lastRiddleToggle < 0.15 then
        return
    end
    lastRiddleToggle = tick()
    savedConfig.riddleSolver = not savedConfig.riddleSolver saveConfig()
    RiddleToggleButton.BackgroundColor3 = savedConfig.riddleSolver and COLORS.Purple or Color3.fromRGB(35, 35, 35)
    RiddleToggleButton.Text = savedConfig.riddleSolver and "ON" or "OFF" RiddleToggleButton.TextColor3 = savedConfig.riddleSolver and Color3.fromRGB(0, 0, 0)
    or Color3.fromRGB(140, 140, 140)
    if savedConfig.riddleSolver then
        startRiddleSolver()
    else
        stopRiddleSolver()
    end
end
RiddleToggleButton.MouseButton1Click:Connect(riddleToggleAction)
RiddleToggleButton.Activated:Connect(riddleToggleAction)
RiddleToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        riddleToggleAction()
    end
end)
ClearBtn.MouseButton1Click:Connect(function()
    riddleSolvedCount = 0 SolvedCount.Text = "0" _capturedParts = {
    }
    _isRedeeming = false resetPasteCounter()
    clearBoxWatchers()
    if RiddleConsoleOutput then
        RiddleConsoleOutput.Text = '<font color="rgb(150,150,150)">console cleared</font>' scrollRiddleConsoleToBottom()
    end
end)
if savedConfig.riddleSolver then
    task.wait(1)
    startRiddleSolver()
end
if getgenv then
    getgenv().StopRXZScript = function()
        if aceListenConnection then
            pcall(function()
                aceListenConnection:Disconnect()
            end)
            aceListenConnection = nil
        end
        if getgenv().RXZCodeSniperNotifyConnection then
            pcall(function()
                getgenv().RXZCodeSniperNotifyConnection:Disconnect()
            end)
            getgenv().RXZCodeSniperNotifyConnection = nil
        end
        stopRiddleSolver()
        if SniperGUI then
            SniperGUI:Destroy()
        end
        if RiddleGUI then
            RiddleGUI:Destroy()
        end
    end
    getgenv().StopRXZ = getgenv().StopRXZScript
    getgenv().StopRXZ = getgenv().StopRXZScript
end

