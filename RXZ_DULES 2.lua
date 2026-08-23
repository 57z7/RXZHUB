local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local HS = game:GetService("HttpService")
local player = Players.LocalPlayer

-- Master table
local M = {}

-- ------------------------------------------------------------
-- EARLY CONFIG LOAD (CherryConfig)
-- ------------------------------------------------------------
M.introSoundEnabled = true
M.introSongChoice = 3
M.introGUIEnabled = true
if isfile and isfile("CherryConfig.json") then
    local ok, data = pcall(function() return HS:JSONDecode(readfile("CherryConfig.json")) end)
    if ok and type(data) == "table" then
        if data.introSoundEnabled ~= nil then M.introSoundEnabled = data.introSoundEnabled end
        if data.introSongChoice then M.introSongChoice = data.introSongChoice end
        if data.introGUIEnabled ~= nil then M.introGUIEnabled = data.introGUIEnabled end
    end
end

-- ============================================================
-- RXZ HUB INTRO (custom)
-- ============================================================
if M.introGUIEnabled then
    local okIntro, introErr = pcall(function()
do
--============================================================
-- SHADOW.VS INTRO
-- YOUR ORIGINAL VERSION
-- RANDOM IMAGE + MUSIC + BEAT EFFECTS + SKIP
--============================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

--============================================================
-- SETTINGS
--============================================================

local MUSIC_URL =
	"https://files.catbox.moe/qhpfe5.mp3"

local MUSIC_FILE =
	"RXZ_Music.mp3"

local MUSIC_VOLUME =
	0.75

local BPM =
	100

local BEAT =
	60 / BPM

-- IMAGE 2 FIRST
-- IMAGE 1 SECOND
-- THEN RANDOM WITHOUT REPEATING
local IMAGES = {
	"rbxassetid://112701306083078"
}

--============================================================
-- CLEAN OLD
--============================================================

for _, name in ipairs({
	"RXZIntro"
}) do

	local old =
		PlayerGui:FindFirstChild(name)

	if old then
		old:Destroy()
	end

end

--============================================================
-- IMAGE ORDER
--============================================================

local lastImage =
	shared.ShadowVS_LastImage

local imageIndex

-- RXZ currently has one image, so never select a missing image #2.
if #IMAGES == 1 then
	imageIndex = 1
elseif not shared.ShadowVS_Run then

	shared.ShadowVS_Run =
		1

	imageIndex =
		2

elseif shared.ShadowVS_Run == 1 then

	shared.ShadowVS_Run =
		2

	imageIndex =
		1

else

	local choices = {}

	for i = 1, #IMAGES do

		if i ~= lastImage then
			table.insert(
				choices,
				i
			)
		end

	end

	imageIndex =
		choices[
			math.random(
				1,
				#choices
			)
		]

end

shared.ShadowVS_LastImage =
	imageIndex

local IMAGE_ID =
	IMAGES[imageIndex]

--============================================================
-- INTRO STATE
--============================================================

local introActive =
	true

local introFinished =
	false

local introSound =
	nil

--============================================================
-- GUI
--============================================================

local gui =
	Instance.new("ScreenGui")

gui.Name =
	"RXZIntro"

gui.IgnoreGuiInset =
	true

gui.ResetOnSpawn =
	false

gui.DisplayOrder =
	999999

gui.ZIndexBehavior =
	Enum.ZIndexBehavior.Sibling

gui.Parent =
	PlayerGui

--============================================================
-- BACKGROUND
--============================================================

local background =
	Instance.new("Frame")

background.Size =
	UDim2.fromScale(
		1,
		1
	)

background.BackgroundColor3 =
	Color3.fromRGB(
		0,
		0,
		0
	)

background.BorderSizePixel =
	0

background.ClipsDescendants =
	true

background.Parent =
	gui

--============================================================
-- IMAGE
--============================================================

local image =
	Instance.new("ImageLabel")

image.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

image.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

image.Size =
	UDim2.fromScale(
		1.08,
		1.08
	)

image.BackgroundTransparency =
	1

image.Image =
	IMAGE_ID

image.ImageTransparency =
	1

image.ScaleType =
	Enum.ScaleType.Crop

image.ZIndex =
	1

image.Parent =
	background

--============================================================
-- DARK OVERLAY
--============================================================

local dark =
	Instance.new("Frame")

dark.Size =
	UDim2.fromScale(
		1,
		1
	)

dark.BackgroundColor3 =
	Color3.fromRGB(
		0,
		0,
		0
	)

dark.BackgroundTransparency =
	0.25

dark.BorderSizePixel =
	0

dark.ZIndex =
	2

dark.Parent =
	background

--============================================================
-- SKIP INTRO BUTTON
--============================================================

local skip =
	Instance.new("TextButton")

skip.AnchorPoint =
	Vector2.new(
		1,
		0
	)

skip.Position =
	UDim2.new(
		1,
		-14,
		0,
		14
	)

skip.Size =
	UDim2.fromOffset(
		105,
		36
	)

skip.BackgroundColor3 =
	Color3.fromRGB(
		15,
		15,
		18
	)

skip.BackgroundTransparency =
	0.15

skip.BorderSizePixel =
	0

skip.Text =
	"SKIP INTRO"

skip.TextColor3 =
	Color3.fromRGB(
		255,
		255,
		255
	)

skip.TextSize =
	12

skip.Font =
	Enum.Font.GothamBold

skip.AutoButtonColor =
	false

skip.ZIndex =
	500

skip.Parent =
	gui

local skipCorner =
	Instance.new("UICorner")

skipCorner.CornerRadius =
	UDim.new(
		0,
		7
	)

skipCorner.Parent =
	skip

local skipStroke =
	Instance.new("UIStroke")

skipStroke.Color =
	Color3.fromRGB(
		255,
		255,
		255
	)

skipStroke.Transparency =
	0.75

skipStroke.Thickness =
	1

skipStroke.Parent =
	skip

--============================================================
-- FLASH
--============================================================

local flash =
	Instance.new("Frame")

flash.Size =
	UDim2.fromScale(
		1,
		1
	)

flash.BackgroundColor3 =
	Color3.fromRGB(
		255,
		255,
		255
	)

flash.BackgroundTransparency =
	1

flash.BorderSizePixel =
	0

flash.ZIndex =
	400

flash.Parent =
	gui

--============================================================
-- TITLE
--============================================================

local introTitle =
	Instance.new("TextLabel")

introTitle.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

introTitle.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

introTitle.Size =
	UDim2.fromScale(
		1.1,
		0.22
	)

introTitle.BackgroundTransparency =
	1

introTitle.Text =
	"RXZ HUB"

introTitle.TextColor3 =
	Color3.fromRGB(
		255,
		255,
		255
	)

introTitle.TextTransparency =
	1

introTitle.TextScaled =
	true

introTitle.Font =
	Enum.Font.GothamBlack

introTitle.ZIndex =
	20

introTitle.Parent =
	background

local titleStroke =
	Instance.new("UIStroke")

titleStroke.Color =
	Color3.fromRGB(
		0,
		0,
		0
	)

titleStroke.Thickness =
	3

titleStroke.Transparency =
	1

titleStroke.Parent =
	introTitle

--============================================================
-- SUBTITLE
--============================================================

local introSubtitle =
	Instance.new("TextLabel")

introSubtitle.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

introSubtitle.Position =
	UDim2.fromScale(
		0.5,
		0.59
	)

introSubtitle.Size =
	UDim2.fromScale(
		0.6,
		0.05
	)

introSubtitle.BackgroundTransparency =
	1

introSubtitle.Text =
	"FREE SCRIPT #1"

introSubtitle.TextColor3 =
	Color3.fromRGB(
		205,
		205,
		205
	)

introSubtitle.TextTransparency =
	1

introSubtitle.TextScaled =
	true

introSubtitle.Font =
	Enum.Font.GothamBold

introSubtitle.ZIndex =
	20

introSubtitle.Parent =
	background

--============================================================
-- MUSIC LOADER
--============================================================

local function loadMusic()

	local asset

	pcall(function()

		if isfile and
			isfile(MUSIC_FILE) then

			asset =
				getcustomasset(
					MUSIC_FILE
				)

		end

	end)

	if not asset then

		local success, data =
			pcall(function()

				return game:HttpGet(
					MUSIC_URL
				)

			end)

		if success and
			data and
			#data > 1000 then

			pcall(function()

				writefile(
					MUSIC_FILE,
					data
				)

			end)

			pcall(function()

				asset =
					getcustomasset(
						MUSIC_FILE
					)

			end)

		end

	end

	return asset

end

--============================================================
-- PLAY MUSIC
--============================================================

task.spawn(function()

	local asset =
		loadMusic()

	if not asset or
		not introActive then
		return
	end

	introSound =
		Instance.new("Sound")

	introSound.Name =
		"ShadowVSIntroMusic"

	introSound.SoundId =
		asset

	introSound.Volume =
		MUSIC_VOLUME

	introSound.Looped =
		false

	introSound.Parent =
		SoundService

	pcall(function()
		introSound:Play()
	end)

end)

--============================================================
-- FINISH
--============================================================

local function finishIntro()

	if introFinished then
		return
	end

	introFinished =
		true

	introActive =
		false

	if introSound then

		pcall(function()

			TweenService:Create(
				introSound,
				TweenInfo.new(
					0.35
				),
				{
					Volume = 0
				}
			):Play()

		end)

		task.delay(
			0.4,
			function()

				pcall(function()

					introSound:Stop()
					introSound:Destroy()

				end)

			end
		)

	end

	pcall(function()
		gui:Destroy()
	end)

end

--============================================================
-- SKIP
--============================================================

skip.MouseButton1Click:Connect(
	finishIntro
)

--============================================================
-- SKIP HOVER
--============================================================

skip.MouseEnter:Connect(function()

	TweenService:Create(
		skip,
		TweenInfo.new(
			0.12
		),
		{
			BackgroundColor3 =
				Color3.fromRGB(
					55,
					55,
					60
				)
		}
	):Play()

end)

skip.MouseLeave:Connect(function()

	TweenService:Create(
		skip,
		TweenInfo.new(
			0.12
		),
		{
			BackgroundColor3 =
				Color3.fromRGB(
					15,
					15,
					18
				)
		}
	):Play()

end)

--============================================================
-- IMAGE FADE IN
--============================================================

TweenService:Create(
	image,
	TweenInfo.new(
		1.1,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	),
	{
		ImageTransparency =
			0
	}
):Play()

--============================================================
-- SLOW ZOOM
--============================================================

TweenService:Create(
	image,
	TweenInfo.new(
		18,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.InOut
	),
	{
		Size =
			UDim2.fromScale(
				1.18,
				1.18
			)
	}
):Play()

--============================================================
-- BEAT FLASH
--============================================================

task.spawn(function()

	while introActive
		and gui.Parent do

		flash.BackgroundTransparency =
			0.8

		TweenService:Create(
			flash,
			TweenInfo.new(
				0.12,
				Enum.EasingStyle.Quint,
				Enum.EasingDirection.Out
			),
			{
				BackgroundTransparency =
					1
			}
		):Play()

		task.wait(
			BEAT
		)

	end

end)

--============================================================
-- TITLE
--============================================================

task.wait(1.5)

if not introActive then
	return
end

TweenService:Create(
	introTitle,
	TweenInfo.new(
		0.7,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	),
	{
		Size =
			UDim2.fromScale(
				0.9,
				0.18
			),

		TextTransparency =
			0
	}
):Play()

TweenService:Create(
	titleStroke,
	TweenInfo.new(
		0.5
	),
	{
		Transparency =
			0
	}
):Play()

--============================================================
-- TITLE SHAKE
--============================================================

task.wait(1)

for i = 1, 18 do

	if not introActive then
		return
	end

	introTitle.Position =
		UDim2.fromScale(
			0.5 +
				math.random(
					-8,
					8
				) / 1000,

			0.5 +
				math.random(
					-8,
					8
				) / 1000
		)

	task.wait(
		0.025
	)

end

introTitle.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

--============================================================
-- SUBTITLE
--============================================================

TweenService:Create(
	introSubtitle,
	TweenInfo.new(
		0.6,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	),
	{
		TextTransparency =
			0
	}
):Play()

--============================================================
-- HOLD
--============================================================

task.wait(7)

if not introActive then
	return
end

--============================================================
-- FINAL BEAT FLASHES
--============================================================

for i = 1, 14 do

	if not introActive then
		return
	end

	flash.BackgroundTransparency =
		0

	task.wait(
		0.025
	)

	flash.BackgroundTransparency =
		1

	task.wait(
		0.065
	)

end

--============================================================
-- EXTRA HOLD
--============================================================

task.wait(2)

if not introActive then
	return
end

--============================================================
-- TITLE FADE
--============================================================

TweenService:Create(
	introTitle,
	TweenInfo.new(
		1.2,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.In
	),
	{
		TextTransparency =
			1
	}
):Play()

TweenService:Create(
	introSubtitle,
	TweenInfo.new(
		1,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.In
	),
	{
		TextTransparency =
			1
	}
):Play()

TweenService:Create(
	titleStroke,
	TweenInfo.new(
		1
	),
	{
		Transparency =
			1
	}
):Play()

--============================================================
-- IMAGE FADE
--============================================================

TweenService:Create(
	image,
	TweenInfo.new(
		1.5,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.In
	),
	{
		ImageTransparency =
			1
	}
):Play()

TweenService:Create(
	dark,
	TweenInfo.new(
		1.5
	),
	{
		BackgroundTransparency =
			1
	}
):Play()

--============================================================
-- MUSIC FADE
--============================================================

if introSound and
	introSound.Parent then

	TweenService:Create(
		introSound,
		TweenInfo.new(
			1.5,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.In
		),
		{
			Volume =
				0
		}
	):Play()

end

--============================================================
-- FINAL BLACK FADE
--============================================================

local finalFade =
	Instance.new("Frame")

finalFade.Size =
	UDim2.fromScale(
		1,
		1
	)

finalFade.BackgroundColor3 =
	Color3.fromRGB(
		0,
		0,
		0
	)

finalFade.BackgroundTransparency =
	1

finalFade.BorderSizePixel =
	0

finalFade.ZIndex =
	1000

finalFade.Parent =
	gui

TweenService:Create(
	finalFade,
	TweenInfo.new(
		1.5,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.In
	),
	{
		BackgroundTransparency =
			0
	}
):Play()

task.wait(
	1.6
)

finishIntro()

end
    end)
    if not okIntro then warn("[RXZ] intro: "..tostring(introErr)) end
end

repeat task.wait() until game:IsLoaded()

-- ============================================================
-- THEME COLORS (Blue Accent)
-- ============================================================
local BLUE = Color3.fromRGB(255, 255, 255)
local DARK_BLUE = Color3.fromRGB(0, 50, 150)
local CHERRY_ACCENT = BLUE

-- ============================================================
-- SKY THEME (unchanged)
-- ============================================================
M.CANDY_SKY_TAG = "MoveeSkyTheme"
M.currentSkyTheme = "Night"
M.CANDY_SKY_PRESETS = {
    ["Off"]={kind="off"},
    ["Night"]={clock=22,brightness=2,ambient={110,100,130},outAmb={120,110,140},sky={stars=4000,moon=18,sun=0,moonTex=true},atm={dens=0.45,color={120,60,180},decay={60,20,100},glare=0.5,haze=1.2}},
    ["Aurora"]={clock=14,brightness=3,ambient={150,120,150},outAmb={160,130,150},atm={dens=0.55,color={255,80,200},decay={255,20,150},glare=2.5,haze=3},clouds={cover=0.7,dens=0.7,color={255,240,250}}},
    ["Sunset"]={clock=17.2,brightness=2.5,ambient={170,120,100},outAmb={180,130,110},sky={stars=0,sun=25,moon=0},atm={dens=0.5,color={255,130,60},decay={255,80,30},glare=2,haze=2.5},clouds={cover=0.55,dens=0.55,color={255,200,140}}},
    ["Galaxy"]={clock=0,brightness=1.5,ambient={70,60,100},outAmb={80,70,110},sky={stars=10000,moon=30,sun=0},atm={dens=0.15,color={40,20,80},decay={20,10,50},glare=0.3,haze=0.5}},
    ["Cyber"]={clock=21,brightness=2.2,ambient={90,130,170},outAmb={100,140,180},sky={stars=2000,moon=12},atm={dens=0.4,color={0,200,255},decay={150,0,255},glare=2,haze=2},clouds={cover=0.4,dens=0.6,color={100,200,255}}},
    ["Sakura"]={clock=11,brightness=3.5,ambient={170,150,160},outAmb={180,160,170},sky={sun=8},atm={dens=0.3,color={255,200,220},decay={255,170,200},glare=1,haze=1.5},clouds={cover=0.6,dens=0.4,color={255,250,252}}},
    ["Pink Night"]={clock=23,brightness=2.2,ambient={120,60,110},outAmb={140,70,120},sky={stars=5000,moon=22,sun=0,moonTex=true},atm={dens=0.5,color={255,80,180},decay={140,30,100},glare=0.7,haze=1.4},clouds={cover=0.3,dens=0.5,color={180,90,150}}},
    ["Blood Moon"]={clock=22.5,brightness=1.6,ambient={130,40,40},outAmb={150,50,50},sky={stars=1500,moon=28,sun=0,moonTex=true},atm={dens=0.6,color={220,30,30},decay={120,10,10},glare=1.4,haze=2},clouds={cover=0.5,dens=0.7,color={120,30,30}}},
    ["Emerald Dawn"]={clock=6.5,brightness=2.8,ambient={130,170,140},outAmb={140,180,150},sky={sun=18,moon=0,stars=0},atm={dens=0.4,color={80,200,140},decay={40,150,90},glare=1.8,haze=2.2},clouds={cover=0.5,dens=0.5,color={200,255,220}}},
    ["Volcanic"]={clock=19,brightness=2,ambient={180,80,40},outAmb={200,90,50},sky={stars=200,sun=12,moon=0},atm={dens=0.75,color={255,60,0},decay={180,20,0},glare=3,haze=3.5},clouds={cover=0.8,dens=0.9,color={120,40,20}}},
    ["Arctic"]={clock=9,brightness=3.2,ambient={200,220,235},outAmb={210,230,245},sky={sun=10,stars=0,moon=0},atm={dens=0.3,color={180,220,255},decay={140,200,240},glare=1.5,haze=1.8},clouds={cover=0.7,dens=0.6,color={250,253,255}}},
    ["Midnight Ocean"]={clock=1.5,brightness=1.7,ambient={60,90,130},outAmb={70,100,140},sky={stars=6000,moon=24,sun=0,moonTex=true},atm={dens=0.5,color={20,60,140},decay={10,30,90},glare=0.6,haze=1.5}},
    ["Vaporwave"]={clock=19.5,brightness=2.4,ambient={180,120,200},outAmb={190,130,210},sky={stars=1000,moon=14},atm={dens=0.45,color={255,100,220},decay={120,60,255},glare=2.2,haze=2.4},clouds={cover=0.55,dens=0.55,color={200,150,255}}},
    ["Toxic"]={clock=13,brightness=2.5,ambient={140,180,80},outAmb={150,190,90},atm={dens=0.55,color={100,220,40},decay={60,150,20},glare=1.8,haze=2.6},clouds={cover=0.65,dens=0.7,color={180,255,120}}},
    ["Solar Eclipse"]={clock=12,brightness=0.9,ambient={50,40,60},outAmb={60,50,70},sky={stars=3500,sun=22,moon=0},atm={dens=0.5,color={255,140,40},decay={30,20,40},glare=2.8,haze=1.8}},
    ["Hellscape"]={clock=18,brightness=1.8,ambient={200,60,30},outAmb={220,70,40},sky={stars=100,sun=30,moon=0},atm={dens=0.85,color={255,30,0},decay={120,0,0},glare=3.5,haze=4},clouds={cover=0.95,dens=0.95,color={80,20,10}}},
    ["Heaven"]={clock=12,brightness=4,ambient={240,235,210},outAmb={250,245,220},sky={sun=16,moon=0,stars=0},atm={dens=0.25,color={255,250,220},decay={255,240,200},glare=3,haze=1.5},clouds={cover=0.85,dens=0.5,color={255,255,255}}},
    ["Storm"]={clock=15,brightness=1.4,ambient={90,90,110},outAmb={100,100,120},sky={stars=0,sun=6,moon=0},atm={dens=0.65,color={80,90,120},decay={40,50,80},glare=0.5,haze=3},clouds={cover=0.95,dens=0.95,color={60,65,80}}},
    ["Sunrise"]={clock=6.2,brightness=2.8,ambient={220,180,130},outAmb={230,190,140},sky={sun=22,stars=0,moon=0},atm={dens=0.45,color={255,180,100},decay={255,140,80},glare=2.4,haze=2.2},clouds={cover=0.4,dens=0.4,color={255,220,180}}},
    ["Deep Space"]={clock=0,brightness=1,ambient={30,25,50},outAmb={40,35,60},sky={stars=15000,moon=0,sun=0},atm={dens=0.08,color={15,5,40},decay={5,0,20},glare=0.2,haze=0.3}},
    ["Lavender Dream"]={clock=18.5,brightness=2.6,ambient={180,160,220},outAmb={190,170,230},sky={stars=800,moon=16,sun=0},atm={dens=0.4,color={200,160,255},decay={160,120,220},glare=1.4,haze=1.8},clouds={cover=0.55,dens=0.5,color={220,200,255}}},
    ["Inferno"]={clock=17.5,brightness=2.2,ambient={220,100,40},outAmb={235,110,50},sky={sun=26,moon=0,stars=0},atm={dens=0.6,color={255,90,20},decay={200,40,0},glare=3,haze=3.2},clouds={cover=0.7,dens=0.7,color={200,80,40}}},
    ["Mint Sky"]={clock=10,brightness=3.2,ambient={180,230,210},outAmb={190,240,220},sky={sun=10},atm={dens=0.32,color={150,255,210},decay={100,220,180},glare=1.6,haze=1.6},clouds={cover=0.55,dens=0.45,color={240,255,250}}},
}
M.SkyOrder = {"Off","Night","Aurora","Sunset","Galaxy","Cyber","Sakura","Pink Night","Blood Moon","Emerald Dawn","Volcanic","Arctic","Midnight Ocean","Vaporwave","Toxic","Solar Eclipse","Hellscape","Heaven","Storm","Sunrise","Deep Space","Lavender Dream","Inferno","Mint Sky"}

local function candyColor(rgb) return Color3.fromRGB(rgb[1],rgb[2],rgb[3]) end
function M.CandyApplyCustomSky(mode)
    for _,child in ipairs(Lighting:GetChildren()) do if child:GetAttribute(M.CANDY_SKY_TAG) then pcall(function() child:Destroy() end) end end
    local terrain=workspace:FindFirstChildOfClass("Terrain")
    if terrain then for _,child in ipairs(terrain:GetChildren()) do if child:GetAttribute(M.CANDY_SKY_TAG) then pcall(function() child:Destroy() end) end end end
    local preset=M.CANDY_SKY_PRESETS[mode]
    if not preset or preset.kind=="off" then Lighting.ClockTime=14;Lighting.Brightness=2;Lighting.OutdoorAmbient=Color3.fromRGB(127,127,127);Lighting.Ambient=Color3.fromRGB(127,127,127);Lighting.FogEnd=100000;Lighting.GlobalShadows=true;return end
    Lighting.FogStart=0;Lighting.FogEnd=100000;Lighting.FogColor=Color3.fromRGB(200,200,200);Lighting.ColorShift_Top=Color3.fromRGB(0,0,0);Lighting.ColorShift_Bottom=Color3.fromRGB(0,0,0);Lighting.GlobalShadows=true
    Lighting.ClockTime=preset.clock or 14;Lighting.Brightness=preset.brightness or 2
    if preset.outAmb then Lighting.OutdoorAmbient=candyColor(preset.outAmb) end
    if preset.ambient then Lighting.Ambient=candyColor(preset.ambient) end
    if preset.sky then
        local skyInst=Instance.new("Sky");skyInst:SetAttribute(M.CANDY_SKY_TAG,true)
        if preset.sky.stars then skyInst.StarCount=preset.sky.stars end
        if preset.sky.moon then skyInst.MoonAngularSize=preset.sky.moon end
        if preset.sky.sun then skyInst.SunAngularSize=preset.sky.sun end
        if preset.sky.moonTex then skyInst.MoonTextureId="rbxasset://sky/moon.jpg" end
        skyInst.Parent=Lighting
    end
    if preset.atm then
        local atm=Instance.new("Atmosphere");atm:SetAttribute(M.CANDY_SKY_TAG,true)
        atm.Density=preset.atm.dens or 0.3;atm.Color=candyColor(preset.atm.color);atm.Decay=candyColor(preset.atm.decay);atm.Glare=preset.atm.glare or 1;atm.Haze=preset.atm.haze or 1;atm.Parent=Lighting
    end
    if preset.clouds and terrain then
        local clouds=Instance.new("Clouds");clouds:SetAttribute(M.CANDY_SKY_TAG,true)
        clouds.Cover=preset.clouds.cover or 0.5;clouds.Density=preset.clouds.dens or 0.5;clouds.Color=candyColor(preset.clouds.color);clouds.Parent=terrain
    end
end

-- ============================================================
-- ANIMATION PACKS
-- ============================================================
M.PACKS = {
    ["Adidas Sports"] = {
        WalkAnim = 18537392113,
        RunAnim  = 18537384940,
        JumpAnim = 18537380791,
        FallAnim = 18537367238,
        SwimIdle = 18537387180,
        Swim     = 18537389531,
        Animation1 = 18537376492,
        Animation2 = 18537371272,
        ClimbAnim = 18537363391,
    },
    ["Adidas Community"] = {
        WalkAnim = 122150855457006,
        RunAnim  = 82598234841035,
        JumpAnim = 75290611992385,
        FallAnim = 98600215928904,
        SwimIdle = 109346520324160,
        Swim     = 133308483266208,
        Animation1 = 122257458498464,
        Animation2 = 102357151005774,
        ClimbAnim = 88763136693023,
    },
    ["Adidas Aura"] = {
        WalkAnim = 83842218823011,
        RunAnim  = 118320322718866,
        JumpAnim = 109996626521204,
        FallAnim = 95603166884636,
        SwimIdle = 94922130551805,
        Swim     = 134530128383903,
        Animation1 = 110211186840347,
        Animation2 = 114191137265065,
        ClimbAnim = 97824616490448,
    },
    ["Wicked Popular"] = {
        WalkAnim = 92072849924640,
        RunAnim = 72301599441680,
        JumpAnim = 104325245285198,
        FallAnim = 121152442762481,
        Animation1 = 118832222982049,
        ClimbAnim = 131326830509784,
        SwimIdle = 113199415118199,
        Swim = 99384245425157,
        Animation2 = 76049494037641,
    },
    Elder = {
        WalkAnim = 10921111375,
        RunAnim  = 10921104374,
        JumpAnim = 10921107367,
        FallAnim = 10921105765,
        SwimIdle = 10921110146,
        Swim     = 10921108971,
        ClimbAnim = 10921100400,
        Animation1 = 10921101664,
        Animation2 = 10921102574,
    },
    Zombie = {
        WalkAnim = 10921355261,
        RunAnim  = 616163682,
        JumpAnim = 10921351278,
        FallAnim = 10921350320,
        SwimIdle = 10921353442,
        Swim     = 10921352344,
        Animation1 = 10921344533,
        Animation2 = 10921345304,
        ClimbAnim = 10921343576,
    },
    Mage = {
        WalkAnim = 10921152678,
        RunAnim  = 10921148209,
        JumpAnim = 10921149743,
        FallAnim = 10921148939,
        SwimIdle = 10921151661,
        Swim     = 10921150788,
        ClimbAnim = 10921143404,
        Animation1 = 10921144709,
        Animation2 = 10921145797,
    },
    ["Catwalk Glam"] = {
        WalkAnim = 109168724482748,
        RunAnim  = 81024476153754,
        JumpAnim = 116936326516985,
        FallAnim = 92294537340807,
        SwimIdle = 98854111361360,
        Swim     = 134591743181628,
        ClimbAnim = 119377220967554,
        Animation1 = 133806214992291,
        Animation2 = 94970088341563,
    },
    Astronaut = {
        WalkAnim = 10921046031,
        RunAnim  = 10921039308,
        JumpAnim = 10921042494,
        FallAnim = 10921040576,
        SwimIdle = 10921045006,
        Swim     = 10921044000,
        ClimbAnim = 10921032124,
        Animation1 = 10921034824,
        Animation2 = 10921036806,
    },
    ['Wicked "Dancing Through Life"'] = {
        WalkAnim = 73718308412641,
        RunAnim  = 135515454877967,
        JumpAnim = 78508480717326,
        FallAnim = 78147885297412,
        SwimIdle = 129183123083281,
        Swim     = 110657013921774,
        ClimbAnim = 129447497744818,
        Animation1 = 92849173543269,
        Animation2 = 132238900951109,
    },
    Werewolf = {
        WalkAnim = 10921342074,
        RunAnim  = 10921336997,
        JumpAnim = nil,
        FallAnim = 10921337907,
        SwimIdle = 10921341319,
        Swim     = 10921340419,
        ClimbAnim = 10921329322,
        Animation1 = 10921330408,
        Animation2 = 10921333667,
    },
    Superhero = {
        WalkAnim = 10921298616,
        RunAnim  = 10921291831,
        JumpAnim = 10921294559,
        FallAnim = 10921293373,
        SwimIdle = 10921297391,
        Swim     = 10921295495,
        ClimbAnim = 10921286911,
        Animation1 = 10921288909,
        Animation2 = 10921290167,
    },
    Toy = {
        WalkAnim = 10921312010,
        RunAnim  = 10921306285,
        JumpAnim = 10921308158,
        FallAnim = 10921307241,
        SwimIdle = 10921310341,
        Swim     = 10921309319,
        ClimbAnim = 10921300839,
        Animation1 = 10921301576,
        Animation2 = nil,
    },
    ["No Boundaries"] = {
        WalkAnim = 18747074203,
        RunAnim  = 18747070484,
        JumpAnim = 18747069148,
        FallAnim = 18747062535,
        SwimIdle = 18747071682,
        Swim     = 18747073181,
        ClimbAnim = 18747060903,
        Animation1 = 18747067405,
        Animation2 = 18747063918,
    },
    NFL = {
        WalkAnim = 110358958299415,
        RunAnim  = 117333533048078,
        JumpAnim = 119846112151352,
        FallAnim = 129773241321032,
        SwimIdle = 79090109939093,
        Swim     = 132697394189921,
        ClimbAnim = 134630013742019,
        Animation1 = 92080889861410,
        Animation2 = 74451233229259,
    },
    ["Amazon Unboxed"] = {
        WalkAnim = 90478085024465,
        RunAnim  = 134824450619865,
        JumpAnim = 121454505477205,
        FallAnim = 94788218468396,
        SwimIdle = 129126268464847,
        Swim     = 105962919001086,
        ClimbAnim = 121145883950231,
        Animation1 = 98281136301627,
        Animation2 = nil,
    },
    Vampire = {
        WalkAnim = 10921326949,
        RunAnim  = 10921320299,
        JumpAnim = 10921322186,
        FallAnim = 10921321317,
        SwimIdle = 10921325443,
        Swim     = 10921324408,
        ClimbAnim = 10921314188,
        Animation1 = 10921315373,
        Animation2 = nil,
    },
    Ninja = {
        Run=656118852, Walk=656121766, Jump=656117878, Fall=656115606,
        Swim=656119721, SwimIdle=656121397, Climb=656114359,
        Idle={656117400,656118341,886742569}
    },
    Robot = {
        Run=616091570, Walk=616095330, Jump=616090535, Fall=616087089,
        Swim=616092998, SwimIdle=616094091, Climb=616086039,
        Idle={616088211,616089559,885531463}
    },
    Levitation = {
        Run=616010382, Walk=616013216, Jump=616008936, Fall=616005863,
        Swim=616011509, SwimIdle=616012453, Climb=616003713,
        Idle={616006778,616008087,886862142}
    },
    Stylish = {
        Run=616140816, Walk=616146177, Jump=616139451, Fall=616134815,
        Swim=616143378, SwimIdle=616144772, Climb=616133594,
        Idle={616136790,616138447,886888594}
    },
    Bubbly = {
        Run=910025107, Walk=910034870, Jump=910016857, Fall=910001910,
        Swim=910028158, SwimIdle=910030921, Climb=909997997,
        Idle={910004836,910009958,1018536639}
    },
    Cartoon = {
        Run=742638842, Walk=742640026, Jump=742637942, Fall=742637151,
        Swim=742639220, SwimIdle=742639812, Climb=742636889,
        Idle={742637544,742638445,885477856}
    },
}
M.animPack = "Adidas Sports"
M.animPackEnabled = true
M.savedAnimate = nil

-- ============================================================
-- CHARTER FEATURES (Headless & Korblox)
-- ============================================================
M.headlessEnabled = false
M.korbloxEnabled = false

local HEADLESS_MESH_ID = "rbxassetid://1095708"
local KORBLOX_MESH_ID = "rbxassetid://101851696"
local KORBLOX_TEXTURE_ID = "rbxassetid://101851254"
local DARK_GREY_COLOR = Color3.fromRGB(64, 64, 64)

local function removeFace(head)
    local face = head:FindFirstChild("face")
    if face then face:Destroy() end
end

function M.applyHeadlessToChar(char, enabled)
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    if enabled then
        head.Transparency = 1
        head.CanCollide = false
        removeFace(head)

        -- Already applied? Don't re-create the mesh or re-connect signals.
        if head:FindFirstChild("HeadlessMesh") then return end

        for _, child in ipairs(head:GetChildren()) do
            if child:IsA("SpecialMesh") and child.MeshId == HEADLESS_MESH_ID then
                child:Destroy()
            end
        end

        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = HEADLESS_MESH_ID
        mesh.Scale = Vector3.new(0.001, 0.001, 0.001)
        mesh.Name = "HeadlessMesh"
        mesh.Parent = head

        head:GetPropertyChangedSignal("Transparency"):Connect(function()
            if M.headlessEnabled and head.Transparency ~= 1 then
                head.Transparency = 1
            end
        end)
        head.ChildAdded:Connect(function(child)
            if M.headlessEnabled and child.Name == "face" and child:IsA("Decal") then
                child:Destroy()
            end
        end)
    else
        head.Transparency = 0
        head.CanCollide = true
        for _, child in ipairs(head:GetChildren()) do
            if child:IsA("SpecialMesh") and child.Name == "HeadlessMesh" then
                child:Destroy()
            end
        end
        removeFace(head)
    end
end

function M.applyKorbloxToChar(char, enabled)
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if enabled then
        if humanoid.RigType == Enum.HumanoidRigType.R6 then
            local rightLeg = char:FindFirstChild("Right Leg")
            if rightLeg then
                if rightLeg:FindFirstChild("KorbloxMesh") then return end
                for _, child in ipairs(rightLeg:GetChildren()) do
                    if child:IsA("SpecialMesh") or child:IsA("CharacterMesh") then
                        child:Destroy()
                    end
                end
                rightLeg.Color = DARK_GREY_COLOR
                rightLeg:GetPropertyChangedSignal("Color"):Connect(function()
                    if M.korbloxEnabled and rightLeg.Color ~= DARK_GREY_COLOR then
                        rightLeg.Color = DARK_GREY_COLOR
                    end
                end)
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshType = Enum.MeshType.FileMesh
                mesh.MeshId = KORBLOX_MESH_ID
                mesh.TextureId = KORBLOX_TEXTURE_ID
                mesh.Scale = Vector3.new(1, 1, 1)
                mesh.Name = "KorbloxMesh"
                mesh.Parent = rightLeg
            end
        elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
            local rightUpperLeg = char:FindFirstChild("RightUpperLeg")
            if rightUpperLeg then
                if char:FindFirstChild("KorbloxLeg") then return end
                rightUpperLeg.Transparency = 1
                local rightLowerLeg = char:FindFirstChild("RightLowerLeg")
                local rightFoot = char:FindFirstChild("RightFoot")
                if rightLowerLeg then rightLowerLeg.Transparency = 1 end
                if rightFoot then rightFoot.Transparency = 1 end

                local oldKorblox = char:FindFirstChild("KorbloxLeg")
                if oldKorblox then oldKorblox:Destroy() end

                local korbloxLeg = Instance.new("Part")
                korbloxLeg.Name = "KorbloxLeg"
                korbloxLeg.Size = Vector3.new(1, 2, 1)
                korbloxLeg.Anchored = false
                korbloxLeg.CanCollide = false
                korbloxLeg.Color = DARK_GREY_COLOR
                korbloxLeg.Parent = char

                local mesh = Instance.new("SpecialMesh")
                mesh.MeshType = Enum.MeshType.FileMesh
                mesh.MeshId = KORBLOX_MESH_ID
                mesh.TextureId = KORBLOX_TEXTURE_ID
                mesh.Scale = Vector3.new(1, 1, 1)
                mesh.Name = "KorbloxMesh"
                mesh.Parent = korbloxLeg

                local weld = Instance.new("Weld")
                weld.Part0 = rightUpperLeg
                weld.Part1 = korbloxLeg
                weld.C0 = CFrame.new(0, -0.8, 0)
                weld.Name = "KorbloxWeld"
                weld.Parent = korbloxLeg            end
        end
    else
        if humanoid.RigType == Enum.HumanoidRigType.R6 then
            local rightLeg = char:FindFirstChild("Right Leg")
            if rightLeg then
                for _, child in ipairs(rightLeg:GetChildren()) do
                    if child:IsA("SpecialMesh") and child.Name == "KorbloxMesh" then
                        child:Destroy()
                    end
                end
                rightLeg.Color = Color3.fromRGB(255, 255, 255)
            end
        elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
            local rightUpperLeg = char:FindFirstChild("RightUpperLeg")
            if rightUpperLeg then
                rightUpperLeg.Transparency = 0
                local rightLowerLeg = char:FindFirstChild("RightLowerLeg")
                local rightFoot = char:FindFirstChild("RightFoot")
                if rightLowerLeg then rightLowerLeg.Transparency = 0 end
                if rightFoot then rightFoot.Transparency = 0 end
                local korbloxLeg = char:FindFirstChild("KorbloxLeg")
                if korbloxLeg then korbloxLeg:Destroy() end
            end
        end
    end
end

function M.applyCharterToChar(char)
    if not char then return end
    M.applyHeadlessToChar(char, M.headlessEnabled)
    M.applyKorbloxToChar(char, M.korbloxEnabled)
end

player.CharacterAdded:Connect(function(char)
    task.wait(0.15)
    M.applyCharterToChar(char)
end)

-- (Removed a per-frame Heartbeat that re-ran applyCharterToChar every frame.
--  It re-created meshes and stacked signal connections continuously, which
--  slowly drained FPS. Charter is now applied on spawn and on toggle only.)

-- ============================================================
-- STATE
-- ============================================================
M.NS = 60
M.CS = 30
M.LAGGER_SPEED = 15
M.LAGGER_CARRY_SPEED = 24.5
M.carrySpeedActive = false
M.laggerModeEnabled = false
M.laggerCarryActive = false
M.autoCarryOnGrab = false   -- Auto Carry On Grab
M._autoCarryConn  = nil     -- connexion Heartbeat du système
M.pingAlertEnabled = false  -- Ping Alert
M._pingAlertTask   = nil
M._pingAlertConn   = nil

-- ============================================================
-- LINEAR VELOCITY (horizontal movement constraint)
-- Mode Plane : contraint XZ uniquement, Y totalement libre → jump intact.
-- Deux attachments requis par Roblox pour le mode Plane.
-- ============================================================
M._linVel      = nil
M._linVelAtt0  = nil
M._linVelAtt1  = nil
M._linVelChar  = nil

local function setupLinearVelocity(char)
    if M._linVel  then pcall(function() M._linVel:Destroy()  end); M._linVel  = nil end
    if M._linVelAtt0 then pcall(function() M._linVelAtt0:Destroy() end); M._linVelAtt0 = nil end
    if M._linVelAtt1 then pcall(function() M._linVelAtt1:Destroy() end); M._linVelAtt1 = nil end

    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local att0 = Instance.new("Attachment")
    att0.Name   = "OrvynLinVelAtt0"
    att0.Parent = hrp

    local att1 = Instance.new("Attachment")
    att1.Name   = "OrvynLinVelAtt1"
    att1.Parent = hrp

    local lv = Instance.new("LinearVelocity")
    lv.Name                  = "OrvynLinVel"
    lv.Attachment0           = att0
    lv.Attachment1           = att1
    -- Plane : seul le plan XZ est contraint — Y totalement libre, jump intact
    lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
    lv.PrimaryTangentAxis    = Vector3.new(1, 0, 0)   -- axe X du plan
    lv.SecondaryTangentAxis  = Vector3.new(0, 0, 1)   -- axe Z du plan
    lv.RelativeTo            = Enum.ActuatorRelativeTo.World
    lv.MaxForce              = 1e6
    lv.PlaneVelocity         = Vector2.new(0, 0)      -- départ immobile XZ
    lv.Parent                = hrp

    M._linVel     = lv
    M._linVelAtt0 = att0
    M._linVelAtt1 = att1
    M._linVelChar = char
end

-- XZ via PlaneVelocity (Vector2) — Y jamais touché
local function setLinVelXZ(x, z)
    if M._linVel and M._linVel.Parent then
        M._linVel.PlaneVelocity = Vector2.new(x, z)
    end
end

local function clearLinVel()
    if M._linVel and M._linVel.Parent then
        M._linVel.PlaneVelocity = Vector2.new(0, 0)
    end
end

M.antiRagdollEnabled = false
M.infJumpEnabled = false
M.infJumpMode = "manual"
M.medusaCounterEnabled = false
M.batCounterEnabled = false
M.unwalkEnabled = false
M.medusaResetEnabled = false
M.medusaDebounce = false
M.medusaLastUsed = 0
M.dropActive = false
M.dropMode = "Jump"
M.autoLeftEnabled = false
M.autoRightEnabled = false
M.autoBatEnabled = false
M.autoSwingEnabled = true
M.autoMoveSwingEnabled = false
M.autoMoveSwingInterval = 0.3
M._alSwingDebounce = false
M._arSwingDebounce = false
M.antiLagEnabled = false
M.removeAccessoriesEnabled = false
M.antiLagDescConn = nil
M.stretchRezEnabled = false
M.stretchRezConn = nil
M.unwalkSavedAnimate = nil
M._anyKeyListening = false
M.autoTPEnabled = false
M.autoTPHeight = 20
M.autoTPConn = nil
M.CURSED_RESET_GUID = "f888ee6e-c86d-46e1-93d7-0639d6635d42"
M.guiTransparencyEnabled = false
M.mobileButtonsEnabled = true
M.mobileButtonsLocked = false
M.mobileButtonsSize = 90
M.circleButtonsEnabled = false
M.mobBtnRefs = {}
M.mobGuiRef = nil
M.fovValue = 80
M.fovOptions = {80,120,180}
M.fovIndex = 1
M.laggerModePillRef = nil
M.carryModePillRef = nil
M.autoSwitchSpeedEnabled = false
M.mobBtnTransparencyEnabled = false
M.perButtonDragEnabled = false
M.antiKickEnabled = false
M.brainrotDetected = false
M.activeBatBillboard = nil
M.activeMedusaBillboard = nil
M.ragdollGuiEnabled = true
M.persistentRagdollGui = nil
M.uiLocked = false
M.holdInfJumpConn = nil
M.DROP_ASCEND_DURATION = 0.2
M.DROP_ASCEND_SPEED = 150
M.autoResetOnDeath = false
M.bodyLockEnabled = false
M.bodyLockRadius = 60
M.bodyLockConn = nil

-- Bypass Aimbot state (with modes)
M.bypassAimbotEnabled = false
M.bypassAimbotMode = "TPBat"
M.bypassAimbotConn = nil
M.bypassPrevAutoRotate = nil
M.bypassHitCD = false
M.bypassSwingCD = 0.35
M.bypassHitDist = 8
M._bypassTarget = nil

M.stealMode = "Normal"
M.stealBarSize = 300
M.stealBarScale = 0.9
M.Steal = {
    AutoStealEnabled = false,
    StealRadius = 60,
    StealDuration = 1.4,
}
M.Semi = {
    HoldMin = 1.3,
    HoldMax = 2.6,
    EntryDelay = 0.3,
    Cooldown = 0.05,
    StealRange = 9,
    PrimeRange = 80,
    allAnimalsCache = {},
    PromptMemoryCache = {},
    InternalStealCache = {},
    stealConnection = nil,
    StealState = {
        active = false,
        startTime = 0,
        phase = "idle",
        label = "",
        lastResult = "",
        lastResultTime = 0,
        totalSteals = 0,
        failedSteals = 0,
    },
    plots = workspace:WaitForChild("Plots"),
    syncRemotes = nil,
    plotAnimalSync = {caches = {}, connections = {}},
    AnimalsData = nil,
    initialized = false,
}
M.isStealing = false
M.stealStartTime = 0
M.stealConn = nil
M.progressConn = nil
M.animalCache = {}
M.promptCache = {}
M.stealCache = {}
M.playerESPEnabled = false
M.espList = {}
M.pingPopupActive = false
M.pingPopupGui = nil
M.pingCycleTimer = nil
M.Conns = {autoSteal=nil, antiRag=nil, batCounter=nil, anchor={}}
M._persistentConns = {}
M.alConn = nil
M.arConn = nil
M.alPhase = 1
M.arPhase = 1
M.aimbotConn = nil
M.lastMoveDir = Vector3.new(0,0,0)
M.batCounterDebounce = false
M.speedLabel = nil

-- Keybinds
M.KB = {
    DropBrainrot={kb=nil,gp=nil},
    AutoLeft={kb=nil,gp=nil},
    AutoRight={kb=nil,gp=nil},
    AutoBat={kb=nil,gp=nil},
    TPFloor={kb=nil,gp=nil},
    InstaReset={kb=nil,gp=nil},
    GuiHide={kb=Enum.KeyCode.LeftControl,gp=nil},
    SpeedToggle={kb=nil,gp=nil},
    LaggerToggle={kb=nil,gp=nil},
    BypassAimbot={kb=nil,gp=nil},
    BodyLock={kb=nil,gp=nil},
}
M.AP_L1 = Vector3.new(-476.47,-6.28,92.73)
M.AP_L2 = Vector3.new(-483.12,-4.95,94.81)
M.AP_R1 = Vector3.new(-476.16,-6.52,25.62)
M.AP_R2 = Vector3.new(-483.06,-5.03,25.48)
M.MEDUSA_COOLDOWN = 25
M.BAT_COUNTER_SLAP_LIST = {"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}
M.fovConn = nil
M.defLightBrightness = nil
M.defLightClock = nil
M.defLightAmbient = nil
M.mainFrame = nil
M.normalBox = nil
M.carryBox = nil
M.laggerBox = nil
M.radInput = nil
M.autoTPHeightBox = nil
M.durationBox = nil
M.modeValLbl = nil
M.setInstaGrab = nil
M.setInfJumpVisual = nil
M.setAntiRagVisual = nil
M.setMedusaVisual = nil
M.setUnwalkVisual = nil
M.setAntiLagVisual = nil
M.setAutoSwingVisual = nil
M.setTranspVisual = nil
M.setLockVisual = nil
M.setMobVisual = nil
M.setCircleBtnsVisual = nil
M.setMedusaResetVisual = nil
M.antiKickSetVisual = nil
M.autoLeftSetVisual = nil
M.autoRightSetVisual = nil
M.autoBatSetVisual = nil
M.setAutoTPVisual = nil
M.setStretchRezVisual = nil
M.setAutoResetOnDeath = nil
M.setBypassVisual = nil
M._autoSwitchWasSteal = false

M.MOB_POS_FILE = "moveeduels_btnpos.json"
M.MOVE_KEYS = {
    [Enum.KeyCode.W]=true,
    [Enum.KeyCode.A]=true,
    [Enum.KeyCode.S]=true,
    [Enum.KeyCode.D]=true,
    [Enum.KeyCode.Up]=true,
    [Enum.KeyCode.Left]=true,
    [Enum.KeyCode.Down]=true,
    [Enum.KeyCode.Right]=true
}

M.showPlayerSpeeds = false
M.playerSpeedGuis = {}
M.playerSpeedUpdateConn = nil
M.nukeOptimizerEnabled = false
M.nukeConns = {}
M.nukeThreads = {}
M.nukeOn = false
M.removeAccEnabled = false
M.removeAccConn = nil
M.removedAccessories = {}
M.uiScale = 1
M.uiScaleSliderRef = nil
M.uiScaleLabelRef = nil
M.uiScaleBoxRef = nil
M.bgImageId = "107328909628204"   -- fixed default background picture (not user-changeable)
M.BG_IMAGE_DEFAULT = "112701306083078"
M.bgTransparency = 0.45           -- default background transparency
M.lineESPEnabled = false
M.speedESPEnabled = false

-- K7 Status UI (Steal Bar) references
M.statusGui = nil
M.statusFill = nil
M.statusPctLbl = nil
M.statusRadiusLbl = nil
M.statusDot = nil
M.statusMain = nil
M.statusFpsLbl = nil

-- ============================================================
-- UTILITY FUNCTIONS
-- ============================================================
function M.addShimmerToLabel(lbl,color1,color2)
    local gr=Instance.new("UIGradient",lbl)
    gr.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,color1 or Color3.fromRGB(200,30,30)),ColorSequenceKeypoint.new(0.5,color2 or Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,color1 or Color3.fromRGB(200,30,30))})
    gr.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.3,0),NumberSequenceKeypoint.new(0.5,0,0),NumberSequenceKeypoint.new(1,0.3,0)})
    return gr
end

function M.applyFOV()
    if M.fovConn then M.fovConn:Disconnect() end
    M.fovConn=RunService.RenderStepped:Connect(function() local cam=workspace.CurrentCamera;if cam then cam.FieldOfView=M.fovValue end end)
end

-- ============================================================
-- RAGDOLL TIMER (integrated into head indicator)
-- ============================================================
M.ragdollTimerThread = nil
M.ragdollTimerRemaining = 0
M.isRagdollActive = false

function M.updateRagdollTimer(duration)
    if M.ragdollTimerThread then
        task.cancel(M.ragdollTimerThread)
        M.ragdollTimerThread = nil
    end
    if duration <= 0 then
        M.isRagdollActive = false
        if M.headIndicator and M.headIndicator.ragdollTimer then
            M.headIndicator.ragdollTimer.Text = ""
        end
        return
    end
    M.isRagdollActive = true
    local startTime = tick()
    M.ragdollTimerRemaining = duration
    M.ragdollTimerThread = task.spawn(function()
        while M.isRagdollActive and M.ragdollTimerRemaining > 0 do
            local elapsed = tick() - startTime
            local remaining = math.max(0, duration - elapsed)
            M.ragdollTimerRemaining = remaining
            if M.headIndicator and M.headIndicator.ragdollTimer then
                M.headIndicator.ragdollTimer.Text = string.format("%.1fs", remaining)
            end
            if remaining <= 0 then
                M.isRagdollActive = false
                if M.headIndicator and M.headIndicator.ragdollTimer then
                    M.headIndicator.ragdollTimer.Text = ""
                end
                break
            end
            task.wait(0.05)
        end
        M.ragdollTimerThread = nil
    end)
end

function M.onHumanoidStateChanged(old,new)
    local char=player.Character;if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid");if not hum then return end
    local isRag=(new==Enum.HumanoidStateType.Physics or new==Enum.HumanoidStateType.Ragdoll or new==Enum.HumanoidStateType.FallingDown)
    if isRag and not hum.PlatformStand then
        M.updateRagdollTimer(2.6)
    end
end

function M.onMedusaStateChanged()
    local char=player.Character;if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum and hum.PlatformStand then
        M.updateRagdollTimer(4.5)
    end
end

function M.setupRagdollTriggers()
    local char=player.Character;if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.StateChanged:Connect(M.onHumanoidStateChanged)
        hum:GetPropertyChangedSignal("PlatformStand"):Connect(M.onMedusaStateChanged)
    end
end

-- ============================================================
-- ANIMATION FUNCTIONS (with reset support)
-- ============================================================
function M.waitForAnimate(char)
    for _ = 1, 40 do
        local a = char:FindFirstChild("Animate")
        if a and a:FindFirstChild("idle") and a:FindFirstChild("run") and a:FindFirstChild("walk") then
            return a
        end
        task.wait(0.1)
    end
    return nil
end

function M.setAnim(animObj, id)
    if animObj and id then
        animObj.AnimationId = "rbxassetid://" .. tostring(id)
    end
end

function M.stopAllTracks(hum)
    if not hum then return end
    for _, t in ipairs(hum:GetPlayingAnimationTracks()) do
        pcall(function() t:Stop(0) end)
    end
end

function M.ensureAnim(folder, name)
    if not folder then return nil end
    local a = folder:FindFirstChild(name)
    if not a then
        a = Instance.new("Animation")
        a.Name = name
        a.Parent = folder
    end
    return a
end

function M.ensureIdleSlots(idleFolder, n)
    if not idleFolder then return end
    n = n or 2
    for i=1,n do
        M.ensureAnim(idleFolder, "Animation" .. i)
    end
end

function M.pick(pack, ...)
    for i = 1, select("#", ...) do
        local k = select(i, ...)
        local v = pack[k]
        if v ~= nil then return v end
    end
    return nil
end

-- Save original Animate script before modifying
function M.saveOriginalAnimate(char)
    if not char then return end
    if M.savedAnimate then return end
    local animate = char:FindFirstChild("Animate")
    if animate then
        M.savedAnimate = animate:Clone()
    end
end

-- Restore original Animate script (if saved) and remove current modifications
function M.restoreOriginalAnimate(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        M.stopAllTracks(hum)
    end
    local currentAnimate = char:FindFirstChild("Animate")
    if currentAnimate then
        currentAnimate:Destroy()
    end
    if M.savedAnimate then
        local newAnimate = M.savedAnimate:Clone()
        newAnimate.Parent = char
        newAnimate.Disabled = true
        task.wait(0.06)
        newAnimate.Disabled = false
    else
    end
end

-- Reset animations to default (empty IDs) - used when pack is turned off
function M.resetAnimations(char)
    if not char then return end
    M.restoreOriginalAnimate(char)
end

local applyingAnim = false
function M.applyAnimPack(packName)
    if not M.animPackEnabled then
        local char = player.Character
        if char then
            M.resetAnimations(char)
        end
        return false
    end
    if applyingAnim then return false end
    applyingAnim = true

    local pack = M.PACKS[packName]
    if not pack then
        applyingAnim = false
        return false
    end

    local char = player.Character or player.CharacterAdded:Wait()
    M.saveOriginalAnimate(char)

    local animate = M.waitForAnimate(char)
    if not animate then
        applyingAnim = false
        return false
    end

    local hum = char:FindFirstChildOfClass("Humanoid")
    M.stopAllTracks(hum)

    local runObj   = M.ensureAnim(animate:FindFirstChild("run"),   "RunAnim")
    local walkObj  = M.ensureAnim(animate:FindFirstChild("walk"),  "WalkAnim")
    local jumpObj  = M.ensureAnim(animate:FindFirstChild("jump"),  "JumpAnim")
    local fallObj  = M.ensureAnim(animate:FindFirstChild("fall"),  "FallAnim")
    local climbObj = M.ensureAnim(animate:FindFirstChild("climb"), "ClimbAnim")
    local swimObj  = M.ensureAnim(animate:FindFirstChild("swim"),     "Swim")
    local swimIdleObj = M.ensureAnim(animate:FindFirstChild("swimidle"), "SwimIdle")
    local idleFolder = animate:FindFirstChild("idle")

    M.setAnim(walkObj,  M.pick(pack, "WalkAnim", "Walk"))
    M.setAnim(runObj,   M.pick(pack, "RunAnim", "Run"))
    M.setAnim(jumpObj,  M.pick(pack, "JumpAnim", "Jump"))
    M.setAnim(fallObj,  M.pick(pack, "FallAnim", "Fall"))
    M.setAnim(climbObj, M.pick(pack, "ClimbAnim", "Climb"))
    M.setAnim(swimObj,      M.pick(pack, "Swim"))
    M.setAnim(swimIdleObj,  M.pick(pack, "SwimIdle") or M.pick(pack, "Swim"))

    if idleFolder then
        local a1 = M.pick(pack, "Animation1")
        local a2 = M.pick(pack, "Animation2")
        if a1 or a2 then
            M.ensureIdleSlots(idleFolder, 2)
            local id1 = a1 or a2
            local id2 = a2 or a1 or id1
            M.setAnim(idleFolder:FindFirstChild("Animation1"), id1)
            M.setAnim(idleFolder:FindFirstChild("Animation2"), id2)
        elseif pack.Idle and #pack.Idle > 0 then
            M.ensureIdleSlots(idleFolder, math.max(2, #pack.Idle))
            M.setAnim(idleFolder:FindFirstChild("Animation1"), pack.Idle[1])
            M.setAnim(idleFolder:FindFirstChild("Animation2"), pack.Idle[2] or pack.Idle[1])
            for i = 3, #pack.Idle do
                local a = idleFolder:FindFirstChild("Animation" .. i)
                if a then M.setAnim(a, pack.Idle[i]) end
            end
        end
    end

    animate.Disabled = true
    task.wait(0.06)
    animate.Disabled = false

    if hum then
        pcall(function()
            hum:ChangeState(Enum.HumanoidStateType.Landed)
            task.wait(0.03)
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end)
    end

    M.animPack = packName
    applyingAnim = false
    return true
end

-- ============================================================
-- BODY LOCK FUNCTIONS
-- ============================================================
function M.getNearestBodyLockTarget()
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local nearest = nil
    local shortest = math.huge
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local tr = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if tr and hum and hum.Health > 0 then
                local d = (tr.Position - root.Position).Magnitude
                if d <= M.bodyLockRadius and d < shortest then
                    shortest = d
                    nearest = plr
                end
            end
        end
    end
    return nearest
end

function M.startBodyLock()
    if M.bodyLockConn then return end
    M.bodyLockEnabled = true
    
    M.bodyLockConn = RunService.Heartbeat:Connect(function()
        if not M.bodyLockEnabled then return end
        
        local character = player.Character
        local myRoot = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        if not myRoot or not humanoid or humanoid.Health <= 0 then return end
        
        local target = M.getNearestBodyLockTarget()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local targetPos = target.Character.HumanoidRootPart.Position
            local myPos = myRoot.Position
            
            local offset = Vector3.new(targetPos.X, myPos.Y, targetPos.Z) - myPos
            
            if offset.Magnitude > 0.1 then
                humanoid.AutoRotate = false
                local lookDir = offset.Unit
                local currentDir = myRoot.CFrame.LookVector
                local cross = currentDir:Cross(lookDir)
                local currentVel = myRoot.AssemblyAngularVelocity
                
                myRoot.AssemblyAngularVelocity = Vector3.new(currentVel.X, cross.Y * 40, currentVel.Z)
            end
        else
            humanoid.AutoRotate = true
        end
    end)
end

function M.stopBodyLock()
    M.bodyLockEnabled = false
    if M.bodyLockConn then 
        M.bodyLockConn:Disconnect() 
        M.bodyLockConn = nil 
    end
    
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then 
        hum.AutoRotate = true 
    end
end

function M.toggleBodyLock()
    M.bodyLockEnabled = not M.bodyLockEnabled
    if M.bodyLockEnabled then
        M.startBodyLock()
    else
        M.stopBodyLock()
    end
    if M.setBodyLockVisual then 
        M.setBodyLockVisual(M.bodyLockEnabled) 
    end
    saveCherryConfig()
    return M.bodyLockEnabled
end

-- ============================================================
-- PLAYER SPEED DISPLAY (for others)
-- ============================================================
function M.createPlayerSpeedGui(plr)
    if plr == player then return end
    if M.playerSpeedGuis[plr] then return end
    local char = plr.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    local old = head:FindFirstChild("MoveePlayerSpeedBB")
    if old then old:Destroy() end
    local bb = Instance.new("BillboardGui")
    bb.Name = "MoveePlayerSpeedBB"
    bb.Size = UDim2.new(0, 80, 0, 24)
    bb.StudsOffset = Vector3.new(0, 2.2, 0)
    bb.AlwaysOnTop = true
    bb.Adornee = head
    bb.Parent = head
    local label = Instance.new("TextLabel", bb)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = "0"
    label.TextColor3 = CHERRY_ACCENT
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.TextStrokeTransparency = 0
    M.addShimmerToLabel(label, CHERRY_ACCENT, Color3.fromRGB(255,255,255))
    local conn
    conn = char.AncestryChanged:Connect(function(_, parent)
        if not parent then
            M.removePlayerSpeedGui(plr)
            if conn then conn:Disconnect() end
        end
    end)
    M.playerSpeedGuis[plr] = {gui = bb, label = label, conn = conn}
end

function M.removePlayerSpeedGui(plr)
    local data = M.playerSpeedGuis[plr]
    if data then
        if data.conn then data.conn:Disconnect() end
        if data.gui then data.gui:Destroy() end
        M.playerSpeedGuis[plr] = nil
    end
end

function M.updatePlayerSpeed(plr)
    if not M.showPlayerSpeeds then return end
    local data = M.playerSpeedGuis[plr]
    if not data then return end
    local char = plr.Character
    if not char then M.removePlayerSpeedGui(plr); return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local speed = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z).Magnitude
    data.label.Text = string.format("%.1f", speed)
end

function M.updateAllPlayerSpeeds()
    for plr, _ in pairs(M.playerSpeedGuis) do M.updatePlayerSpeed(plr) end
end

function M.startPlayerSpeedUpdates()
    if M.playerSpeedUpdateConn then return end
    M.playerSpeedUpdateConn = RunService.Heartbeat:Connect(function() M.updateAllPlayerSpeeds() end)
end

function M.stopPlayerSpeedUpdates()
    if M.playerSpeedUpdateConn then M.playerSpeedUpdateConn:Disconnect(); M.playerSpeedUpdateConn = nil end
end

function M.togglePlayerSpeeds(on)
    M.showPlayerSpeeds = on
    if on then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player then M.createPlayerSpeedGui(plr) end
        end
        M.startPlayerSpeedUpdates()
    else
        for plr, _ in pairs(M.playerSpeedGuis) do M.removePlayerSpeedGui(plr) end
        M.stopPlayerSpeedUpdates()
    end
end

-- ============================================================
-- PLAYER ESP
-- ============================================================
function M.addESP(plr)
    if plr == player then return end
    if M.espList[plr] then return end
    local char = plr.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    local nameBB = Instance.new("BillboardGui")
    nameBB.Size = UDim2.new(0, 120, 0, 30)
    nameBB.StudsOffset = Vector3.new(0, 2.8, 0)
    nameBB.AlwaysOnTop = true
    nameBB.Adornee = head
    nameBB.Parent = head
    local nameLbl = Instance.new("TextLabel", nameBB)
    nameLbl.Size = UDim2.new(1,0,1,0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = plr.Name
    nameLbl.TextColor3 = Color3.fromRGB(255,255,255)
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextScaled = true
    nameLbl.TextStrokeTransparency = 0
    nameLbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)

    local highlight = Instance.new("Highlight")
    highlight.Adornee = char
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0.3
    highlight.OutlineColor = Color3.fromRGB(255,255,255)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char

    M.espList[plr] = {nameBB = nameBB, highlight = highlight}
end

function M.removeESP(plr)
    local data = M.espList[plr]
    if data then
        if data.nameBB then data.nameBB:Destroy() end
        if data.highlight then data.highlight:Destroy() end
        M.espList[plr] = nil
    end
end

function M.clearESP()
    for plr, _ in pairs(M.espList) do M.removeESP(plr) end
end

function M.toggleESP(on)
    M.playerESPEnabled = on
    if on then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player then M.addESP(plr) end
        end
        if not M._espPlayerAdded then
            M._espPlayerAdded = Players.PlayerAdded:Connect(function(p)
                if p ~= player and M.playerESPEnabled then
                    p.CharacterAdded:Connect(function()
                        task.wait(0.5)
                        M.addESP(p)
                    end)
                    if p.Character then task.wait(0.5); M.addESP(p) end
                end
            end)
            M.trackConn(M._espPlayerAdded)
        end
        if not M._espPlayerRemoved then
            M._espPlayerRemoved = Players.PlayerRemoving:Connect(function(p)
                M.removeESP(p)
            end)
            M.trackConn(M._espPlayerRemoved)
        end
    else
        M.clearESP()
        if M._espPlayerAdded then M._espPlayerAdded:Disconnect(); M._espPlayerAdded = nil end
        if M._espPlayerRemoved then M._espPlayerRemoved:Disconnect(); M._espPlayerRemoved = nil end
    end
end

-- ============================================================
-- OVER-HEAD INDICATOR (Theme color, includes ragdoll timer)
-- ============================================================
M.headIndicator = nil

function M.setupHeadIndicator(char)
    local head=char:WaitForChild("Head",5);if not head then return end
    if head:FindFirstChild("MoveeHeadIndicator") then head.MoveeHeadIndicator:Destroy() end
    local bb=Instance.new("BillboardGui",head)
    bb.Name="MoveeHeadIndicator"
    bb.Size=UDim2.new(0,250,0,90)
    bb.StudsOffset=Vector3.new(0,3.5,0)
    bb.AlwaysOnTop=true
    bb.Parent=head

    local accent = CHERRY_ACCENT

    local ragdollLbl=Instance.new("TextLabel",bb)
    ragdollLbl.Name="RagdollTimer"
    ragdollLbl.Size=UDim2.new(1,0,0.33,0)
    ragdollLbl.Position=UDim2.new(0,0,0,0)
    ragdollLbl.BackgroundTransparency=1
    ragdollLbl.Text=""
    ragdollLbl.TextColor3=accent
    ragdollLbl.Font=Enum.Font.GothamBold
    ragdollLbl.TextScaled=true
    ragdollLbl.TextStrokeTransparency=0

    local discordLbl=nil

    local speedLbl=Instance.new("TextLabel",bb)
    speedLbl.Name="Speed"
    speedLbl.Size=UDim2.new(1,0,0.33,0)
    speedLbl.Position=UDim2.new(0,0,0.66,0)
    speedLbl.BackgroundTransparency=1
    speedLbl.Text="0.0"
    speedLbl.TextColor3=Color3.fromRGB(255,255,255)
    speedLbl.Font=Enum.Font.GothamBold
    speedLbl.TextScaled=true
    speedLbl.TextStrokeTransparency=0

    M.headIndicator = {bb=bb, discord=discordLbl, speed=speedLbl, ragdollTimer=ragdollLbl}
    M.updateHeadTheme()
end

function M.updateHeadTheme()
    if not M.headIndicator then return end
    local accent = CHERRY_ACCENT
    if M.headIndicator.discord then
        M.headIndicator.discord.TextColor3 = accent
    end
    if M.headIndicator.speed then
        M.headIndicator.speed.TextColor3 = Color3.fromRGB(255,255,255)
    end
    if M.headIndicator.ragdollTimer then
        M.headIndicator.ragdollTimer.TextColor3 = accent
    end
end

local speedUpdateConn = nil
function M.startHeadSpeedUpdates()
    if speedUpdateConn then return end
    speedUpdateConn = RunService.Heartbeat:Connect(function()
        local char = player.Character
        if char and M.headIndicator and M.headIndicator.speed then
            local displaySpeed
            if M.autoLeftEnabled or M.autoRightEnabled then
                displaySpeed = M.NS
            else
                displaySpeed = M.getActiveMoveSpeed()
            end
            M.headIndicator.speed.Text = string.format("%.1f", displaySpeed)
        end
    end)
end

function M.stopHeadSpeedUpdates()
    if speedUpdateConn then
        speedUpdateConn:Disconnect()
        speedUpdateConn = nil
    end
end

-- ============================================================
-- K7 STATUS UI (Steal Bar) with accurate FPS
-- ============================================================
function M.buildStatusUI()
    if M.statusGui then
        pcall(function() M.statusGui:Destroy() end)
        M.statusGui = nil
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "K7_StatusUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    do
        local ok = false
        if gethui then
            ok = pcall(function() gui.Parent = gethui() end)
        elseif syn and syn.protect_gui then
            ok = pcall(function()
                syn.protect_gui(gui)
                gui.Parent = game:GetService("CoreGui")
            end)
        end
        if not ok then
            gui.Parent = player:WaitForChild("PlayerGui")
        end
    end

    for _, v in ipairs(gui.Parent:GetChildren()) do
        if v ~= gui and v:IsA("ScreenGui") and v.Name == gui.Name then
            v:Destroy()
        end
    end

    local C = {
        bg    = Color3.fromRGB(10, 10, 10),
        stroke = Color3.fromRGB(255, 255, 255),
        white = Color3.fromRGB(255, 255, 255),
        grey  = Color3.fromRGB(170, 170, 170),
        track = Color3.fromRGB(42, 42, 42),
        dotBg = Color3.fromRGB(85, 85, 85),
    }
    local ITALIC = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic)

    local ACCENT = CHERRY_ACCENT
    local BAR_H = 37
    -- fixed internal layout width; the whole bar is scaled by M.stealBarScale
    local width = 420
    local main = Instance.new("Frame")
    main.Size = UDim2.fromOffset(width, BAR_H)
    -- restore saved position if present
    local savedBar = (M.loadBtnPositions and M.loadBtnPositions()) or {}
    if savedBar["_stealbar"] then
        local sp = savedBar["_stealbar"]
        main.AnchorPoint = Vector2.new(0, 0)
        main.Position = UDim2.new(sp.xs or 0, sp.xo or 0, sp.ys or 0, sp.yo or 0)
    else
        main.AnchorPoint = Vector2.new(0.5, 1)
        main.Position = UDim2.new(0.5, 0, 1, -80)
    end
    main.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
    main.BorderSizePixel = 0
    main.Active = true
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(1, 0)
    local mStroke = Instance.new("UIStroke", main)
    mStroke.Color = ACCENT
    mStroke.Thickness = 1.5
    mStroke.Transparency = 0.2
    -- scales the ENTIRE steal bar (text, pills, dot, height) together
    local barScale = Instance.new("UIScale")
    barScale.Scale = M.stealBarScale or 1
    barScale.Parent = main
    M.stealBarScaleRef = barScale

    -- layout cursor (left -> right), with fixed gaps so nothing overlaps
    local PAD = 5
    local GAP = 8
    local x = PAD

    -- fixed-size right-side elements; STEAL pill takes the rest so it stays long
    -- (% now lives INSIDE the steal pill, so it needs no separate slot)
    local FPS_W, PING_W = 0, 0
    local DOT_W  = 28
    -- width consumed by everything except the STEAL pill (with gaps)
    local rightUsed = DOT_W + PAD
    local STEAL_W = width - PAD - GAP - rightUsed
    if STEAL_W < 110 then
        STEAL_W = 110
        width = PAD + STEAL_W + GAP + rightUsed
        main.Size = UDim2.fromOffset(width, BAR_H)
    end

    -- ===== STEAL pill (left): STEAL text + %, with progress fill =====
    local PILL_RADIUS = math.floor((BAR_H - 8) / 2)
    local stealPill = Instance.new("Frame")
    stealPill.Size = UDim2.new(0, STEAL_W, 1, -8)
    stealPill.Position = UDim2.fromOffset(x, 4)
    stealPill.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    stealPill.BorderSizePixel = 0
    stealPill.ClipsDescendants = true
    stealPill.Parent = main
    Instance.new("UICorner", stealPill).CornerRadius = UDim.new(0, PILL_RADIUS)

    -- solid fill with a fixed-radius rounded cap so the leading edge is round
    -- (moves like a capsule, not a square). Fixed pixel radius stays visible
    -- even at tiny widths, unlike a scale-based corner.
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.Position = UDim2.fromOffset(0, 0)
    fill.BackgroundColor3 = Color3.fromRGB(60, 150, 255)
    fill.BorderSizePixel = 0
    fill.ZIndex = 2
    fill.Parent = stealPill
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, PILL_RADIUS)
    M.statusFill = fill
    M._stealPillW = STEAL_W

    local stealTxt = Instance.new("TextLabel")
    stealTxt.BackgroundTransparency = 1
    stealTxt.Position = UDim2.fromOffset(16, 0)
    stealTxt.Size = UDim2.new(0, 90, 1, 0)
    stealTxt.Font = Enum.Font.GothamBlack
    stealTxt.TextSize = 15
    stealTxt.TextColor3 = Color3.fromRGB(255,255,255)
    stealTxt.TextXAlignment = Enum.TextXAlignment.Left
    stealTxt.Text = "STEAL"
    stealTxt.ZIndex = 4
    stealTxt.Parent = stealPill

    -- percentage INSIDE the steal pill, aligned to its right side
    local pctLbl = Instance.new("TextLabel")
    pctLbl.BackgroundTransparency = 1
    pctLbl.AnchorPoint = Vector2.new(1, 0)
    pctLbl.Position = UDim2.new(1, -16, 0, 0)
    pctLbl.Size = UDim2.fromOffset(60, BAR_H - 8)
    pctLbl.Font = Enum.Font.GothamBlack
    pctLbl.TextSize = 15
    pctLbl.TextColor3 = Color3.fromRGB(255,255,255)
    pctLbl.TextXAlignment = Enum.TextXAlignment.Right
    pctLbl.Text = "0%"
    pctLbl.ZIndex = 4
    pctLbl.Parent = stealPill
    M.statusPctLbl = pctLbl

    x = x + STEAL_W + GAP

    -- ===== helper: outlined pill placed at absolute x =====
    local function makeInfoPill(px, w, labelText, valueText)
        local pill = Instance.new("Frame")
        pill.Size = UDim2.new(0, w, 1, -14)
        pill.Position = UDim2.new(0, px, 0.5, 0)
        pill.AnchorPoint = Vector2.new(0, 0.5)
        pill.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
        pill.BackgroundTransparency = 0.15
        pill.BorderSizePixel = 0
        pill.Parent = main
        Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)
        local ps = Instance.new("UIStroke", pill)
        ps.Color = ACCENT
        ps.Thickness = 1.2
        ps.Transparency = 0.3
        local lbl = Instance.new("TextLabel", pill)
        lbl.BackgroundTransparency = 1
        lbl.Size = UDim2.new(1, -12, 1, 0)
        lbl.Position = UDim2.fromOffset(8, 0)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Center
        lbl.RichText = true
        lbl.Text = ("<font color=\"#8fb8ff\">%s</font> <b>%s</b>"):format(labelText, valueText)
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        return lbl
    end

    -- FPS pill then PING pill, laid out sequentially
    local fpsPill, pingPill = nil, nil

    local infoLbl = { fps = fpsPill, ping = pingPill }
    M.statusFpsLbl = infoLbl

    -- ===== right-end dot =====
    local dotBg = Instance.new("Frame")
    dotBg.Size = UDim2.fromOffset(28, 28)
    dotBg.Position = UDim2.new(1, -PAD, 0.5, 0)
    dotBg.AnchorPoint = Vector2.new(1, 0.5)
    dotBg.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    dotBg.BorderSizePixel = 0
    dotBg.Parent = main
    Instance.new("UICorner", dotBg).CornerRadius = UDim.new(1, 0)
    local dbStroke = Instance.new("UIStroke", dotBg)
    dbStroke.Color = ACCENT
    dbStroke.Thickness = 1.2
    dbStroke.Transparency = 0.3
    local dot = Instance.new("Frame")
    dot.Size = UDim2.fromOffset(15, 15)
    dot.AnchorPoint = Vector2.new(0.5, 0.5)
    dot.Position = UDim2.fromScale(0.5, 0.5)
    dot.BackgroundColor3 = ACCENT
    dot.BorderSizePixel = 0
    dot.Parent = dotBg
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    M.statusDot = dot

    -- FPS / PING updater
    local frameCount = 0
    local timeAccum = 0
    local fps = 0
    if M._statusFpsConn then pcall(function() M._statusFpsConn:Disconnect() end) M._statusFpsConn=nil end
    M._statusFpsConn = RunService.RenderStepped:Connect(function(delta)
        frameCount = frameCount + 1
        timeAccum = timeAccum + delta
        if timeAccum >= 0.5 then
            fps = math.floor(frameCount / timeAccum + 0.5)
            frameCount = 0
            timeAccum = 0
            local ping = 0
            pcall(function() ping = math.floor(player:GetNetworkPing() * 1000 + 0.5) end)
            if fpsPill and fpsPill.Parent then
                fpsPill.Text = ("<font color=\"#8fb8ff\">FPS</font> <b>%d</b>"):format(fps)
            end
            if pingPill and pingPill.Parent then
                pingPill.Text = ("<font color=\"#8fb8ff\">PING</font> <b>%d ms</b>"):format(ping)
            end
        end
    end)

    -- drag + save position
    local function saveStealBarPos()
        if type(writefile) ~= "function" then return end
        local cur = (M.loadBtnPositions and M.loadBtnPositions()) or {}
        cur["_stealbar"] = {xs=main.Position.X.Scale, xo=main.Position.X.Offset,
                             ys=main.Position.Y.Scale, yo=main.Position.Y.Offset}
        pcall(function() writefile(M.MOB_POS_FILE, HS:JSONEncode(cur)) end)
    end
    do
        local dragging, dragStart, startPos
        main.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                -- normalize anchor to top-left so dragging math is consistent
                if main.AnchorPoint ~= Vector2.new(0,0) then
                    local ap = main.AbsolutePosition
                    main.AnchorPoint = Vector2.new(0,0)
                    main.Position = UDim2.fromOffset(ap.X, ap.Y)
                end
                dragging = true
                dragStart = input.Position
                startPos = main.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        saveStealBarPos()
                    end
                end)
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local d = input.Position - dragStart
                main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)
    end

    M.statusGui = gui
    M.statusMain = main
end

function M.updateStealProgress(progress)
    progress = math.clamp(progress or 0, 0, 1)
    local pct = math.floor(progress * 100)
    if M.statusFill then
        M.statusFill.Size = UDim2.fromScale(progress, 1)
        M.statusFill.Visible = progress > 0
    end
    if M.statusPctLbl then
        M.statusPctLbl.Text = pct .. "%"
    end
end

-- Semi-steal bar driver: the semi loop no longer pokes the fill directly;
-- this heartbeat reads StealState and draws a single smooth ramp (0->100%)
-- over the hold window. When a steal completes it tweens to full instead of
-- snapping, so it behaves like vampirehub.
if M._semiBarConn then pcall(function() M._semiBarConn:Disconnect() end) M._semiBarConn = nil end
M._semiBarShown = 0
M._semiBarConn = RunService.Heartbeat:Connect(function()
    if M.stealMode ~= "Semi" then return end
    if not M.statusFill or not M.statusPctLbl then return end
    local st = M.Semi and M.Semi.StealState
    if not st then return end
    local active = st.active
    local justFinished = st.lastResultTime and st.lastResultTime > 0 and (tick() - st.lastResultTime) < 1.0
    if active then
        -- smooth linear ramp across the full hold window
        local dur = math.max(M.Semi.HoldMax or 2.6, 0.01)
        local target = math.clamp((tick() - (st.startTime or tick())) / dur, 0, 1)
        -- ease toward target so it never jumps
        M._semiBarShown = M._semiBarShown + (target - M._semiBarShown) * 0.25
        local shown = math.clamp(M._semiBarShown, 0, 1)
        M.statusFill.Visible = true
        M.statusFill.Size = UDim2.fromScale(shown, 1)
        M.statusPctLbl.Text = math.floor(shown * 100) .. "%"
    elseif justFinished then
        -- glide the remainder to 100% instead of snapping
        M._semiBarShown = M._semiBarShown + (1 - M._semiBarShown) * 0.3
        local shown = math.clamp(M._semiBarShown, 0, 1)
        M.statusFill.Visible = true
        M.statusFill.Size = UDim2.fromScale(shown, 1)
        M.statusPctLbl.Text = math.floor(shown * 100) .. "%"
    else
        M._semiBarShown = 0
        M.statusFill.Visible = false
        M.statusFill.Size = UDim2.fromScale(0, 1)
        M.statusPctLbl.Text = "0%"
    end
end)

function M.updateStatusRadius()
    -- new pill status bar has no radius label; nothing to update
end

-- ============================================================
-- AUTO STEAL (unchanged)
-- ============================================================
if not fireproximityprompt then
    fireproximityprompt = (getgenv and getgenv().fireproximityprompt)
        or (genv and genv().fireproximityprompt)
        or function(prompt)
            pcall(function()
                prompt:InputHoldBegin()
                task.wait(0.05)
                prompt:InputHoldEnd()
            end)
        end
end

local function isMyPlot(plotName)
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return false end
    local plot = plots:FindFirstChild(plotName)
    if not plot then return false end
    local sign = plot:FindFirstChild("PlotSign")
    if sign then
        local yb = sign:FindFirstChild("YourBase")
        if yb and yb:IsA("BillboardGui") then return yb.Enabled == true end
    end
    return false
end

local function scanPlotNormal(plot)
    if not plot or not plot:IsA("Model") then return end
    if isMyPlot(plot.Name) then return end
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return end
    for _, pod in ipairs(podiums:GetChildren()) do
        if pod:IsA("Model") and pod:FindFirstChild("Base") then
            local uid = plot.Name .. "_" .. pod.Name
            for _, ex in ipairs(M.animalCache) do if ex.uid == uid then return end end
            table.insert(M.animalCache, {
                name = pod.Name,
                plot = plot.Name,
                slot = pod.Name,
                worldPosition = pod:GetPivot().Position,
                uid = uid,
            })
        end
    end
end

local function findPromptNormal(ad)
    if not ad then return nil end
    local cp = M.promptCache[ad.uid]
    if cp and cp.Parent then return cp end
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    local plot = plots:FindFirstChild(ad.plot)
    if not plot then return nil end
    local pods = plot:FindFirstChild("AnimalPodiums")
    if not pods then return nil end
    local pod = pods:FindFirstChild(ad.slot)
    if not pod then return nil end
    local base = pod:FindFirstChild("Base")
    if not base then return nil end
    local spawn = base:FindFirstChild("Spawn")
    if not spawn then return nil end
    local att = spawn:FindFirstChild("PromptAttachment")
    local prompt = nil
    if att then
        for _, p in ipairs(att:GetChildren()) do
            if p:IsA("ProximityPrompt") then prompt = p; break end
        end
    end
    if not prompt then
        for _, obj in ipairs(spawn:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then prompt = obj; break end
        end
    end
    if prompt then M.promptCache[ad.uid] = prompt end
    return prompt
end

local function nearestAnimalNormal()
    local char = player.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso")
    if not hrp then return nil end
    local best, bestD = nil, math.huge
    for _, ad in ipairs(M.animalCache) do
        if not isMyPlot(ad.plot) and ad.worldPosition then
            local d = (hrp.Position - ad.worldPosition).Magnitude
            if d < bestD then bestD = d; best = ad end
        end
    end
    return best, bestD
end

local function buildCallbacks(prompt)
    if M.stealCache[prompt] then return end
    local data = { holdCallbacks = {}, triggerCallbacks = {}, ready = true }
    local ok1, c1 = pcall(getconnections, prompt.PromptButtonHoldBegan)
    if ok1 and type(c1) == "table" then
        for _, conn in ipairs(c1) do
            if type(conn.Function) == "function" then
                table.insert(data.holdCallbacks, conn.Function)
            end
        end
    end
    local ok2, c2 = pcall(getconnections, prompt.Triggered)
    if ok2 and type(c2) == "table" then
        for _, conn in ipairs(c2) do
            if type(conn.Function) == "function" then
                table.insert(data.triggerCallbacks, conn.Function)
            end
        end
    end
    if #data.holdCallbacks > 0 or #data.triggerCallbacks > 0 then
        M.stealCache[prompt] = data
    end
end

local function execStealNormal(prompt, animalName)
    local data = M.stealCache[prompt]
    if not data or not data.ready then return false end
    data.ready = false
    M.isStealing = true
    M.stealStartTime = tick()
    M.updateStealProgress(0.1)

    if M.progressConn then M.progressConn:Disconnect() end
    M.progressConn = RunService.Heartbeat:Connect(function()
        if not M.isStealing then
            M.progressConn:Disconnect()
            M.progressConn = nil
            return
        end
        local prog = math.clamp((tick() - M.stealStartTime) / M.Steal.StealDuration, 0, 1)
        M.updateStealProgress(prog)
    end)

    task.spawn(function()
        for _, fn in ipairs(data.holdCallbacks) do task.spawn(fn) end
        local elapsed = 0
        while elapsed < M.Steal.StealDuration do elapsed = elapsed + task.wait() end
        for _, fn in ipairs(data.triggerCallbacks) do task.spawn(fn) end
        task.wait(0.01)
        if M.progressConn then M.progressConn:Disconnect(); M.progressConn = nil end
        M.isStealing = false
        M.updateStealProgress(0)
        data.ready = true
    end)
    return true
end

function M.startNormalSteal()
    if M.stealConn then return end
    M.stealConn = RunService.Heartbeat:Connect(function()
        if not M.Steal.AutoStealEnabled or M.stealMode ~= "Normal" or M.isStealing then return end
        local target, dist = nearestAnimalNormal()
        if not target then return end
        if dist > M.Steal.StealRadius then return end
        local prompt = M.promptCache[target.uid]
        if not prompt or not prompt.Parent then
            prompt = findPromptNormal(target)
        end
        if prompt then
            buildCallbacks(prompt)
            execStealNormal(prompt, target.name)
        end
    end)
end

function M.stopNormalSteal()
    if M.stealConn then
        M.stealConn:Disconnect()
        M.stealConn = nil
    end
    M.isStealing = false
    if M.progressConn then M.progressConn:Disconnect(); M.progressConn = nil end
    M.updateStealProgress(0)
end

-- ============================================================
-- SEMI AUTO-STEAL (unchanged)
-- ============================================================
M.Semi = M.Semi or {}
M.Semi.HoldMin = 1.3
M.Semi.HoldMax = 2.6
M.Semi.EntryDelay = 0.3
M.Semi.Cooldown = 0.05
M.Semi.StealRange = 9
M.Semi.PrimeRange = 80
M.Semi.allAnimalsCache = {}
M.Semi.PromptMemoryCache = {}
M.Semi.InternalStealCache = {}
M.Semi.stealConnection = nil
M.Semi.StealState = {
    active = false,
    startTime = 0,
    phase = "idle",
    label = "",
    lastResult = "",
    lastResultTime = 0,
    totalSteals = 0,
    failedSteals = 0,
}
M.Semi.plots = workspace:WaitForChild("Plots")
M.Semi.AnimalsData = nil
M.Semi.initialized = false

function M.initSemiSync()
    if M.Semi.initialized then return end
    local RS = game:GetService("ReplicatedStorage")
    local Packages = RS:WaitForChild("Packages")
    local Datas = RS:WaitForChild("Datas")
    M.Semi.AnimalsData = require(Datas:WaitForChild("Animals"))

    local folder = Packages:WaitForChild("Synchronizer")
    M.Semi.syncRemotes = {
        channelFolder = folder:WaitForChild("Channel"),
        routeRemote = folder:WaitForChild("CommunicationRoute"),
        requestData = folder:FindFirstChild("RequestData"),
    }

    local function splitSyncPath(path)
        if typeof(path) == "table" then return path end
        local out = {}
        for part in string.gmatch(tostring(path), "[^%.]+") do
            table.insert(out, tonumber(part) or part)
        end
        return out
    end

    local function resolveSyncPath(path, root)
        local current = root
        local parent = nil
        local key = nil
        for _, part in ipairs(splitSyncPath(path)) do
            parent = current
            key = part
            current = current and current[part] or nil
        end
        return current, parent, key
    end

    local function applyPlotSyncDiff(channelName, packet)
        local cache = M.Semi.plotAnimalSync.caches[channelName]
        if typeof(cache) ~= "table" then return end
        local path, action, a, b = packet[1], packet[2], packet[3], packet[4]
        local current, parent, key = resolveSyncPath(path, cache)
        if action == "Changed" then
            if parent ~= nil then parent[key] = a end
        elseif action == "ArrayInsert" then
            if current ~= nil then table.insert(current, b, a) end
        elseif action == "ArrayRemoved" then
            if current ~= nil then table.remove(current, b) end
        elseif action == "DictionaryInsert" then
            if current ~= nil then current[b] = a end
        elseif action == "DictionaryRemoved" then
            if current ~= nil then current[b] = nil end
        end
    end

    local function attachPlotChannel(remote)
        if M.Semi.plotAnimalSync.connections[remote] then return end
        local channelName = tostring(remote.Name)
        if not M.Semi.plots:FindFirstChild(channelName) then return end
        if M.Semi.syncRemotes.requestData and M.Semi.plotAnimalSync.caches[channelName] == nil then
            local ok, data = pcall(function()
                return M.Semi.syncRemotes.requestData:InvokeServer(channelName)
            end)
            if ok and typeof(data) == "table" then
                M.Semi.plotAnimalSync.caches[channelName] = data
            else
                M.Semi.plotAnimalSync.caches[channelName] = {}
            end
        elseif M.Semi.plotAnimalSync.caches[channelName] == nil then
            M.Semi.plotAnimalSync.caches[channelName] = {}
        end
        M.Semi.plotAnimalSync.connections[remote] = remote.OnClientEvent:Connect(function(queue)
            for _, packet in ipairs(queue) do
                applyPlotSyncDiff(channelName, packet)
            end
        end)
    end

    local function detachPlotChannel(channelName)
        for remote, conn in pairs(M.Semi.plotAnimalSync.connections) do
            if tostring(remote.Name) == tostring(channelName) then
                conn:Disconnect()
                M.Semi.plotAnimalSync.connections[remote] = nil
                M.Semi.plotAnimalSync.caches[tostring(channelName)] = nil
                break
            end
        end
    end

    for _, child in ipairs(M.Semi.syncRemotes.channelFolder:GetChildren()) do
        if child:IsA("RemoteEvent") then attachPlotChannel(child) end
    end
    M.Semi.syncRemotes.channelFolder.ChildAdded:Connect(function(child)
        if child:IsA("RemoteEvent") then attachPlotChannel(child) end
    end)
    M.Semi.syncRemotes.routeRemote.OnClientEvent:Connect(function(actions)
        for _, action in ipairs(actions) do
            local kind, channelName = action[1], tostring(action[2])
            if not M.Semi.plots:FindFirstChild(channelName) then continue end
            if kind == "ListenerAdded" then
                local remote = M.Semi.syncRemotes.channelFolder:FindFirstChild(channelName)
                if remote and remote:IsA("RemoteEvent") then attachPlotChannel(remote) end
            elseif kind == "ListenerRemoved" then
                detachPlotChannel(channelName)
            end
        end
    end)
    M.Semi.initialized = true
end

function M.getPlotChannelData(plotName)
    return M.Semi.plotAnimalSync.caches[plotName]
end

function M.getPlotOwner(plot)
    local sign = plot:FindFirstChild("PlotSign")
    local frame = sign and sign:FindFirstChild("SurfaceGui") and sign.SurfaceGui:FindFirstChild("Frame")
    local label = frame and frame:FindFirstChild("TextLabel")
    if not label or label.Text == "Empty Base" then return nil end
    return label.Text:gsub("'s [Bb]ase$", ""):gsub("%s+$", "")
end

function M.isMyBaseAnimalSemi(animalData)
    if not animalData or not animalData.plot then return false end
    local plot = M.Semi.plots:FindFirstChild(animalData.plot)
    if not plot then return false end
    return M.getPlotOwner(plot) == player.DisplayName
end

function M.findProximityPromptForAnimalSemi(animalData)
    if not animalData then return nil end
    local cached = M.Semi.PromptMemoryCache[animalData.uid]
    if cached and cached.Parent then return cached end
    local plot = M.Semi.plots:FindFirstChild(animalData.plot)
    if not plot then return nil end
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return nil end
    local podium = podiums:FindFirstChild(animalData.slot)
    if not podium then return nil end
    local base = podium:FindFirstChild("Base")
    if not base then return nil end
    local spawn = base:FindFirstChild("Spawn")
    if not spawn then return nil end
    local attach = spawn:FindFirstChild("PromptAttachment")
    if not attach then return nil end
    for _, p in ipairs(attach:GetChildren()) do
        if p:IsA("ProximityPrompt") then
            M.Semi.PromptMemoryCache[animalData.uid] = p
            return p
        end
    end
    return nil
end

function M.getAnimalPositionSemi(animalData)
    local plot = M.Semi.plots:FindFirstChild(animalData.plot)
    if not plot then return nil end
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return nil end
    local podium = podiums:FindFirstChild(animalData.slot)
    if not podium then return nil end
    return podium:GetPivot().Position
end

function M.distToAnimalSemi(animalData)
    local char = player.Character
    if not char then return math.huge end
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso")
    if not hrp then return math.huge end
    local pos = M.getAnimalPositionSemi(animalData)
    if not pos then return math.huge end
    return (hrp.Position - pos).Magnitude
end

function M.pickClosestSemi()
    local char = player.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso")
    if not hrp then return nil end
    local best, bestDist = nil, math.huge
    for _, animalData in ipairs(M.Semi.allAnimalsCache) do
        if M.isMyBaseAnimalSemi(animalData) then continue end
        local pos = M.getAnimalPositionSemi(animalData)
        if not pos then continue end
        local dist = (hrp.Position - pos).Magnitude
        if dist > M.Semi.PrimeRange then continue end
        if dist < bestDist then
            bestDist = dist
            best = animalData
        end
    end
    return best
end

function M.buildStealCallbacksSemi(prompt)
    if M.Semi.InternalStealCache[prompt] then return end
    local data = { holdCallbacks = {}, triggerCallbacks = {}, ready = true }
    local ok1, conns1 = pcall(getconnections, prompt.PromptButtonHoldBegan)
    if ok1 and type(conns1) == "table" then
        for _, conn in ipairs(conns1) do
            if type(conn.Function) == "function" then
                table.insert(data.holdCallbacks, conn.Function)
            end
        end
    end
    local ok2, conns2 = pcall(getconnections, prompt.Triggered)
    if ok2 and type(conns2) == "table" then
        for _, conn in ipairs(conns2) do
            if type(conn.Function) == "function" then
                table.insert(data.triggerCallbacks, conn.Function)
            end
        end
    end
    if #data.holdCallbacks > 0 or #data.triggerCallbacks > 0 then
        M.Semi.InternalStealCache[prompt] = data
    end
end

function M.executeStealAsyncSemi(prompt, animalData)
    local data = M.Semi.InternalStealCache[prompt]
    if not data or not data.ready then return false end
    data.ready = false
    local label = animalData.name or "Animal"
    M.Semi.StealState.active = true
    M.Semi.StealState.startTime = tick()
    M.Semi.StealState.phase = "holding"
    M.Semi.StealState.label = label
    M.isStealing = true
    M.stealStartTime = tick()

    task.spawn(function()
        for _, fn in ipairs(data.holdCallbacks) do task.spawn(fn) end
        task.wait(M.Semi.HoldMin)
        M.Semi.StealState.phase = "waitingRange"
        local alreadyInRange = M.distToAnimalSemi(animalData) <= M.Semi.StealRange
        local fired = false
        while true do
            local elapsed = tick() - M.Semi.StealState.startTime
            if elapsed > M.Semi.HoldMax then break end
            if not prompt.Parent then break end
            if M.distToAnimalSemi(animalData) <= M.Semi.StealRange then
                if not alreadyInRange then task.wait(M.Semi.EntryDelay) end
                for _, fn in ipairs(data.triggerCallbacks) do task.spawn(fn) end
                fired = true
                break
            end
            task.wait()
        end
        if fired then
            M.Semi.StealState.totalSteals = M.Semi.StealState.totalSteals + 1
            M.Semi.StealState.lastResult = "Stole " .. label
        else
            M.Semi.StealState.failedSteals = M.Semi.StealState.failedSteals + 1
            M.Semi.StealState.lastResult = "Missed window: " .. label
        end
        M.Semi.StealState.active = false
        M.Semi.StealState.phase = "idle"
        M.Semi.StealState.lastResultTime = tick()
        task.wait(0.05)
        M.isStealing = false
        data.ready = true
    end)
    return true
end

function M.attemptStealSemi(prompt, animalData)
    if not prompt or not prompt.Parent then return false end
    M.buildStealCallbacksSemi(prompt)
    if not M.Semi.InternalStealCache[prompt] then return false end
    return M.executeStealAsyncSemi(prompt, animalData)
end

function M.scanAllPlotsSemi()
    if not M.Semi.plots then return 0 end
    local newCache = {}
    for _, plot in ipairs(M.Semi.plots:GetChildren()) do
        local cache = M.getPlotChannelData(plot.Name)
        if not cache then continue end
        local animalList = cache.AnimalList
        if typeof(animalList) ~= "table" then continue end
        for slot, animalData in pairs(animalList) do
            if type(animalData) == "table" then
                local animalName = animalData.Index
                local animalInfo = M.Semi.AnimalsData and M.Semi.AnimalsData[animalName]
                if not animalInfo then continue end
                table.insert(newCache, {
                    name = animalInfo.DisplayName or animalName,
                    plot = plot.Name,
                    slot = tostring(slot),
                    uid = plot.Name .. "_" .. tostring(slot),
                })
            end
        end
    end
    M.Semi.allAnimalsCache = newCache
    return #newCache
end

function M.startSemiSteal()
    if M.Semi.stealConnection then return end
    M.initSemiSync()
    M.scanAllPlotsSemi()
    M.Semi.stealConnection = RunService.Heartbeat:Connect(function()
        if not M.Steal.AutoStealEnabled or M.stealMode ~= "Semi" or M.isStealing then return end
        if M.Semi.StealState.active then return end
        local target = M.pickClosestSemi()
        if not target then return end
        local prompt = M.Semi.PromptMemoryCache[target.uid]
        if not prompt or not prompt.Parent then
            prompt = M.findProximityPromptForAnimalSemi(target)
        end
        if prompt then M.attemptStealSemi(prompt, target) end
    end)
end

function M.stopSemiSteal()
    if M.Semi.stealConnection then
        M.Semi.stealConnection:Disconnect()
        M.Semi.stealConnection = nil
    end
    M.isStealing = false
    M.updateStealProgress(0)
end

function M.startAutoSteal()
    if M.statusGui then M.statusGui.Enabled = true end
    if M.stealMode == "Normal" then
        M.startNormalSteal()
    else
        M.startSemiSteal()
    end
end

function M.stopAutoSteal()
    if M.statusGui then M.statusGui.Enabled = true end
    if M.stealMode == "Normal" then
        M.stopNormalSteal()
    else
        M.stopSemiSteal()
    end
    M.isStealing = false
    M.updateStealProgress(0)
end

function M.setStealRadius(radius)
    M.Steal.StealRadius = radius
    M.updateStatusRadius()
end

-- ============================================================
-- OTHER CORE FUNCTIONS (unchanged)
-- ============================================================
function M.findBat()
    local char=player.Character;if not char then return nil end
    for _,tool in ipairs(char:GetChildren()) do if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then return tool end end
    local bp=player:FindFirstChild("Backpack");if bp then for _,tool in ipairs(bp:GetChildren()) do if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then return tool end end end
    return nil
end

function M.findMedusa()
    local c=player.Character;if not c then return nil end
    for _,t in ipairs(c:GetChildren()) do if t:IsA("Tool") then local n=t.Name:lower();if n:find("medusa") or n:find("head") or n:find("stone") then return t end end end
    local bp=player:FindFirstChild("Backpack");if bp then for _,t in ipairs(bp:GetChildren()) do if t:IsA("Tool") then local n=t.Name:lower();if n:find("medusa") or n:find("head") or n:find("stone") then return t end end end end
    return nil
end

function M.useMedusaCounter()
    if M.medusaDebounce then return end;if M.MEDUSA_COOLDOWN>(tick()-M.medusaLastUsed) then return end
    local c=player.Character;if not c then return end;M.medusaDebounce=true
    local med=M.findMedusa();if not med then M.medusaDebounce=false;return end
    if med.Parent~=c then local hum2=c:FindFirstChildOfClass("Humanoid");if hum2 then hum2:EquipTool(med) end end
    pcall(function() med:Activate() end);M.medusaLastUsed=tick();M.medusaDebounce=false
end

function M.onAnchorChanged(part)
    return part:GetPropertyChangedSignal("Anchored"):Connect(function()
        if part.Anchored and part.Transparency==1 then
            if M.medusaCounterEnabled then
                M.useMedusaCounter()
            end
        end
    end)
end

function M.setupMedusa(char)
    for _,c in pairs(M.Conns.anchor) do pcall(function() c:Disconnect() end) end;M.Conns.anchor={}
    if not char then return end
    for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then table.insert(M.Conns.anchor,M.onAnchorChanged(part)) end end
    table.insert(M.Conns.anchor,char.DescendantAdded:Connect(function(part) if part:IsA("BasePart") then table.insert(M.Conns.anchor,M.onAnchorChanged(part)) end end))
end

function M.stopMedusaCounter() for _,c in pairs(M.Conns.anchor) do pcall(function() c:Disconnect() end) end;M.Conns.anchor={} end

function M.findBatForCounter()
    local c=player.Character;if not c then return nil end;local bp=player:FindFirstChildOfClass("Backpack")
    for _,name in ipairs(M.BAT_COUNTER_SLAP_LIST) do local t=c:FindFirstChild(name) or (bp and bp:FindFirstChild(name));if t then return t end end
    for _,ch in ipairs(c:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end
    if bp then for _,ch in ipairs(bp:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end end
    return nil
end

function M.swingBatForCounter(bat,char)
    local hum2=char:FindFirstChildOfClass("Humanoid")
    if bat.Parent~=char then if hum2 then pcall(function() hum2:EquipTool(bat) end) end;task.wait(0.05) end
    local remote=bat:FindFirstChildOfClass("RemoteEvent") or bat:FindFirstChildOfClass("RemoteFunction")
    if remote and remote:IsA("RemoteEvent") then pcall(function() remote:FireServer() end);task.wait(0.15);pcall(function() remote:FireServer() end)
    else pcall(function() bat:Activate() end);task.wait(0.15);pcall(function() bat:Activate() end) end
end

function M.startBatCounter()
    if M.Conns.batCounter then return end
    M.Conns.batCounter=RunService.Heartbeat:Connect(function()
        if not M.batCounterEnabled or M.batCounterDebounce then return end
        local char=player.Character;if not char then return end;local hum2=char:FindFirstChildOfClass("Humanoid");if not hum2 then return end
        local st=hum2:GetState()
        if st==Enum.HumanoidStateType.Physics or st==Enum.HumanoidStateType.Ragdoll or st==Enum.HumanoidStateType.FallingDown then
            M.batCounterDebounce=true;task.spawn(function() local bat=M.findBatForCounter();if bat then M.swingBatForCounter(bat,char) end;task.wait(0.5);M.batCounterDebounce=false end)
        end
    end)
end

function M.stopBatCounter() if M.Conns.batCounter then M.Conns.batCounter:Disconnect();M.Conns.batCounter=nil end;M.batCounterDebounce=false end

-- ============================================================
-- SIMPLIFIED BAT AIMBOT (for Auto Bat)
-- ============================================================
function M.findBatForAimbot()
    local char = player.Character
    if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then
            return tool
        end
    end
    local bp = player:FindFirstChild("Backpack")
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then
                return tool
            end
        end
    end
    return nil
end

function M.getClosestTargetAimbot()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local closest, minDist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if tRoot and hum and hum.Health > 0 then
                local dist = (tRoot.Position - root.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = tRoot
                end
            end
        end
    end
    return closest
end

function M.startBatAimbot()
    if M.aimbotConn then M.aimbotConn:Disconnect() end

    if M.autoLeftEnabled then
        M.autoLeftEnabled = false
        if M.autoLeftSetVisual then M.autoLeftSetVisual(false) end
        M.stopAutoLeft()
    end
    if M.autoRightEnabled then
        M.autoRightEnabled = false
        if M.autoRightSetVisual then M.autoRightSetVisual(false) end
        M.stopAutoRight()
    end

    M.autoBatEnabled = true
    if M.autoTPEnabled then
        if M.autoTPConn then task.cancel(M.autoTPConn); M.autoTPConn = nil end
        if M.setAutoTPVisual then M.setAutoTPVisual(true) end
    end

    local hum0 = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum0 then hum0.AutoRotate = false end

    M.aimbotConn = RunService.RenderStepped:Connect(function()
        if not M.autoBatEnabled then return end

        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end

        if not char:FindFirstChildOfClass("Tool") then
            local bat = M.findBatForAimbot()
            if bat then pcall(function() hum:EquipTool(bat) end) end
        end

        local target = M.getClosestTargetAimbot()
        if not target then
            M._aimbotTarget = nil
            M.swingCurrentBatAimbot(char)
            return
        end
        M._aimbotTarget = target

        local targetVel = target.AssemblyLinearVelocity
        local myPos = root.Position
        local targetPos = target.Position

        local predictPos = targetPos + targetVel * 0.14 + target.CFrame.LookVector * 0.3
        local direction = predictPos - myPos
        local flatDir = Vector3.new(direction.X, 0, direction.Z).Unit

        local chaseSpeed = M.aimbotSpeed or 58
        local desiredHeight = targetPos.Y + 3.7
        local yVel = (desiredHeight - myPos.Y) * 19.5 + targetVel.Y * 0.8

        if hum.FloorMaterial ~= Enum.Material.Air then
            yVel = math.max(yVel, 13)
        end
        yVel = math.clamp(yVel, -70, 110)

        local desiredVel = Vector3.new(flatDir.X * chaseSpeed, yVel, flatDir.Z * chaseSpeed)
        root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(desiredVel, 0.8)

        local speed3 = targetVel.Magnitude
        local predictTime = math.clamp(speed3 / 150, 0.05, 0.2)
        local predictedPos = targetPos + targetVel * predictTime

        local toPredict = predictedPos - myPos
        if toPredict.Magnitude > 0.1 then
            local goalCF = CFrame.lookAt(myPos, predictedPos)
            local diffCF = root.CFrame:Inverse() * goalCF
            local rx, ry, rz = diffCF:ToEulerAnglesXYZ()
            rx = math.clamp(rx, -2.5, 2.5)
            ry = math.clamp(ry, -2.5, 2.5)
            rz = math.clamp(rz, -2.5, 2.5)
            root.AssemblyAngularVelocity = root.CFrame:VectorToWorldSpace(Vector3.new(rx*42, ry*42, rz*42))
        end

        M.swingCurrentBatAimbot(char)
    end)

    if M.autoBatSetVisual then M.autoBatSetVisual(true) end
    if M.mobBtnRefs.autoBat then M.mobBtnRefs.autoBat(true) end
end

function M.stopBatAimbot()
    if M.aimbotConn then
        M.aimbotConn:Disconnect()
        M.aimbotConn = nil
    end
    M._aimbotTarget = nil
    M.autoBatEnabled = false

    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end
    local hum2 = char and char:FindFirstChildOfClass("Humanoid")
    if hum2 then hum2.AutoRotate = true end

    if M.autoTPEnabled then M.startAutoTP() end
    if M.autoBatSetVisual then M.autoBatSetVisual(false) end
    if M.mobBtnRefs.autoBat then M.mobBtnRefs.autoBat(false) end
end

function M.queueAutoBatStart()
    if M.antiKickEnabled and M.brainrotDetected then return end
    if M.autoLeftEnabled then M.autoLeftEnabled=false; if M.autoLeftSetVisual then M.autoLeftSetVisual(false) end; M.stopAutoLeft() end
    if M.autoRightEnabled then M.autoRightEnabled=false; if M.autoRightSetVisual then M.autoRightSetVisual(false) end; M.stopAutoRight() end
    M.startBatAimbot()
end

function M.swingCurrentBatAimbot(char)
    if not M.autoSwingEnabled then return end
    local bat = M.findBatForAimbot()
    if bat and bat.Parent == char then
        pcall(function() bat:Activate() end)
    end
end

-- ============================================================
-- BYPASS AIMBOT (Dual Mode: Normal & TP Bat)
-- ============================================================
local function _bypassFindBat()
    local char = player.Character
    if not char then return nil end
    local BAT_LIST = {
        "Bat", "Slap", "Iron Slap", "Gold Slap", "Diamond Slap",
        "Emerald Slap", "Ruby Slap", "Dark Matter Slap", "Flame Slap",
        "Nuclear Slap", "Galaxy Slap", "Glitched Slap"
    }
    for _, name in ipairs(BAT_LIST) do
        local t = char:FindFirstChild(name)
        if t and t:IsA("Tool") then return t end
    end
    local bp = player:FindFirstChildOfClass("Backpack")
    if bp then
        for _, name in ipairs(BAT_LIST) do
            local t = bp:FindFirstChild(name)
            if t and t:IsA("Tool") then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum:EquipTool(t) end) end
                return t
            end
        end
    end
    return nil
end

local function _bypassTrySwing()
    if M.bypassHitCD then return end
    M.bypassHitCD = true
    pcall(function()
        local bat = _bypassFindBat()
        if bat then
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and bat.Parent ~= char then
                pcall(function() hum:EquipTool(bat) end)
            end
            pcall(function() bat:Activate() end)
        end
    end)
    task.delay(M.bypassSwingCD, function() M.bypassHitCD = false end)
end

local function _bypassGetClosest()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil, math.huge end
    local closest, minDist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if tRoot and hum and hum.Health > 0 then
                local dist = (tRoot.Position - root.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = tRoot
                end
            end
        end
    end
    return closest, minDist
end

-- Normal mode (no teleport, just chase and swing)
function M.startNormalBypassAimbot()
    if M.bypassAimbotConn then M.bypassAimbotConn:Disconnect() end

    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum and M.bypassPrevAutoRotate == nil then
        M.bypassPrevAutoRotate = hum.AutoRotate
    end
    if hum then hum.AutoRotate = false end

    M.bypassAimbotConn = RunService.RenderStepped:Connect(function()
        if not M.bypassAimbotEnabled or M.bypassAimbotMode ~= "Normal" then return end

        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end

        if not char:FindFirstChildOfClass("Tool") then
            local bat = _bypassFindBat()
            if bat then pcall(function() hum:EquipTool(bat) end) end
        end

        local target, targetDist = _bypassGetClosest()
        if not target then return end

        local myPos = root.Position
        local targetPos = target.Position

        local direction = targetPos - myPos
        local flatDir = Vector3.new(direction.X, 0, direction.Z)
        if flatDir.Magnitude > 0 then flatDir = flatDir.Unit else flatDir = Vector3.zero end

        local chaseSpeed = 58
        local desiredHeight = targetPos.Y + 3.7
        local yVel = (desiredHeight - myPos.Y) * 19.5
        if hum.FloorMaterial ~= Enum.Material.Air then yVel = math.max(yVel, 13) end
        yVel = math.clamp(yVel, -70, 110)

        local desiredVel = Vector3.new(flatDir.X * chaseSpeed, yVel, flatDir.Z * chaseSpeed)
        root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(desiredVel, 0.8)

        local toTarget = targetPos - myPos
        if toTarget.Magnitude > 0.1 then
            local goalCF = CFrame.lookAt(myPos, targetPos)
            local diffCF = root.CFrame:Inverse() * goalCF
            local rx, ry, rz = diffCF:ToEulerAnglesXYZ()
            rx = math.clamp(rx, -2.5, 2.5)
            ry = math.clamp(ry, -2.5, 2.5)
            rz = math.clamp(rz, -2.5, 2.5)
            root.AssemblyAngularVelocity = root.CFrame:VectorToWorldSpace(Vector3.new(rx * 42, ry * 42, rz * 42))
        end

        if targetDist <= M.bypassHitDist then _bypassTrySwing() end
    end)
end

-- TP Bat mode (existing teleport + sethiddenproperty)
function M.startTPBatBypassAimbot()
    if M.bypassAimbotConn then M.bypassAimbotConn:Disconnect() end

    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum and M.bypassPrevAutoRotate == nil then
        M.bypassPrevAutoRotate = hum.AutoRotate
    end
    if hum then hum.AutoRotate = false end

    local char = player.Character
    M._bypassHRP = char and char:FindFirstChild("HumanoidRootPart")
    M._bypassHum = hum

    M.bypassAimbotConn = RunService.RenderStepped:Connect(function()
        if not M.bypassAimbotEnabled or M.bypassAimbotMode ~= "TPBat" then return end

        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end

        if not char:FindFirstChildOfClass("Tool") then
            local bat = _bypassFindBat()
            if bat then pcall(function() hum:EquipTool(bat) end) end
        end

        local target, targetDist = _bypassGetClosest()
        if not target then return end

        local myPos = root.Position
        local targetPos = target.Position

        local direction = targetPos - myPos
        local flatDir = Vector3.new(direction.X, 0, direction.Z)
        if flatDir.Magnitude > 0 then flatDir = flatDir.Unit else flatDir = Vector3.zero end

        local chaseSpeed = 58
        local desiredHeight = targetPos.Y + 3.7
        local yVel = (desiredHeight - myPos.Y) * 19.5
        if hum.FloorMaterial ~= Enum.Material.Air then yVel = math.max(yVel, 13) end
        yVel = math.clamp(yVel, -70, 110)

        local desiredVel = Vector3.new(flatDir.X * chaseSpeed, yVel, flatDir.Z * chaseSpeed)
        root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(desiredVel, 0.8)

        local toTarget = targetPos - myPos
        if toTarget.Magnitude > 0.1 then
            local goalCF = CFrame.lookAt(myPos, targetPos)
            local diffCF = root.CFrame:Inverse() * goalCF
            local rx, ry, rz = diffCF:ToEulerAnglesXYZ()
            rx = math.clamp(rx, -2.5, 2.5)
            ry = math.clamp(ry, -2.5, 2.5)
            rz = math.clamp(rz, -2.5, 2.5)
            root.AssemblyAngularVelocity = root.CFrame:VectorToWorldSpace(Vector3.new(rx * 42, ry * 42, rz * 42))
        end

        if targetDist <= M.bypassHitDist then _bypassTrySwing() end
    end)

    task.spawn(function()
        while M.bypassAimbotEnabled and M.bypassAimbotMode == "TPBat" do
            task.wait(0.05)
            if not M.bypassAimbotEnabled or M.bypassAimbotMode ~= "TPBat" then break end
            local target = _bypassGetClosest()
            if not target then continue end
            local hrp = M._bypassHRP
            if not hrp then
                local char = player.Character
                hrp = char and char:FindFirstChild("HumanoidRootPart")
                M._bypassHRP = hrp
            end
            if not hrp then continue end

            local targetPos = target.Position + Vector3.new(0, 0.9, 0)
            if (hrp.Position - targetPos).Magnitude > 8 then
                hrp.CFrame = CFrame.new(targetPos)
            end

            local cam = workspace.CurrentCamera
            if cam then
                cam.CFrame = CFrame.new(cam.CFrame.Position, target.Position)
            end

            if sethiddenproperty then
                pcall(function()
                    sethiddenproperty(hrp, "PhysicsRepRootPart", target)
                end)
            end
        end
    end)
end

function M.startBypassAimbot()
    if M.bypassAimbotMode == "TPBat" then
        M.startTPBatBypassAimbot()
    else
        M.startNormalBypassAimbot()
    end
end

function M.stopBypassAimbot()
    if M.bypassAimbotConn then
        M.bypassAimbotConn:Disconnect()
        M.bypassAimbotConn = nil
    end

    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end

    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.AutoRotate = (M.bypassPrevAutoRotate == nil) and true or M.bypassPrevAutoRotate
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
    end

    M.bypassHitCD = false
end

function M.toggleBypassAimbot()
    M.bypassAimbotEnabled = not M.bypassAimbotEnabled
    if M.bypassAimbotEnabled then
        M.startBypassAimbot()
    else
        M.stopBypassAimbot()
    end
    if M.setBypassVisual then
        M.setBypassVisual(M.bypassAimbotEnabled)
    end
    if M.mobBtnRefs.bypass then
        M.mobBtnRefs.bypass(M.bypassAimbotEnabled)
    end
    saveCherryConfig()
    return M.bypassAimbotEnabled
end

-- ============================================================
-- MEDUSA RESET (New robust implementation)
-- ============================================================
local _resetRemote = nil
local _resetCooldown = false
local _romDebounce = false
local romConns = {}

local function doInstantReset()
    if _resetCooldown then return end
    if not _resetRemote then
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hum then hum.Health = 0 end
            if hrp then hrp.CFrame = CFrame.new(0, 999999, 0) end
            char:BreakJoints()
        end
        return
    end
    _resetCooldown = true
    local oldChar = player.Character
    task.spawn(function()
        while player.Character == oldChar do
            pcall(function() _resetRemote:FireServer(M.CURSED_RESET_GUID, player, "balloon") end)
            task.wait()
        end
        _resetCooldown = false
    end)
end

pcall(function()
    local orig_fire
    orig_fire = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
        if not _resetRemote and type(self.Name) == "string" and self.Name:sub(1,3) == "RE/" then
            _resetRemote = self
        end
        return orig_fire(self, ...)
    end))
end)

pcall(function()
    local orig_fire_med
    orig_fire_med = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
        if type(self.Name) == "string" then
            local name = self.Name
            if name:find("Med") or name:find("Heal") or name:find("Bandage") then
                if not _romDebounce and M.medusaResetEnabled then
                    _romDebounce = true
                    task.spawn(function()
                        doInstantReset()
                        task.wait(0.3)
                        _romDebounce = false
                    end)
                end
            end
        end
        return orig_fire_med(self, ...)
    end))
end)

local function onPartAnchoredForReset(part)
    return part:GetPropertyChangedSignal("Anchored"):Connect(function()
        if part.Anchored and part.Transparency == 1 and part.Name ~= "HumanoidRootPart" then
            if _romDebounce or not M.medusaResetEnabled then return end
            _romDebounce = true
            task.spawn(function()
                doInstantReset()
                task.wait(1.5)
                _romDebounce = false
            end)
        end
    end)
end

function M.startMedusaReset()
    if M._medusaResetConnections then
        for _,c in pairs(M._medusaResetConnections) do pcall(function() c:Disconnect() end) end
    end
    M._medusaResetConnections = {}
    local char = player.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            table.insert(M._medusaResetConnections, onPartAnchoredForReset(part))
        end
    end
    table.insert(M._medusaResetConnections, char.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then
            table.insert(M._medusaResetConnections, onPartAnchoredForReset(part))
        end
    end))
end

function M.stopMedusaReset()
    if M._medusaResetConnections then
        for _,c in pairs(M._medusaResetConnections) do pcall(function() c:Disconnect() end) end
        M._medusaResetConnections = nil
    end
    _romDebounce = false
    _resetCooldown = false
end

function M.toggleMedusaReset()
    M.medusaResetEnabled = not M.medusaResetEnabled
    if M.medusaResetEnabled then
        M.startMedusaReset()
    else
        M.stopMedusaReset()
    end
    if M.setMedusaResetVisual then
        M.setMedusaResetVisual(M.medusaResetEnabled)
    end
    saveCherryConfig()
    return M.medusaResetEnabled
end

-- ============================================================
-- ANTI-RAGDOLL (New robust implementation)
-- ============================================================
local antiRagResetCooldown = 0

function M.startAntiRagdoll()
    if M.Conns.antiRag then return end

    M.Conns.antiRag = RunService.Heartbeat:Connect(function()
        if not M.antiRagdollEnabled then return end

        local char = player.Character
        if not char then return end

        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum or not root or hum.Health <= 0 then return end

        local state = hum:GetState()
        local now = tick()

        if state == Enum.HumanoidStateType.Physics or
           state == Enum.HumanoidStateType.Ragdoll or
           state == Enum.HumanoidStateType.FallingDown then

            if now - antiRagResetCooldown > 0.15 then
                antiRagResetCooldown = now

                pcall(function()
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)

                    root.Velocity = Vector3.zero
                    root.RotVelocity = Vector3.zero
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero

                    for _, obj in ipairs(char:GetDescendants()) do
                        if obj:IsA("Motor6D") then
                            obj.Enabled = true
                        end
                    end

                    for _, obj in ipairs(char:GetDescendants()) do
                        if obj:IsA("Constraint") then
                            obj.Enabled = true
                        end
                    end

                    workspace.CurrentCamera.CameraSubject = hum

                    local PM = player.PlayerScripts:FindFirstChild("PlayerModule")
                    if PM then
                        local CM = require(PM:FindFirstChild("ControlModule"))
                        if CM then
                            CM:Enable()
                        end
                    end

                    hum.AutoRotate = true
                    hum.PlatformStand = false
                    hum.Sit = false
                end)
            end
        end
    end)
end

function M.stopAntiRagdoll()
    if M.Conns.antiRag then
        M.Conns.antiRag:Disconnect()
        M.Conns.antiRag = nil
    end
    antiRagResetCooldown = 0
end

-- ============================================================
-- AUTO RESET ON DEATH (New robust implementation)
-- ============================================================
local deathResetConn = nil
local deathResetCharAdded = nil

function M.cursedInstaReset()
    doInstantReset()
end

function M.setupDeathReset()
    if deathResetConn then
        deathResetConn:Disconnect()
        deathResetConn = nil
    end

    if not M.autoResetOnDeath then return end

    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            deathResetConn = hum.Died:Connect(function()
                if M.autoResetOnDeath then
                    M.cursedInstaReset()
                end
            end)
        end
    end
end

if deathResetCharAdded then
    deathResetCharAdded:Disconnect()
end
deathResetCharAdded = player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    M.setupDeathReset()
end)

-- ============================================================
-- REST OF THE CORE FUNCTIONS (unchanged)
-- ============================================================
function M.doAutoTPDown(force)
    local char=player.Character;if not char then return end;local hrp=char:FindFirstChild("HumanoidRootPart");if not hrp then return end
    local hum2=char:FindFirstChildOfClass("Humanoid");if not hum2 then return end
    if not force then if hum2.FloorMaterial~=Enum.Material.Air then return end;if not(hrp.Position.Y>=M.autoTPHeight) then return end end
    hrp.CFrame=CFrame.new(hrp.Position.X,-7.00,hrp.Position.Z)*CFrame.Angles(0,select(2,hrp.CFrame:ToEulerAnglesYXZ()),0);hrp.AssemblyLinearVelocity=Vector3.zero;clearLinVel()
end

function M.startAutoTP()
    if M.autoTPConn then task.cancel(M.autoTPConn);M.autoTPConn=nil end
    M.autoTPConn=task.spawn(function() while M.autoTPEnabled do task.wait(0.1);pcall(function() M.doAutoTPDown(false) end) end end)
end

function M.stopAutoTP() M.autoTPEnabled=false;if M.autoTPConn then task.cancel(M.autoTPConn);M.autoTPConn=nil end end

function M.runTPFloor() pcall(function() M.doAutoTPDown(true) end) end

function M.enableStretchRez()
    M.stretchRezEnabled=true;if M.stretchRezConn then M.stretchRezConn:Disconnect() end
    pcall(function() RunService:UnbindFromRenderStep("Movee_Stretch") end)
    pcall(function() RunService:BindToRenderStep("Movee_Stretch",Enum.RenderPriority.Last.Value-1,function() local cam=workspace.CurrentCamera;if cam then cam.CFrame=cam.CFrame*CFrame.new(0,0,0,1,0,0,0,0.8,0,0,0,1) end end) end)
end

function M.disableStretchRez() M.stretchRezEnabled=false;pcall(function() RunService:UnbindFromRenderStep("Movee_Stretch") end) end

M._alSeen = M._alSeen or setmetatable({},{__mode="k"})
M._alNow = (os and os.clock) or tick or function() return os.time() end
local _AL_PLASTIC = Enum.Material.Plastic
function M.applyAntiLagDerender(obj)
    if M._alSeen[obj] then return end
    M._alSeen[obj]=true
    local cn=obj.ClassName
    if cn=="Part" or cn=="MeshPart" or cn=="UnionOperation" or cn=="TrussPart" or cn=="WedgePart" or cn=="CornerWedgePart" then
        if obj.Material~=_AL_PLASTIC then obj.Material=_AL_PLASTIC end
        if obj.Reflectance~=0 then obj.Reflectance=0 end
        if obj.CastShadow then obj.CastShadow=false end
    elseif cn=="ParticleEmitter" or cn=="Trail" or cn=="Beam" or cn=="Fire" or cn=="Smoke" or cn=="Sparkles" then
        if obj.Enabled then obj.Enabled=false end
    elseif cn=="Decal" or cn=="Texture" then
        if obj.Transparency~=1 then obj.Transparency=1 end
    elseif cn=="Accessory" or cn=="Hat" then
        obj:Destroy()
    end
end

function M._alSlice(list)
    local i,n=1,#list
    local budget=0.003
    while i<=n do
        local t0=M._alNow()
        while i<=n do
            M.applyAntiLagDerender(list[i]); i=i+1
            if M._alNow()-t0>=budget then break end
        end
        if i<=n then task.wait() end
    end
end

function M.enableAntiLag()
    M.removeAccessoriesEnabled=true;M.antiLagEnabled=true
    M.defLightBrightness=M.defLightBrightness or Lighting.Brightness;M.defLightClock=M.defLightClock or Lighting.ClockTime;M.defLightAmbient=M.defLightAmbient or Lighting.OutdoorAmbient
    Lighting.GlobalShadows=false;Lighting.FogEnd=1e10;Lighting.Brightness=1;Lighting.EnvironmentDiffuseScale=0;Lighting.EnvironmentSpecularScale=0
    for _,e in ipairs(Lighting:GetChildren()) do pcall(function() if e:IsA("PostEffect") then e.Enabled=false end end) end
    if M.antiLagDescConn then M.antiLagDescConn:Disconnect();M.antiLagDescConn=nil end
    -- event-driven queue: only drains when parts actually stream in; zero idle cost
    M._alPending={}; M._alDraining=false
    local function scheduleDrain()
        if M._alDraining then return end
        M._alDraining=true
        task.spawn(function()
            while M.removeAccessoriesEnabled and #M._alPending>0 do
                local batch=M._alPending; M._alPending={}; M._alSlice(batch)
            end
            M._alDraining=false
        end)
    end
    M.antiLagDescConn=workspace.DescendantAdded:Connect(function(obj)
        if not M.removeAccessoriesEnabled then return end
        M._alPending[#M._alPending+1]=obj; scheduleDrain()
    end)
    task.spawn(function()
        M._alSlice(workspace:GetDescendants())
        if #M._alPending>0 then scheduleDrain() end
    end)
end

function M.disableAntiLag()
    M.removeAccessoriesEnabled=false;M.antiLagEnabled=false;if M.antiLagDescConn then M.antiLagDescConn:Disconnect();M.antiLagDescConn=nil end
    pcall(function() if M.defLightBrightness then Lighting.Brightness=M.defLightBrightness end;if M.defLightClock then Lighting.ClockTime=M.defLightClock end;if M.defLightAmbient then Lighting.OutdoorAmbient=M.defLightAmbient end;Lighting.ExposureCompensation=0 end)
end

-- ============================================================
-- MANUAL INFINITE JUMP
-- ============================================================
M.jumpHeld = false
M.lastJumpBoostTime = 0
M.JUMP_BOOST_INTERVAL = 0.05
M.infJumpThread = nil

task.spawn(function()
    local pg = player:WaitForChild("PlayerGui", 10)
    if pg then
        local function hookJumpButton(btn)
            if btn:IsA("GuiButton") and btn.Name == "JumpButton" and not btn:GetAttribute("InfJumpHooked") then
                btn:SetAttribute("InfJumpHooked", true)
                btn.MouseButton1Down:Connect(function()
                    if M.infJumpEnabled and M.infJumpMode == "manual" then 
                        M.jumpHeld = true 
                    end
                end)
                btn.MouseButton1Up:Connect(function() M.jumpHeld = false end)
                btn.MouseLeave:Connect(function() M.jumpHeld = false end)
            end
        end
        for _, d in ipairs(pg:GetDescendants()) do hookJumpButton(d) end
        pg.DescendantAdded:Connect(hookJumpButton)
    end
end)

UIS.JumpRequest:Connect(function()
    if M.infJumpEnabled and M.infJumpMode == "manual" then
        M.jumpHeld = true
        task.wait(0.05)
        M.jumpHeld = false
    end
end)

UIS.InputBegan:Connect(function(inp, gpe)
    if gpe then return end
    if M.infJumpEnabled and M.infJumpMode == "manual"
        and inp.UserInputType == Enum.UserInputType.Keyboard
        and inp.KeyCode == Enum.KeyCode.Space then
        M.jumpHeld = true
    end
end)

UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == Enum.KeyCode.Space then
        M.jumpHeld = false
    end
end)

function M.startManualInfJumpLoop()
    if M.infJumpThread then M.infJumpThread:Disconnect() end
    M.infJumpThread = RunService.Stepped:Connect(function()
        if not M.infJumpEnabled or M.infJumpMode ~= "manual" then return end
        if not M.jumpHeld then return end
        local now = tick()
        if now - M.lastJumpBoostTime < M.JUMP_BOOST_INTERVAL then return end
        M.lastJumpBoostTime = now
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp or hum.Health <= 0 then return end
        local vel = hrp.AssemblyLinearVelocity
        if vel.Y < 55 then
            hrp.AssemblyLinearVelocity = Vector3.new(vel.X, 65, vel.Z)
        end
    end)
end

function M.stopManualInfJumpLoop()
    if M.infJumpThread then
        M.infJumpThread:Disconnect()
        M.infJumpThread = nil
    end
    M.jumpHeld = false
    M.lastJumpBoostTime = 0
end

function M.startHoldInfJump()
    if M.holdInfJumpConn then M.holdInfJumpConn:Disconnect() end
    M.holdInfJumpConn = RunService.Heartbeat:Connect(function()
        if not M.infJumpEnabled or M.infJumpMode ~= "hold" then return end
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end
        local isJumpHeld = UIS:IsKeyDown(Enum.KeyCode.Space) or (hum.Jump == true)
        if isJumpHeld and root.Velocity.Y < 35 then
            root.Velocity = Vector3.new(root.Velocity.X, 55, root.Velocity.Z)
        end
        if root.Velocity.Y < -120 then
            root.Velocity = Vector3.new(root.Velocity.X, -120, root.Velocity.Z)
        end
    end)
end

function M.stopHoldInfJump()
    if M.holdInfJumpConn then
        M.holdInfJumpConn:Disconnect()
        M.holdInfJumpConn = nil
    end
end

-- ============================================================
function M.startUnwalk()
    local c=player.Character;if not c then return end;local hum=c:FindFirstChildOfClass("Humanoid")
    if hum then for _,t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop() end end
    local anim=c:FindFirstChild("Animate");if anim then M.unwalkSavedAnimate=anim:Clone();anim:Destroy() end
end

function M.stopUnwalk() local c=player.Character;if c and M.unwalkSavedAnimate then M.unwalkSavedAnimate:Clone().Parent=c;M.unwalkSavedAnimate=nil end end

function M.toggleCarryMode()
    M.carrySpeedActive = not M.carrySpeedActive
    M.refreshSpeedModeLabel()
    if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(M.carrySpeedActive) end
    if M.mobBtnRefs.lagger then M.mobBtnRefs.lagger(M.laggerModeEnabled) end
    if M.carryModeBtn then
        M.carryModeBtn.Text = M.carrySpeedActive and "Carry On" or "Carry Off"
    end
    saveCherryConfig()
end

function M.toggleLaggerMode()
    M.laggerModeEnabled = not M.laggerModeEnabled
    M.refreshSpeedModeLabel()
    if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(M.carrySpeedActive) end
    if M.mobBtnRefs.lagger then M.mobBtnRefs.lagger(M.laggerModeEnabled) end
    if M.laggerModeBtn then
        M.laggerModeBtn.Text = M.laggerModeEnabled and "Lag On" or "Lag Off"
    end
    saveCherryConfig()
end

-- vampirehub v2 speed keybinds:
-- Normal-mode key: forces lagger OFF, then flips carry -> Normal Speed <-> Carry Speed
-- Lagger-mode key: forces lagger ON,  then flips carry -> Normal Lagger <-> Carry Lagger
function M.keybindNormalMode()
    if M.laggerModeEnabled then
        -- coming from lagger: land in normal mode without flipping carry this press
        M.laggerModeEnabled = false
    else
        M.carrySpeedActive = not M.carrySpeedActive
    end
    M.refreshSpeedModeLabel()
    if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(M.carrySpeedActive) end
    if M.mobBtnRefs.lagger then M.mobBtnRefs.lagger(M.laggerModeEnabled) end
    if M.carryModeBtn then M.carryModeBtn.Text = M.carrySpeedActive and "Carry On" or "Carry Off" end
    if M.laggerModeBtn then M.laggerModeBtn.Text = M.laggerModeEnabled and "Lag On" or "Lag Off" end
    saveCherryConfig()
end

function M.keybindLaggerMode()
    if not M.laggerModeEnabled then
        -- entering lagger mode from normal: land in lagger without flipping carry this press
        M.laggerModeEnabled = true
    else
        M.carrySpeedActive = not M.carrySpeedActive
    end
    M.refreshSpeedModeLabel()
    if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(M.currentSpeedMode()=="carry") end
    if M.mobBtnRefs.lagger then M.mobBtnRefs.lagger(M.currentSpeedMode()=="lagger") end
    if M.mobBtnRefs.laggerCarry then M.mobBtnRefs.laggerCarry(M.currentSpeedMode()=="laggerCarry") end
    if M.carryModeBtn then M.carryModeBtn.Text = M.carrySpeedActive and "Carry On" or "Carry Off" end
    if M.laggerModeBtn then M.laggerModeBtn.Text = M.laggerModeEnabled and "Lag On" or "Lag Off" end
    saveCherryConfig()
end

-- Mutually-exclusive speed modes. Only one of carrySpeed/lagger/laggerCarry
-- can be lit at a time. Tapping the active one returns to Normal (all off).
-- mode is one of: "normal", "carry", "lagger", "laggerCarry"
function M.setSpeedMode(mode)
    if mode == "carry" then
        M.laggerModeEnabled = false; M.carrySpeedActive = true
    elseif mode == "lagger" then
        M.laggerModeEnabled = true;  M.carrySpeedActive = false
    elseif mode == "laggerCarry" then
        M.laggerModeEnabled = true;  M.carrySpeedActive = true
    else -- normal
        M.laggerModeEnabled = false; M.carrySpeedActive = false
    end
    -- refresh every speed button so exactly the active one is on
    if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(mode == "carry") end
    if M.mobBtnRefs.lagger then M.mobBtnRefs.lagger(mode == "lagger") end
    if M.mobBtnRefs.laggerCarry then M.mobBtnRefs.laggerCarry(mode == "laggerCarry") end
    if M.refreshSpeedModeLabel then M.refreshSpeedModeLabel() end
    if M.carryModeBtn then M.carryModeBtn.Text = M.carrySpeedActive and "Carry On" or "Carry Off" end
    if M.laggerModeBtn then M.laggerModeBtn.Text = M.laggerModeEnabled and "Lag On" or "Lag Off" end
    saveCherryConfig()
end

-- Current active speed mode from the underlying flags
function M.currentSpeedMode()
    if M.laggerModeEnabled and M.carrySpeedActive then return "laggerCarry"
    elseif M.laggerModeEnabled then return "lagger"
    elseif M.carrySpeedActive then return "carry"
    else return "normal" end
end

-- AUTO LEFT / RIGHT
function M.stopAutoLeft()
    if M.alConn then M.alConn:Disconnect();M.alConn=nil end;M.alPhase=1
    local char=player.Character;if char then local h=char:FindFirstChildOfClass("Humanoid");if h then h:Move(Vector3.zero,false) end end
    if M.autoLeftSetVisual then M.autoLeftSetVisual(false) end
    if M.mobBtnRefs.autoLeft then M.mobBtnRefs.autoLeft(false) end
end

function M.stopAutoRight()
    if M.arConn then M.arConn:Disconnect();M.arConn=nil end;M.arPhase=1
    local char=player.Character;if char then local h=char:FindFirstChildOfClass("Humanoid");if h then h:Move(Vector3.zero,false) end end
    if M.autoRightSetVisual then M.autoRightSetVisual(false) end
    if M.mobBtnRefs.autoRight then M.mobBtnRefs.autoRight(false) end
end

function M.startAutoLeft()
    if M.alConn then M.alConn:Disconnect() end;M.alPhase=1
    M.alConn=RunService.Heartbeat:Connect(function()
        if not M.autoLeftEnabled then return end
        local char=player.Character;if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart");local hum=char:FindFirstChildOfClass("Humanoid");if not hrp or not hum then return end
        if M.isRagdollState(hum) then hum:Move(Vector3.zero,false);clearLinVel();return end
        local spd=M.getAutoPathSpeed()
        if M.alPhase==1 then
            local tgt=Vector3.new(M.AP_L1.X,hrp.Position.Y,M.AP_L1.Z)
            if (tgt-hrp.Position).Magnitude<1 then M.alPhase=2;local d=M.AP_L2-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);setLinVelXZ(mv.X*spd,mv.Z*spd);return end
            local d=M.AP_L1-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);setLinVelXZ(mv.X*spd,mv.Z*spd)
        elseif M.alPhase==2 then
            local tgt=Vector3.new(M.AP_L2.X,hrp.Position.Y,M.AP_L2.Z)
            if (tgt-hrp.Position).Magnitude<1 then hum:Move(Vector3.zero,false);clearLinVel();M.autoLeftEnabled=false;if M.alConn then M.alConn:Disconnect();M.alConn=nil end;M.alPhase=1;if M.autoLeftSetVisual then M.autoLeftSetVisual(false) end;if M.mobBtnRefs.autoLeft then M.mobBtnRefs.autoLeft(false) end;return end
            local d=M.AP_L2-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);setLinVelXZ(mv.X*spd,mv.Z*spd)
        end
        if M.autoMoveSwingEnabled and not M._alSwingDebounce then
            M._alSwingDebounce=true
            local bat=M.findBat()
            if bat then
                if bat.Parent~=char then pcall(function() hum:EquipTool(bat) end) end
                pcall(function() bat:Activate() end)
            end
            task.delay(M.autoMoveSwingInterval,function() M._alSwingDebounce=false end)
        end
    end)
end

function M.startAutoRight()
    if M.arConn then M.arConn:Disconnect() end;M.arPhase=1
    M.arConn=RunService.Heartbeat:Connect(function()
        if not M.autoRightEnabled then return end
        local char=player.Character;if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart");local hum=char:FindFirstChildOfClass("Humanoid");if not hrp or not hum then return end
        if M.isRagdollState(hum) then hum:Move(Vector3.zero,false);clearLinVel();return end
        local spd=M.getAutoPathSpeed()
        if M.arPhase==1 then
            local tgt=Vector3.new(M.AP_R1.X,hrp.Position.Y,M.AP_R1.Z)
            if (tgt-hrp.Position).Magnitude<1 then M.arPhase=2;local d=M.AP_R2-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);setLinVelXZ(mv.X*spd,mv.Z*spd);return end
            local d=M.AP_R1-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);setLinVelXZ(mv.X*spd,mv.Z*spd)
        elseif M.arPhase==2 then
            local tgt=Vector3.new(M.AP_R2.X,hrp.Position.Y,M.AP_R2.Z)
            if (tgt-hrp.Position).Magnitude<1 then hum:Move(Vector3.zero,false);clearLinVel();M.autoRightEnabled=false;if M.arConn then M.arConn:Disconnect();M.arConn=nil end;M.arPhase=1;if M.autoRightSetVisual then M.autoRightSetVisual(false) end;if M.mobBtnRefs.autoRight then M.mobBtnRefs.autoRight(false) end;return end
            local d=M.AP_R2-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);setLinVelXZ(mv.X*spd,mv.Z*spd)
        end
        if M.autoMoveSwingEnabled and not M._arSwingDebounce then
            M._arSwingDebounce=true
            local bat=M.findBat()
            if bat then
                if bat.Parent~=char then pcall(function() hum:EquipTool(bat) end) end
                pcall(function() bat:Activate() end)
            end
            task.delay(M.autoMoveSwingInterval,function() M._arSwingDebounce=false end)
        end
    end)
end

-- ============================================================
-- ANTI-KICK
-- ============================================================
function M.enableAntiKick()
    M.antiKickEnabled=true
    task.spawn(function()
        while M.antiKickEnabled do
            task.wait(0.5);local char=player.Character
            if char then
                for _,tool in ipairs(char:GetChildren()) do
                    if tool:IsA("Tool") then
                        local n=tool.Name:lower()
                        if n:find("brainrot") or n:find("skibidi") or n:find("toilet") then
                            M.brainrotDetected=true
                            if M.autoBatEnabled then M.autoBatEnabled=false;if M.autoBatSetVisual then M.autoBatSetVisual(false) end end
                            if M.autoLeftEnabled then M.autoLeftEnabled=false;if M.autoLeftSetVisual then M.autoLeftSetVisual(false) end end
                            if M.autoRightEnabled then M.autoRightEnabled=false;if M.autoRightSetVisual then M.autoRightSetVisual(false) end end
                        else M.brainrotDetected=false end
                    end
                end
            end
        end
    end)
end

function M.disableAntiKick()
    M.antiKickEnabled=false;M.brainrotDetected=false
end

function M.getActiveMoveSpeed()
    if M.laggerModeEnabled and M.carrySpeedActive then return M.LAGGER_CARRY_SPEED
    elseif M.laggerModeEnabled then return M.LAGGER_SPEED
    elseif M.carrySpeedActive then return M.CS
    else return M.NS end
end

function M.getAutoPathSpeed()
    -- Auto Left / Auto Right always run at Normal Speed, regardless of lagger/carry state.
    return M.NS
end

function M.updateAutoSwitchSpeed()
    if not M.autoSwitchSpeedEnabled then return end
    local char=player.Character;if not char then return end
    local h=char:FindFirstChildOfClass("Humanoid");if not h then return end
    local isStealSpeed=h.WalkSpeed<25
    if isStealSpeed==M._autoSwitchWasSteal then return end
    M._autoSwitchWasSteal=isStealSpeed
    if isStealSpeed then M.carrySpeedActive=true else M.carrySpeedActive=false end
    if M.refreshSpeedModeLabel then M.refreshSpeedModeLabel() end
    if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(M.carrySpeedActive) end
    if M.carryModeBtn then
        M.carryModeBtn.Text = M.carrySpeedActive and "Carry On" or "Carry Off"
    end
end

-- ============================================================
-- AUTO CARRY ON GRAB
-- Détecte automatiquement quand WalkSpeed < 25 (grab/brainrot)
-- et switch vers carrySpeed (M.CS) — exactement comme le
-- système auto switch speed du fichier Vampire.
-- Quand le grab se termine (WalkSpeed >= 25), repasse en NS.
-- ============================================================
function M.startAutoCarryOnGrab()
    if M._autoCarryConn then M._autoCarryConn:Disconnect(); M._autoCarryConn = nil end

    local wasGrabbed = false

    M._autoCarryConn = RunService.Heartbeat:Connect(function()
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        -- Lagger mode géré séparément — ne pas interférer
        if M.laggerModeEnabled then return end

        local isGrabbed = hum.WalkSpeed < 25

        if isGrabbed and not wasGrabbed then
            -- Grab détecté : activer carry speed
            wasGrabbed = true
            M.carrySpeedActive = true
            if M.refreshSpeedModeLabel then M.refreshSpeedModeLabel() end
            if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(true) end
            if M.carryModeBtn then M.carryModeBtn.Text = "Carry On" end

        elseif not isGrabbed and wasGrabbed then
            -- Grab terminé : repasser en vitesse normale
            wasGrabbed = false
            M.carrySpeedActive = false
            if M.refreshSpeedModeLabel then M.refreshSpeedModeLabel() end
            if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(false) end
            if M.carryModeBtn then M.carryModeBtn.Text = "Carry Off" end
        end
    end)
end

function M.stopAutoCarryOnGrab()
    if M._autoCarryConn then
        M._autoCarryConn:Disconnect()
        M._autoCarryConn = nil
    end
    -- Restaurer état carry à false quand on désactive
    M.carrySpeedActive = false
    if M.refreshSpeedModeLabel then M.refreshSpeedModeLabel() end
    if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(false) end
    if M.carryModeBtn then M.carryModeBtn.Text = "Carry Off" end
end

-- ============================================================
-- PING ALERT
-- Vérifie le ping toutes les 5 secondes.
-- Si ping > 120ms : affiche une notification "HIGH PING • Duel" avec
-- la valeur en ms pendant 5 secondes, puis disparaît.
-- ============================================================
function M.startPingAlert()
    -- removed (HIGH PING popup deleted)
    M.pingAlertEnabled = false
end

function M.stopPingAlert()
    if M._pingAlertConn then M._pingAlertConn:Disconnect(); M._pingAlertConn = nil end
    if M._pingAlertTask then task.cancel(M._pingAlertTask); M._pingAlertTask = nil end
    if M.pingPopupGui then
        pcall(function() M.pingPopupGui:Destroy() end)
        M.pingPopupGui = nil
    end
    M.pingPopupActive = false
end

function M.isRagdollState(hum)
    if not hum then return true end;local st=hum:GetState()
    return hum.PlatformStand or st==Enum.HumanoidStateType.Physics or st==Enum.HumanoidStateType.Ragdoll or st==Enum.HumanoidStateType.FallingDown
end

-- ============================================================
-- DROP BRAINROT
-- ============================================================
M._wfConns = {}

function M.runDrop()
    if M.dropActive then return end

    if M.dropMode == "Jump" then
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        M.dropActive = true
        local t0 = tick()
        local dc
        dc = RunService.Heartbeat:Connect(function()
            local r = char and char:FindFirstChild("HumanoidRootPart")
            if not r then
                dc:Disconnect()
                M.dropActive = false
                return
            end

            if tick() - t0 >= M.DROP_ASCEND_DURATION then
                dc:Disconnect()
                local rp = RaycastParams.new()
                rp.FilterDescendantsInstances = {char}
                rp.FilterType = Enum.RaycastFilterType.Exclude
                local rr = workspace:Raycast(r.Position, Vector3.new(0, -2000, 0), rp)
                if rr then
                    local hum2 = char:FindFirstChildOfClass("Humanoid")
                    local off = (hum2 and hum2.HipHeight or 2) + (r.Size.Y / 2)
                    r.CFrame = CFrame.new(r.Position.X, rr.Position.Y + off, r.Position.Z)
                    r.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                end
                M.dropActive = false
                return
            end

            r.AssemblyLinearVelocity = Vector3.new(
                r.AssemblyLinearVelocity.X,
                M.DROP_ASCEND_SPEED,
                r.AssemblyLinearVelocity.Z
            )
        end)
    else
        if M.autoBatEnabled then
            M.autoBatEnabled = false
            if M.autoBatSetVisual then M.autoBatSetVisual(false) end
            M.stopBatAimbot()
        end

        M.dropActive = true

        local colConn = RunService.Stepped:Connect(function()
            if not M.dropActive then return end
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    for _, part in ipairs(p.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end)
        table.insert(M._wfConns, colConn)

        local flingThread = coroutine.create(function()
            while M.dropActive do
                RunService.Heartbeat:Wait()
                local c = player.Character
                local root = c and c:FindFirstChild("HumanoidRootPart")
                if not root then break end

                local vel = root.Velocity
                root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)

                RunService.RenderStepped:Wait()
                if root and root.Parent then root.Velocity = vel end

                RunService.Stepped:Wait()
                if root and root.Parent then root.Velocity = vel + Vector3.new(0, 0.1, 0) end
            end
        end)

        table.insert(M._wfConns, flingThread)
        coroutine.resume(flingThread)

        task.delay(0.1, function()
            M.dropActive = false
            for _, c in ipairs(M._wfConns) do
                if typeof(c) == "RBXScriptConnection" then
                    c:Disconnect()
                elseif type(c) == "thread" then
                    pcall(coroutine.close, c)
                end
            end
            M._wfConns = {}
        end)
    end
end

-- ============================================================
-- NUKE OPTIMIZER
-- ============================================================
function M.startNukeOptimizer()
    if M.nukeOn then return end
    M.nukeOn = true
    local Lighting = game:GetService("Lighting")
    local MaterialService = game:GetService("MaterialService")
    local XMin, XMax = -560, -240
    local ClothingClasses = {"Shirt","Pants","ShirtGraphic","Accessory","Hat","HairAccessory","FaceAccessory","NeckAccessory","ShoulderAccessory","FrontAccessory","BackAccessory","WaistAccessory"}
    local BASE_NAMES = {"baseplate","spawnlocation","spawn location","spawn"}
    local function SafeDestroy(obj)
        if obj.Name == "Overhead" then return end
        pcall(function() obj:Destroy() end)
    end
    local function IsClothing(obj)
        for _,c in ipairs(ClothingClasses) do if obj:IsA(c) then return true end end
        return false
    end
    local function IsCharacterPart(obj)
        for _,plr in ipairs(Players:GetPlayers()) do
            if plr.Character and obj:IsDescendantOf(plr.Character) then return true end
        end
        return false
    end
    local function IsOutOfRange(obj)
        if obj:IsA("BasePart") then
            local x = obj.Position.X
            return x < XMin or x > XMax
        end
        return false
    end
    local function IsBase(obj)
        if not obj:IsA("BasePart") then return false end
        local nl = obj.Name:lower()
        for _,n in ipairs(BASE_NAMES) do if nl:find(n,1,true) then return true end end
        return false
    end
    local function IsInBase(obj)
        local p = obj.Parent
        while p and p ~= workspace do
            if IsBase(p) then return true end
            p = p.Parent
        end
        return false
    end
    local function MakeTransparent(obj)
        pcall(function()
            if IsBase(obj) and not IsCharacterPart(obj) then
                obj.Transparency = 1
                obj.CastShadow = false
            end
        end)
    end
    local function CleanObject(obj)
        pcall(function()
            if obj:IsA("SurfaceAppearance") then SafeDestroy(obj)
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                if not (obj.Name=="face" and obj.Parent and obj.Parent.Name=="Head") then SafeDestroy(obj) end
            elseif obj:IsA("SpecialMesh") then obj.TextureId = ""
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then SafeDestroy(obj)
            elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then SafeDestroy(obj)
            elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Explosion") then SafeDestroy(obj)
            elseif obj:IsA("Animation") or obj:IsA("AnimationController") then SafeDestroy(obj)
            elseif obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.Plastic
                obj.MaterialVariant = ""
                obj.Reflectance = 0
            end
        end)
    end
    local function ApplyGreySky()
        pcall(function()
            for _,obj in ipairs(Lighting:GetChildren()) do if obj:IsA("Sky") then obj:Destroy() end end
            local sky = Instance.new("Sky")
            sky.SkyboxBk = ""; sky.SkyboxDn = ""; sky.SkyboxFt = ""; sky.SkyboxLf = ""; sky.SkyboxRt = ""; sky.SkyboxUp = ""
            sky.CelestialBodiesShown = false
            sky.Name = "_MoveeNukeSky"
            sky.Parent = Lighting
        end)
    end
    local function OptimizeLighting()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 9e9
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.Brightness = 1.5
        Lighting.Ambient = Color3.fromRGB(60,60,60)
        for _,v in ipairs(Lighting:GetChildren()) do
            if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("Atmosphere") or v:IsA("Clouds") then
                v:Destroy()
            end
        end
        ApplyGreySky()
    end
    local function ApplyTerrain()
        pcall(function()
            local T = workspace.Terrain
            T.Decoration = false
            T.WaterWaveSize = 0
            T.WaterWaveSpeed = 0
            T.WaterReflectance = 0
            T.WaterTransparency = 1
        end)
    end
    local function OptimizeCharacter(char)
        if not char then return end
        task.spawn(function()
            task.wait(0.3)
            if not M.nukeOn then return end
            for _,obj in ipairs(char:GetDescendants()) do
                if IsClothing(obj) then SafeDestroy(obj) else CleanObject(obj) end
            end
        end)
    end
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
    end)
    pcall(function() if setfpscap then setfpscap(999) end end)

    table.insert(M.nukeThreads, task.spawn(function()
        if not game:IsLoaded() then game.Loaded:Wait() end
        OptimizeLighting()
        ApplyTerrain()
        for _,obj in ipairs(workspace:GetDescendants()) do
            if not M.nukeOn then return end
            if IsBase(obj) then
                MakeTransparent(obj)
            elseif IsClothing(obj) then
                SafeDestroy(obj)
            elseif IsInBase(obj) then
                -- skip
            elseif IsCharacterPart(obj) then
                -- skip
            elseif IsOutOfRange(obj) then
                SafeDestroy(obj)
            else
                CleanObject(obj)
            end
        end
        for _,obj in ipairs(workspace:GetDescendants()) do MakeTransparent(obj) end
    end))

    table.insert(M.nukeConns, workspace.DescendantAdded:Connect(function(obj)
        if not M.nukeOn then return end
        task.defer(function()
            if not M.nukeOn then return end
            if IsBase(obj) then
                MakeTransparent(obj)
                return
            end
            if IsClothing(obj) then SafeDestroy(obj)
            elseif IsInBase(obj) then
                -- skip
            elseif IsCharacterPart(obj) then
                -- skip
            elseif IsOutOfRange(obj) then
                SafeDestroy(obj)
            else
                CleanObject(obj)
            end
        end)
    end))

    table.insert(M.nukeConns, Lighting.DescendantAdded:Connect(function(obj)
        if not M.nukeOn then return end
        if obj:IsA("Atmosphere") or obj:IsA("Clouds") or obj:IsA("PostEffect") then SafeDestroy(obj) end
    end))

    table.insert(M.nukeConns, MaterialService.DescendantAdded:Connect(function(obj)
        if not M.nukeOn then return end
        SafeDestroy(obj)
    end))

    for _,plr in ipairs(Players:GetPlayers()) do
        OptimizeCharacter(plr.Character)
        table.insert(M.nukeConns, plr.CharacterAdded:Connect(OptimizeCharacter))
    end
    table.insert(M.nukeConns, Players.PlayerAdded:Connect(function(plr)
        table.insert(M.nukeConns, plr.CharacterAdded:Connect(OptimizeCharacter))
    end))

    table.insert(M.nukeThreads, task.spawn(function()
        while M.nukeOn do
            task.wait(15)
            pcall(function() collectgarbage("collect") end)
        end
    end))
end

function M.stopNukeOptimizer()
    M.nukeOn = false
    for _,c in ipairs(M.nukeConns) do
        pcall(function() c:Disconnect() end)
    end
    M.nukeConns = {}
    M.nukeThreads = {}
end

-- ============================================================
-- REMOVE ACCESSORIES
-- ============================================================
function M.startRemoveAcc()
    if M.removeAccEnabled then return end
    M.removeAccEnabled = true
    local function removeAccDo()
        if not M.removeAccEnabled then return end
        local char = player.Character
        if not char then return end
        for _,obj in ipairs(char:GetDescendants()) do
            if obj:IsA("Accessory") or obj:IsA("Hat") then
                if not M.removedAccessories[obj] then
                    M.removedAccessories[obj] = true
                    pcall(function() obj:Destroy() end)
                end
            end
        end
    end
    removeAccDo()
    M.removeAccConn = player.CharacterAdded:Connect(function()
        task.wait(0.5)
        if M.removeAccEnabled then removeAccDo() end
    end)
end

function M.stopRemoveAcc()
    M.removeAccEnabled = false
    if M.removeAccConn then
        M.removeAccConn:Disconnect()
        M.removeAccConn = nil
    end
    M.removedAccessories = {}
end

-- ============================================================
-- MOBILE BUTTONS (Version améliorée avec groupes exclusifs)
-- ============================================================

function M.destroyMobileButtons()
    if M.mobGuiRef then
        pcall(function() M.mobGuiRef:Destroy() end)
        M.mobGuiRef = nil
    end
    for _, name in ipairs({"MoveeMobileButtons"}) do
        local old = game:GetService("CoreGui"):FindFirstChild(name)
        if old then old:Destroy() end
        local pgui = player:FindFirstChild("PlayerGui")
        if pgui then
            local o = pgui:FindFirstChild(name)
            if o then o:Destroy() end
        end
    end
    M.mobBtnRefs = {}
end

function M.loadBtnPositions()
    if not(isfile and isfile(M.MOB_POS_FILE)) then return {} end
    local ok, data = pcall(function() return HS:JSONDecode(readfile(M.MOB_POS_FILE)) end)
    if ok and type(data) == "table" then return data end
    return {}
end

function M.saveBtnPositions()
    if not writefile then return end
    if not M.mobGuiRef then return end
    local out = {}
    for _, child in ipairs(M.mobGuiRef:GetDescendants()) do
        if child:IsA("TextButton") and child:GetAttribute("BtnKey") then
            local key = child:GetAttribute("BtnKey")
            out[key] = {
                xs = child.Position.X.Scale,
                xo = child.Position.X.Offset,
                ys = child.Position.Y.Scale,
                yo = child.Position.Y.Offset,
                dragged = child:GetAttribute("Dragged") == true
            }
        end
    end
    pcall(function()
        if isfile and isfile(M.MOB_POS_FILE) then
            local prev = HS:JSONDecode(readfile(M.MOB_POS_FILE))
            if type(prev) == "table" then
                for k, v in pairs(prev) do
                    if out[k] == nil then out[k] = v end
                end
            end
        end
    end)
    pcall(function() writefile(M.MOB_POS_FILE, HS:JSONEncode(out)) end)
end

function M.resetMobilePositions()
    if isfile and isfile(M.MOB_POS_FILE) then
        pcall(function() os.remove(M.MOB_POS_FILE) end)
    end
    M.buildMobileButtons()
end

-- ============================================================
-- FONCTIONS POUR GÉRER LES GROUPES EXCLUSIFS
-- ============================================================

-- GROUPE 1 : AUTO LEFT, AUTO RIGHT
local exclusiveGroup1 = {"autoLeft", "autoRight"}
local activeExclusiveKey1 = nil

local function setExclusiveGroup1(key, isOn)
    if isOn then
        for _, k in ipairs(exclusiveGroup1) do
            if k ~= key then
                if k == "autoLeft" then
                    M.autoLeftEnabled = false
                    if M.mobBtnRefs[k] then M.mobBtnRefs[k](false) end
                    if M.autoLeftSetVisual then M.autoLeftSetVisual(false) end
                elseif k == "autoRight" then
                    M.autoRightEnabled = false
                    if M.mobBtnRefs[k] then M.mobBtnRefs[k](false) end
                    if M.autoRightSetVisual then M.autoRightSetVisual(false) end
                end
            end
        end
        activeExclusiveKey1 = key
    else
        if activeExclusiveKey1 == key then
            activeExclusiveKey1 = nil
        end
    end
end

-- GROUPE 2 : CARRY SPEED, LAGGER MODE, LAGGER CARRY
local exclusiveGroup2 = {"carrySpeed", "lagger", "laggerCarry"}
local activeExclusiveKey2 = nil

local function setExclusiveGroup2(key, isOn)
    if isOn then
        for _, k in ipairs(exclusiveGroup2) do
            if k ~= key then
                if k == "carrySpeed" then
                    M.carrySpeedActive = false
                    if M.mobBtnRefs[k] then M.mobBtnRefs[k](false) end
                    if M.carryModeBtn then M.carryModeBtn.Text = "Carry Off" end
                elseif k == "lagger" then
                    M.laggerModeEnabled = false
                    if M.mobBtnRefs[k] then M.mobBtnRefs[k](false) end
                    if M.laggerModeBtn then M.laggerModeBtn.Text = "Lag Off" end
                elseif k == "laggerCarry" then
                    M.laggerModeEnabled = false
                    M.carrySpeedActive = false
                    M.laggerCarryActive = false
                    if M.mobBtnRefs[k] then M.mobBtnRefs[k](false) end
                    if M.laggerModeBtn then M.laggerModeBtn.Text = "Lag Off" end
                    if M.carryModeBtn then M.carryModeBtn.Text = "Carry Off" end
                end
            end
        end
        activeExclusiveKey2 = key
    else
        if activeExclusiveKey2 == key then
            activeExclusiveKey2 = nil
        end
    end
end

-- GROUPE 3 : AIMBOT et BYPASS
local exclusiveGroup3 = {"autoBat", "bypass"}
local activeExclusiveKey3 = nil

local function setExclusiveGroup3(key, isOn)
    if isOn then
        for _, k in ipairs(exclusiveGroup3) do
            if k ~= key then
                if k == "autoBat" then
                    M.autoBatEnabled = false
                    if M.mobBtnRefs[k] then M.mobBtnRefs[k](false) end
                    if M.autoBatSetVisual then M.autoBatSetVisual(false) end
                    M.stopBatAimbot()
                elseif k == "bypass" then
                    M.bypassAimbotEnabled = false
                    if M.mobBtnRefs[k] then M.mobBtnRefs[k](false) end
                    if M.setBypassVisual then M.setBypassVisual(false) end
                    M.stopBypassAimbot()
                end
            end
        end
        activeExclusiveKey3 = key
    else
        if activeExclusiveKey3 == key then
            activeExclusiveKey3 = nil
        end
    end
end

-- ============================================================
-- CONSTRUCTION DES BOUTONS MOBILES (VERSION AMÉLIORÉE)
-- ============================================================
function M.buildMobileButtons()
    M.destroyMobileButtons()
    if not M.mobileButtonsEnabled then return end

    local savedPositions = M.loadBtnPositions()

    local BTN_SIZE = math.max(55, math.floor(M.mobileButtonsSize * 0.65))
    local BTN_GAP = 3
    local PADDING = 4
    local COLS = 2
    local ROWS = 4

    local PANEL_W = PADDING * 2 + COLS * BTN_SIZE + (COLS - 1) * BTN_GAP
    local PANEL_H = PADDING * 2 + ROWS * BTN_SIZE + (ROWS - 1) * BTN_GAP

    local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(800, 600)
    local savedPanel = savedPositions["_panel"]
    local defPanelX = vp.X - PANEL_W - 10
    local defPanelY = (vp.Y - PANEL_H) / 2
    local panelXO = savedPanel and savedPanel.xo or defPanelX
    local panelYO = savedPanel and savedPanel.yo or defPanelY

    local mobGui = Instance.new("ScreenGui")
    mobGui.Name = "MoveeMobileButtons"
    mobGui.ResetOnSpawn = false
    mobGui.DisplayOrder = 15
    mobGui.IgnoreGuiInset = true
    if syn and syn.protect_gui then pcall(function() syn.protect_gui(mobGui) end) end
    if not pcall(function() mobGui.Parent = game:GetService("CoreGui") end) then
        mobGui.Parent = player:WaitForChild("PlayerGui")
    end
    M.mobGuiRef = mobGui

    -- PANEL
    local panel = Instance.new("Frame")
    panel.Name = "MobPanel"
    panel.Size = UDim2.new(0, PANEL_W, 0, PANEL_H)
    if savedPanel then
        panel.Position = UDim2.new(savedPanel.xs or 0, savedPanel.xo or defPanelX,
                                   savedPanel.ys or 0, savedPanel.yo or defPanelY)
    else
        panel.Position = UDim2.new(0, panelXO, 0, panelYO)
    end
    panel.BackgroundTransparency = 1
    panel.BorderSizePixel = 0
    panel.ZIndex = 100
    panel.Parent = mobGui

    -- Drag du panel
    local dragInfo = {dragging = false, start = nil, startPos = nil}
    panel.InputBegan:Connect(function(input)
        if M.uiLocked then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragInfo.dragging = true
            dragInfo.start = input.Position
            dragInfo.startPos = panel.Position
        end
    end)
    panel.InputChanged:Connect(function(input)
        if dragInfo.dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragInfo.start
            panel.Position = UDim2.new(
                dragInfo.startPos.X.Scale, dragInfo.startPos.X.Offset + delta.X,
                dragInfo.startPos.Y.Scale, dragInfo.startPos.Y.Offset + delta.Y
            )
        end
    end)
    panel.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if dragInfo.dragging then
                dragInfo.dragging = false
                local pos = {
                    xs = panel.Position.X.Scale,
                    xo = panel.Position.X.Offset,
                    ys = panel.Position.Y.Scale,
                    yo = panel.Position.Y.Offset
                }
                local cur = M.loadBtnPositions()
                cur["_panel"] = pos
                pcall(function() writefile(M.MOB_POS_FILE, HS:JSONEncode(cur)) end)
            end
        end
    end)

    -- Définition des boutons du panel
    local btnDefs = {
        {"drop", "DROP", 0, 0, false},
        {"autoLeft", "AUTO\nLEFT", 1, 0, true},
        {"autoBat", "AIMBOT", 0, 1, true},
        {"autoRight", "AUTO\nRIGHT", 1, 1, true},
        {"tpDown", "TP\nDOWN", 0, 2, false},
        {"carrySpeed", "CARRY\nSPEED", 1, 2, true},
        {"lagger", "LAGGER\nMODE", 0, 3, true},
        {"laggerCarry", "LAGGER\nCARRY", 1, 3, true},
    }

    local function createPanelButton(key, label, col, row, isToggle)
        local xPos = PADDING + col * (BTN_SIZE + BTN_GAP)
        local yPos = PADDING + row * (BTN_SIZE + BTN_GAP)

        local btn = Instance.new("TextButton")
        btn.Name = "Btn_" .. key
        btn.Size = UDim2.new(0, BTN_SIZE, 0, BTN_SIZE)
        if savedPositions[key] and savedPositions[key].dragged then
            local sp = savedPositions[key]
            btn.Position = UDim2.new(sp.xs or 0, sp.xo or xPos, sp.ys or 0, sp.yo or yPos)
            btn:SetAttribute("Dragged", true)
        else
            btn.Position = UDim2.new(0, xPos, 0, yPos)
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        btn.Text = label
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamBold
        btn.TextWrapped = true
        btn.BorderSizePixel = 0
        btn.ZIndex = 101
        btn.AutoButtonColor = false
        btn:SetAttribute("BtnKey", key)
        btn.Parent = panel

        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
        btn.TextStrokeTransparency = 1

        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(80, 80, 80)
        stroke.Thickness = 1.2
        stroke.Transparency = 0.5

        local isOn = false
        local function setOn(v)
            isOn = v
            if v then
                TweenService:Create(btn, TweenInfo.new(0.12), {
                    BackgroundColor3 = CHERRY_ACCENT,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                }):Play()
                TweenService:Create(stroke, TweenInfo.new(0.12), {
                    Color = CHERRY_ACCENT,
                    Transparency = 0,
                }):Play()
            else
                TweenService:Create(btn, TweenInfo.new(0.12), {
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                }):Play()
                TweenService:Create(stroke, TweenInfo.new(0.12), {
                    Color = Color3.fromRGB(80, 80, 80),
                    Transparency = 0.5,
                }):Play()
            end
        end

        M.mobBtnRefs[key] = setOn

        -- Drag individuel
        local btnDragInfo = {dragging = false, start = nil, startPos = nil, moved = false}
        btn.InputBegan:Connect(function(input)
            if M.uiLocked then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                btnDragInfo.dragging = true
                btnDragInfo.moved = false
                btnDragInfo.start = input.Position
                btnDragInfo.startPos = btn.Position
            end
        end)
        btn.InputChanged:Connect(function(input)
            if btnDragInfo.dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - btnDragInfo.start
                if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then btnDragInfo.moved = true end
                btn.Position = UDim2.new(
                    btnDragInfo.startPos.X.Scale, btnDragInfo.startPos.X.Offset + delta.X,
                    btnDragInfo.startPos.Y.Scale, btnDragInfo.startPos.Y.Offset + delta.Y
                )
            end
        end)
        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if btnDragInfo.dragging then
                    btnDragInfo.dragging = false
                    if btnDragInfo.moved then
                        btn:SetAttribute("Dragged", true)
                        M.saveBtnPositions()
                    end
                end
            end
        end)

        -- Actions
        btn.Activated:Connect(function()
            if btnDragInfo.moved then return end
            
            if key == "drop" then
                TweenService:Create(btn, TweenInfo.new(0.1), {
                    BackgroundColor3 = CHERRY_ACCENT,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                }):Play()
                TweenService:Create(stroke, TweenInfo.new(0.1), {
                    Color = CHERRY_ACCENT,
                    Transparency = 0,
                }):Play()
                task.delay(0.3, function()
                    if not isOn then
                        TweenService:Create(btn, TweenInfo.new(0.1), {
                            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                        }):Play()
                        TweenService:Create(stroke, TweenInfo.new(0.1), {
                            Color = Color3.fromRGB(80, 80, 80),
                            Transparency = 0.5,
                        }):Play()
                    end
                end)
                M.runDrop()
            elseif key == "tpDown" then
                TweenService:Create(btn, TweenInfo.new(0.1), {
                    BackgroundColor3 = CHERRY_ACCENT,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                }):Play()
                TweenService:Create(stroke, TweenInfo.new(0.1), {
                    Color = CHERRY_ACCENT,
                    Transparency = 0,
                }):Play()
                task.delay(0.3, function()
                    if not isOn then
                        TweenService:Create(btn, TweenInfo.new(0.1), {
                            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                        }):Play()
                        TweenService:Create(stroke, TweenInfo.new(0.1), {
                            Color = Color3.fromRGB(80, 80, 80),
                            Transparency = 0.5,
                        }):Play()
                    end
                end)
                M.runTPFloor()
            elseif key == "autoLeft" then
                -- GROUPE EXCLUSIF 1 : AUTO LEFT
                local newState = not M.autoLeftEnabled
                setExclusiveGroup1(key, newState)
                M.autoLeftEnabled = newState
                if newState then
                    if M.autoRightEnabled then
                        M.autoRightEnabled = false
                        if M.mobBtnRefs.autoRight then M.mobBtnRefs.autoRight(false) end
                        if M.autoRightSetVisual then M.autoRightSetVisual(false) end
                    end
                    if M.autoBatEnabled then
                        M.autoBatEnabled = false
                        if M.mobBtnRefs.autoBat then M.mobBtnRefs.autoBat(false) end
                        if M.autoBatSetVisual then M.autoBatSetVisual(false) end
                        M.stopBatAimbot()
                    end
                    M.startAutoLeft()
                else
                    M.stopAutoLeft()
                end
                setOn(M.autoLeftEnabled)
                if M.autoLeftSetVisual then M.autoLeftSetVisual(M.autoLeftEnabled) end
                saveCherryConfig()
            elseif key == "autoRight" then
                -- GROUPE EXCLUSIF 1 : AUTO RIGHT
                local newState = not M.autoRightEnabled
                setExclusiveGroup1(key, newState)
                M.autoRightEnabled = newState
                if newState then
                    if M.autoLeftEnabled then
                        M.autoLeftEnabled = false
                        if M.mobBtnRefs.autoLeft then M.mobBtnRefs.autoLeft(false) end
                        if M.autoLeftSetVisual then M.autoLeftSetVisual(false) end
                    end
                    if M.autoBatEnabled then
                        M.autoBatEnabled = false
                        if M.mobBtnRefs.autoBat then M.mobBtnRefs.autoBat(false) end
                        if M.autoBatSetVisual then M.autoBatSetVisual(false) end
                        M.stopBatAimbot()
                    end
                    M.startAutoRight()
                else
                    M.stopAutoRight()
                end
                setOn(M.autoRightEnabled)
                if M.autoRightSetVisual then M.autoRightSetVisual(M.autoRightEnabled) end
                saveCherryConfig()
            elseif key == "autoBat" then
                -- GROUPE EXCLUSIF 3 : AIMBOT
                local newState = not M.autoBatEnabled
                setExclusiveGroup3(key, newState)
                M.autoBatEnabled = newState
                if newState then
                    if M.autoLeftEnabled then
                        M.autoLeftEnabled = false
                        if M.mobBtnRefs.autoLeft then M.mobBtnRefs.autoLeft(false) end
                        if M.autoLeftSetVisual then M.autoLeftSetVisual(false) end
                        M.stopAutoLeft()
                    end
                    if M.autoRightEnabled then
                        M.autoRightEnabled = false
                        if M.mobBtnRefs.autoRight then M.mobBtnRefs.autoRight(false) end
                        if M.autoRightSetVisual then M.autoRightSetVisual(false) end
                        M.stopAutoRight()
                    end
                    M.queueAutoBatStart()
                else
                    M.stopBatAimbot()
                end
                setOn(M.autoBatEnabled)
                if M.autoBatSetVisual then M.autoBatSetVisual(M.autoBatEnabled) end
                saveCherryConfig()
            elseif key == "lagger" then
                -- GROUPE EXCLUSIF 2 : LAGGER MODE
                local newState = not M.laggerModeEnabled
                setExclusiveGroup2(key, newState)
                M.laggerModeEnabled = newState
                setOn(M.laggerModeEnabled)
                if M.laggerModeBtn then M.laggerModeBtn.Text = M.laggerModeEnabled and "Lag On" or "Lag Off" end
                M.refreshSpeedModeLabel()
                saveCherryConfig()
            elseif key == "carrySpeed" then
                -- GROUPE EXCLUSIF 2 : CARRY SPEED
                local newState = not M.carrySpeedActive
                setExclusiveGroup2(key, newState)
                M.carrySpeedActive = newState
                setOn(M.carrySpeedActive)
                if M.carryModeBtn then M.carryModeBtn.Text = M.carrySpeedActive and "Carry On" or "Carry Off" end
                M.refreshSpeedModeLabel()
                saveCherryConfig()
            elseif key == "laggerCarry" then
                -- GROUPE EXCLUSIF 2 : LAGGER CARRY
                local newState = not M.laggerCarryActive
                setExclusiveGroup2(key, newState)
                M.laggerCarryActive = newState
                M.laggerModeEnabled = M.laggerCarryActive
                M.carrySpeedActive = M.laggerCarryActive
                setOn(M.laggerCarryActive)
                if M.laggerModeBtn then M.laggerModeBtn.Text = M.laggerModeEnabled and "Lag On" or "Lag Off" end
                if M.carryModeBtn then M.carryModeBtn.Text = M.carrySpeedActive and "Carry On" or "Carry Off" end
                M.refreshSpeedModeLabel()
                saveCherryConfig()
            end
        end)

        return btn, setOn
    end

    for _, def in ipairs(btnDefs) do
        createPanelButton(def[1], def[2], def[3], def[4], def[5])
    end

    -- Mise à jour initiale des états
    if M.mobBtnRefs.autoLeft then M.mobBtnRefs.autoLeft(M.autoLeftEnabled) end
    if M.mobBtnRefs.autoRight then M.mobBtnRefs.autoRight(M.autoRightEnabled) end
    if M.mobBtnRefs.autoBat then M.mobBtnRefs.autoBat(M.autoBatEnabled) end
    if M.mobBtnRefs.lagger then M.mobBtnRefs.lagger(M.laggerModeEnabled) end
    if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(M.carrySpeedActive) end
    if M.mobBtnRefs.laggerCarry then M.mobBtnRefs.laggerCarry(M.laggerCarryActive or (M.laggerModeEnabled and M.carrySpeedActive)) end

    -- ============================================================
    -- BOUTON BYPASS (GROUPE EXCLUSIF 3 AVEC AIMBOT)
    -- ============================================================
    local batBtnX = panelXO + PADDING
    local batBtnY = panelYO + PADDING + BTN_SIZE + BTN_GAP
    local bypassX = batBtnX - BTN_SIZE - BTN_GAP
    local bypassY = batBtnY

    local bypassBtn = Instance.new("TextButton")
    bypassBtn.Name = "BypassBtn"
    bypassBtn.Size = UDim2.new(0, BTN_SIZE, 0, BTN_SIZE)
    if savedPositions["bypass"] and savedPositions["bypass"].dragged then
        local sp = savedPositions["bypass"]
        bypassBtn.Position = UDim2.new(sp.xs or 0, sp.xo or 0, sp.ys or 0, sp.yo or 0)
        bypassBtn:SetAttribute("Dragged", true)
    else
        bypassBtn.Position = UDim2.new(0, bypassX, 0, bypassY)
    end
    bypassBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bypassBtn.Text = "BYPASS"
    bypassBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    bypassBtn.TextSize = 12
    bypassBtn.Font = Enum.Font.GothamBold
    bypassBtn.TextWrapped = true
    bypassBtn.BorderSizePixel = 0
    bypassBtn.ZIndex = 101
    bypassBtn.AutoButtonColor = false
    bypassBtn:SetAttribute("BtnKey", "bypass")
    bypassBtn.Parent = mobGui
    Instance.new("UICorner", bypassBtn).CornerRadius = UDim.new(0, 10)
    
    local bypassStroke = Instance.new("UIStroke", bypassBtn)
    bypassStroke.Color = Color3.fromRGB(80, 80, 80)
    bypassStroke.Thickness = 1.2
    bypassStroke.Transparency = 0.5

    local bypassOn = M.bypassAimbotEnabled
    local function setBypassOn(v)
        bypassOn = v
        if v then
            TweenService:Create(bypassBtn, TweenInfo.new(0.12), {
                BackgroundColor3 = CHERRY_ACCENT,
                TextColor3 = Color3.fromRGB(0, 0, 0),
            }):Play()
            TweenService:Create(bypassStroke, TweenInfo.new(0.12), {
                Color = CHERRY_ACCENT,
                Transparency = 0,
            }):Play()
        else
            TweenService:Create(bypassBtn, TweenInfo.new(0.12), {
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                TextColor3 = Color3.fromRGB(255, 255, 255),
            }):Play()
            TweenService:Create(bypassStroke, TweenInfo.new(0.12), {
                Color = Color3.fromRGB(80, 80, 80),
                Transparency = 0.5,
            }):Play()
        end
    end
    M.mobBtnRefs.bypass = setBypassOn
    setBypassOn(bypassOn)

    local bDragInfo = {dragging = false, start = nil, startPos = nil, moved = false}
    bypassBtn.InputBegan:Connect(function(input)
        if M.uiLocked then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            bDragInfo.dragging = true
            bDragInfo.moved = false
            bDragInfo.start = input.Position
            bDragInfo.startPos = bypassBtn.Position
        end
    end)
    bypassBtn.InputChanged:Connect(function(input)
        if bDragInfo.dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - bDragInfo.start
            if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then bDragInfo.moved = true end
            bypassBtn.Position = UDim2.new(
                bDragInfo.startPos.X.Scale, bDragInfo.startPos.X.Offset + delta.X,
                bDragInfo.startPos.Y.Scale, bDragInfo.startPos.Y.Offset + delta.Y
            )
        end
    end)
    bypassBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if bDragInfo.dragging then
                bDragInfo.dragging = false
                if bDragInfo.moved then
                    bypassBtn:SetAttribute("Dragged", true)
                    M.saveBtnPositions()
                end
            end
        end
    end)

    bypassBtn.Activated:Connect(function()
        if bDragInfo.moved then return end
        -- GROUPE EXCLUSIF 3 : BYPASS
        local newState = not M.bypassAimbotEnabled
        setExclusiveGroup3("bypass", newState)
        M.bypassAimbotEnabled = newState
        if newState then
            if M.autoBatEnabled then
                M.autoBatEnabled = false
                if M.mobBtnRefs.autoBat then M.mobBtnRefs.autoBat(false) end
                if M.autoBatSetVisual then M.autoBatSetVisual(false) end
                M.stopBatAimbot()
            end
            M.startBypassAimbot()
        else
            M.stopBypassAimbot()
        end
        setBypassOn(M.bypassAimbotEnabled)
        if M.setBypassVisual then M.setBypassVisual(M.bypassAimbotEnabled) end
        saveCherryConfig()
    end)

    M.bypassFloatingBtn = bypassBtn

    -- INSTA RESET floating button removed (RXZ HUB)
end

-- Mise à jour de M.mobBtnRefs pour inclure bypass (pour la compatibilité)
M.mobBtnRefs = M.mobBtnRefs or {}

-- ============================================================
-- CONFIG SAVE/LOAD
-- ============================================================
local CHERRY_CONFIG_NAME = "CherryConfig.json"
local CherryConfig = { Theme="Default" }
local CHERRY_THEMES = {
    Default     = { Accent=CHERRY_ACCENT, AccentDim=Color3.fromRGB(0, 50, 150) },
}

local function loadCherryConfig()
    if type(readfile)~="function" or type(isfile)~="function" then return end
    local ok,d = pcall(function()
        if not isfile(CHERRY_CONFIG_NAME) then return nil end
        return HS:JSONDecode(readfile(CHERRY_CONFIG_NAME))
    end)
    if ok and type(d)=="table" then
        if type(d.Theme)=="string" and CHERRY_THEMES[d.Theme] then CherryConfig.Theme=d.Theme end
        if type(d.normalSpeed)=="number" then M.NS=d.normalSpeed end
        if type(d.carrySpeed)=="number" then M.CS=d.carrySpeed end
        if type(d.laggerSpeed)=="number" then M.LAGGER_SPEED=d.laggerSpeed end
        if type(d.laggerCarrySpeed)=="number" then M.LAGGER_CARRY_SPEED=d.laggerCarrySpeed end
        if type(d.grabRadius)=="number" then M.Steal.StealRadius=d.grabRadius end
        if type(d.stealDuration)=="number" then M.Steal.StealDuration=d.stealDuration end
        if type(d.stealMode)=="string" then M.stealMode=d.stealMode end
        if type(d.autoTPHeight)=="number" then M.autoTPHeight=d.autoTPHeight end
        if type(d.fovValue)=="number" then M.fovValue=d.fovValue end
        if type(d.uiScale)=="number" then M.uiScale=d.uiScale end
        if type(d.bgTransparency)=="number" then M.bgTransparency=d.bgTransparency end
        if type(d.uiLocked)=="boolean" then M.uiLocked=d.uiLocked end
        if type(d.infJumpMode)=="string" then M.infJumpMode=d.infJumpMode end
        if type(d.dropMode)=="string" then M.dropMode=d.dropMode end
        if type(d.mobileButtonsSize)=="number" then M.mobileButtonsSize=d.mobileButtonsSize end
        if type(d.skyTheme)=="string" then M.currentSkyTheme=d.skyTheme end
        if type(d.stealBarSize)=="number" then M.stealBarSize=d.stealBarSize end
        if type(d.stealBarScale)=="number" then M.stealBarScale=d.stealBarScale end
        if d.carrySpeedActive~=nil then M.carrySpeedActive=d.carrySpeedActive end
        if d.laggerModeEnabled~=nil then M.laggerModeEnabled=d.laggerModeEnabled end
        if d.laggerCarryActive~=nil then M.laggerCarryActive=d.laggerCarryActive end
        if d.autoSwing~=nil then M.autoSwingEnabled=d.autoSwing==true end
        if d.introSoundEnabled~=nil then M.introSoundEnabled=d.introSoundEnabled==true end
        if d.introSongChoice then M.introSongChoice=d.introSongChoice end
        if d.introGUIEnabled~=nil then M.introGUIEnabled=d.introGUIEnabled==true end
        if d.ragdollGui~=nil then M.ragdollGuiEnabled=d.ragdollGui==true end
        if d.circleButtonsEnabled~=nil then M.circleButtonsEnabled=d.circleButtonsEnabled==true end
        if d.perButtonDrag~=nil then M.perButtonDragEnabled=d.perButtonDrag==true end
        if d.mobileButtonsEnabled~=nil then M.mobileButtonsEnabled=d.mobileButtonsEnabled end
        if d.medusaReset~=nil then M.medusaResetEnabled=d.medusaReset==true end
        if d.autoMoveSwing~=nil then M.autoMoveSwingEnabled=d.autoMoveSwing==true end
        if d.autoSwitchSpeed~=nil then M.autoSwitchSpeedEnabled=d.autoSwitchSpeed==true end
        if d.showPlayerSpeeds~=nil then M.showPlayerSpeeds=d.showPlayerSpeeds==true end
        if d.nukeOptimizer~=nil then M.nukeOn=d.nukeOptimizer end
        if d.removeAcc~=nil then M.removeAccEnabled=d.removeAcc end
        if d.playerESPEnabled~=nil then M.playerESPEnabled=d.playerESPEnabled end
        if d.antiRagdoll~=nil then M.antiRagdollEnabled=d.antiRagdoll end
        if d.autoStealEnabled~=nil then M.Steal.AutoStealEnabled=d.autoStealEnabled end
        if d.infiniteJump~=nil then M.infJumpEnabled=d.infiniteJump end
        if d.medusaCounter~=nil then M.medusaCounterEnabled=d.medusaCounter end
        if d.batCounter~=nil then M.batCounterEnabled=d.batCounter end
        if d.unwalkEnabled~=nil then M.unwalkEnabled=d.unwalkEnabled end
        if d.autoCarryOnGrab~=nil then M.autoCarryOnGrab=d.autoCarryOnGrab==true end
        if d.pingAlertEnabled~=nil then M.pingAlertEnabled=d.pingAlertEnabled==true end
        if d.antiLag~=nil then M.antiLagEnabled=d.antiLag end
        if d.stretchRez~=nil then M.stretchRezEnabled=d.stretchRez end
        if d.autoTPEnabled~=nil then M.autoTPEnabled=d.autoTPEnabled end
        if d.antiKick~=nil then M.antiKickEnabled=d.antiKick end
        if d.autoBat~=nil then M.autoBatEnabled=d.autoBat end
        if d.semiHoldMin then M.Semi.HoldMin=d.semiHoldMin end
        if d.semiHoldMax then M.Semi.HoldMax=d.semiHoldMax end
        if d.semiEntryDelay then M.Semi.EntryDelay=d.semiEntryDelay end
        if d.semiStealRange then M.Semi.StealRange=d.semiStealRange end
        if d.semiPrimeRange then M.Semi.PrimeRange=d.semiPrimeRange end
        if d.lineESPEnabled~=nil then M.lineESPEnabled=d.lineESPEnabled end
        if d.speedESPEnabled~=nil then M.speedESPEnabled=d.speedESPEnabled end
        if d.autoResetOnDeath~=nil then M.autoResetOnDeath=d.autoResetOnDeath end
        if type(d.animPack)=="string" then M.animPack=d.animPack end
        if d.headlessEnabled~=nil then M.headlessEnabled=d.headlessEnabled end
        if d.korbloxEnabled~=nil then M.korbloxEnabled=d.korbloxEnabled end
        if d.bodyLockEnabled~=nil then M.bodyLockEnabled=d.bodyLockEnabled end
        if type(d.bodyLockRadius)=="number" then M.bodyLockRadius=d.bodyLockRadius end
        if d.bypassAimbotEnabled~=nil then M.bypassAimbotEnabled=d.bypassAimbotEnabled end
        if d.bypassAimbotMode then M.bypassAimbotMode=d.bypassAimbotMode end
        if d.animPackEnabled~=nil then M.animPackEnabled=d.animPackEnabled end
        local function lk(e,d2)
            if type(d2)~="table" then return end
            if d2.kb and Enum.KeyCode[d2.kb] then e.kb=Enum.KeyCode[d2.kb] else e.kb=nil end
            if d2.gp and Enum.KeyCode[d2.gp] then e.gp=Enum.KeyCode[d2.gp] else e.gp=nil end
        end
        if d.dropBrainrotKey then lk(M.KB.DropBrainrot,d.dropBrainrotKey) end
        if d.autoLeftKey then lk(M.KB.AutoLeft,d.autoLeftKey) end
        if d.autoRightKey then lk(M.KB.AutoRight,d.autoRightKey) end
        if d.autoBatKey then lk(M.KB.AutoBat,d.autoBatKey) end
        if d.laggerToggleKey then lk(M.KB.LaggerToggle,d.laggerToggleKey) end
        if d.tpFloorKey then lk(M.KB.TPFloor,d.tpFloorKey) end
        if d.instaResetKey then lk(M.KB.InstaReset,d.instaResetKey) end
        if d.guiHideKey then lk(M.KB.GuiHide,d.guiHideKey) end
        if d.speedToggleKey then lk(M.KB.SpeedToggle,d.speedToggleKey) end
        if d.bypassAimbotKey then lk(M.KB.BypassAimbot,d.bypassAimbotKey) end
        if d.bodyLockKey then lk(M.KB.BodyLock,d.bodyLockKey) end
    end
end

local function saveCherryConfig()
    if type(writefile)~="function" then return end
    local function ks(e)
        if e.kb then return {kb=e.kb.Name,gp=e.gp and e.gp.Name}
        elseif e.gp then return {gp=e.gp.Name}
        else return {kb=nil,gp=nil} end
    end
    local cfg = {
        Theme=CherryConfig.Theme,
        normalSpeed=M.NS, carrySpeed=M.CS, laggerSpeed=M.LAGGER_SPEED,
        laggerCarrySpeed=M.LAGGER_CARRY_SPEED, grabRadius=M.Steal.StealRadius,
        stealDuration=M.Steal.StealDuration, stealMode=M.stealMode,
        autoTPHeight=M.autoTPHeight, fovValue=M.fovValue, uiScale=M.uiScale,
        bgImageId=M.bgImageId, bgTransparency=M.bgTransparency, uiLocked=M.uiLocked,
        infJumpMode=M.infJumpMode, dropMode=M.dropMode,
        mobileButtonsSize=M.mobileButtonsSize, skyTheme=M.currentSkyTheme,
        stealBarSize=M.stealBarSize, stealBarScale=M.stealBarScale,
        carrySpeedActive=M.carrySpeedActive, laggerModeEnabled=M.laggerModeEnabled,
        laggerCarryActive=M.laggerCarryActive,
        autoSwing=M.autoSwingEnabled, introSoundEnabled=M.introSoundEnabled,
        introSongChoice=M.introSongChoice,
        introGUIEnabled=M.introGUIEnabled,
        ragdollGui=M.ragdollGuiEnabled, circleButtonsEnabled=M.circleButtonsEnabled,
        perButtonDrag=M.perButtonDragEnabled, mobileButtonsEnabled=M.mobileButtonsEnabled,
        medusaReset=M.medusaResetEnabled, autoMoveSwing=M.autoMoveSwingEnabled,
        autoSwitchSpeed=M.autoSwitchSpeedEnabled, showPlayerSpeeds=M.showPlayerSpeeds,
        nukeOptimizer=M.nukeOn, removeAcc=M.removeAccEnabled,
        playerESPEnabled=M.playerESPEnabled,
        autoStealEnabled=M.Steal.AutoStealEnabled,
        antiRagdoll=M.antiRagdollEnabled, infiniteJump=M.infJumpEnabled,
        medusaCounter=M.medusaCounterEnabled, batCounter=M.batCounterEnabled,
        unwalkEnabled=M.unwalkEnabled, autoCarryOnGrab=M.autoCarryOnGrab, pingAlertEnabled=M.pingAlertEnabled, antiLag=M.antiLagEnabled,
        stretchRez=M.stretchRezEnabled, autoTPEnabled=M.autoTPEnabled,
        antiKick=M.antiKickEnabled, autoBat=M.autoBatEnabled,
        semiHoldMin=M.Semi.HoldMin, semiHoldMax=M.Semi.HoldMax,
        semiEntryDelay=M.Semi.EntryDelay, semiStealRange=M.Semi.StealRange,
        semiPrimeRange=M.Semi.PrimeRange,
        lineESPEnabled=M.lineESPEnabled,
        speedESPEnabled=M.speedESPEnabled,
        autoResetOnDeath=M.autoResetOnDeath,
        animPack=M.animPack,
        headlessEnabled=M.headlessEnabled,
        korbloxEnabled=M.korbloxEnabled,
        bodyLockEnabled=M.bodyLockEnabled,
        bodyLockRadius=M.bodyLockRadius,
        bypassAimbotEnabled=M.bypassAimbotEnabled,
        bypassAimbotMode=M.bypassAimbotMode,
        animPackEnabled=M.animPackEnabled,
        dropBrainrotKey=ks(M.KB.DropBrainrot), autoLeftKey=ks(M.KB.AutoLeft),
        autoRightKey=ks(M.KB.AutoRight), autoBatKey=ks(M.KB.AutoBat),
        laggerToggleKey=ks(M.KB.LaggerToggle), tpFloorKey=ks(M.KB.TPFloor),
        instaResetKey=ks(M.KB.InstaReset), guiHideKey=ks(M.KB.GuiHide),
        speedToggleKey=ks(M.KB.SpeedToggle), bypassAimbotKey=ks(M.KB.BypassAimbot),
        bodyLockKey=ks(M.KB.BodyLock),
    }
    pcall(function() writefile(CHERRY_CONFIG_NAME, HS:JSONEncode(cfg)) end)
end

M.saveConfig = saveCherryConfig

-- ============================================================
-- CHERRY ESP
-- ============================================================
local RunService2 = game:GetService("RunService")
local cherryESPState = { LineESP=false, SpeedESP=false }
local cherryESPObjects = {}
local DrawingAvailable = false
pcall(function() DrawingAvailable = Drawing and type(Drawing.new)=="function" end)

local function cherryRemoveESP(p)
    local r = cherryESPObjects[p]
    if not r then return end
    for _,o in pairs(r) do pcall(function()
        if typeof(o)=="Instance" then o:Destroy()
        elseif o.Remove then o:Remove() end
    end) end
    cherryESPObjects[p]=nil
end

local function cherryGetSpeed(root)
    local v
    pcall(function() v=root.AssemblyLinearVelocity end)
    if not v then pcall(function() v=root.Velocity end) end
    if not v then return 0 end
    return Vector3.new(v.X,0,v.Z).Magnitude
end

local function cherryCreateESP(p)
    if cherryESPObjects[p] then return cherryESPObjects[p] end
    local r={}
    local hl=Instance.new("Highlight")
    hl.FillTransparency=1; hl.OutlineTransparency=0
    hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    hl.Enabled=false; hl.Parent=workspace
    r.Highlight=hl
    local bb=Instance.new("BillboardGui")
    bb.Size=UDim2.fromOffset(150,32); bb.StudsOffset=Vector3.new(0,3.25,0)
    bb.AlwaysOnTop=true; bb.Enabled=false; bb.ResetOnSpawn=false
    bb.Parent=player:WaitForChild("PlayerGui")
    local sl=Instance.new("TextLabel",bb)
    sl.Size=UDim2.fromScale(1,1); sl.BackgroundTransparency=1; sl.Text="0.0 spd"
    sl.TextStrokeColor3=Color3.new(0,0,0); sl.TextStrokeTransparency=0
    sl.Font=Enum.Font.GothamBlack; sl.TextSize=18
    sl.TextXAlignment=Enum.TextXAlignment.Center; sl.TextYAlignment=Enum.TextYAlignment.Center
    r.Billboard=bb; r.SpeedText=sl
    if DrawingAvailable then
        local ln=Drawing.new("Line")
        ln.Visible=false; ln.Thickness=2.75; ln.Transparency=1
        r.Line=ln
    end
    cherryESPObjects[p]=r
    return r
end

Players.PlayerRemoving:Connect(function(p) cherryRemoveESP(p) end)

-- Hide all ESP visuals (used when ESP is toggled off, so the early-exit
-- in the render loop doesn't leave stale highlights/lines on screen).
local function cherryHideAllESP()
    for _,r in pairs(cherryESPObjects) do
        pcall(function()
            if r.Highlight then r.Highlight.Enabled=false; r.Highlight.Adornee=nil end
            if r.Billboard then r.Billboard.Enabled=false; r.Billboard.Adornee=nil end
            if r.Line then r.Line.Visible=false end
        end)
    end
end
M.cherryHideAllESP = cherryHideAllESP

RunService2.RenderStepped:Connect(function()
    -- Skip all per-frame ESP work when neither ESP mode is on (zero idle cost)
    if not cherryESPState.LineESP and not cherryESPState.SpeedESP then
        return
    end
    local cam=workspace.CurrentCamera; if not cam then return end
    local lc=player.Character
    local lr=lc and lc:FindFirstChild("HumanoidRootPart")
    local lineStart=Vector2.new(cam.ViewportSize.X*0.5, cam.ViewportSize.Y*0.82)
    if lr then
        local rp,rv=cam:WorldToViewportPoint(lr.Position)
        if rv and rp.Z>0 then lineStart=Vector2.new(rp.X,rp.Y) end
    end
    for _,p in ipairs(Players:GetPlayers()) do
        if p==player then continue end
        local r=cherryCreateESP(p)
        local ch=p.Character
        local hum=ch and ch:FindFirstChildOfClass("Humanoid")
        local root=ch and ch:FindFirstChild("HumanoidRootPart")
        local head=ch and ch:FindFirstChild("Head")
        local alive=ch and hum and root and hum.Health>0
        if not alive then
            if r.Line then r.Line.Visible=false end
            r.Highlight.Enabled=false; r.Billboard.Enabled=false
            r.Highlight.Adornee=nil; r.Billboard.Adornee=nil
            continue
        end
        r.Highlight.Adornee=ch; r.Highlight.Enabled=cherryESPState.LineESP
        r.Highlight.OutlineColor=CHERRY_ACCENT
        if r.Line then
            local tp,tv=cam:WorldToViewportPoint(root.Position)
            if cherryESPState.LineESP and tv and tp.Z>0 then
                r.Line.From=lineStart; r.Line.To=Vector2.new(tp.X,tp.Y)
                r.Line.Color=CHERRY_ACCENT; r.Line.Thickness=2.75; r.Line.Visible=true
            else r.Line.Visible=false end
        end
        if cherryESPState.SpeedESP and head then
            r.Billboard.Adornee=head; r.Billboard.Enabled=true
            r.SpeedText.Text=string.format("%.1f spd",cherryGetSpeed(root))
            r.SpeedText.TextColor3=CHERRY_ACCENT
        else r.Billboard.Enabled=false; r.Billboard.Adornee=nil end
    end
end)

-- ============================================================
function M.trackConn(conn) table.insert(M._persistentConns,conn); return conn end
function M.clearPersistentConns()
    for _,c in ipairs(M._persistentConns) do pcall(function() c:Disconnect() end) end
    M._persistentConns={}
end

function M.makeNumberCallback(tbl,key,min,max)
    return function(v)
        if min and v<min then return end
        if max and v>max then return end
        tbl[key]=v
        if key=="mobileButtonsSize" and M.mobileButtonsEnabled then M.buildMobileButtons() end
        if key=="stealBarSize" then M.buildStatusUI() end
        saveCherryConfig()
    end
end

-- ============================================================
-- K7 HUB STYLE MENU (Blue theme, left-aligned)
-- ============================================================
function M.buildGui()
    M.clearPersistentConns()

    for _,n in ipairs({"MoveeDuels","Cherry_Menu","K7HubGUI"}) do
        local cg=game:GetService("CoreGui")
        local old=cg:FindFirstChild(n); if old then old:Destroy() end
        local pg=player:FindFirstChild("PlayerGui")
        if pg then local o=pg:FindFirstChild(n); if o then o:Destroy() end end
    end

    M.buildStatusUI()

    local gui = Instance.new("ScreenGui")
    gui.Name = "K7HubGUI"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = player:WaitForChild("PlayerGui")
    M.mainFrame = gui

    local main = Instance.new("ImageLabel")
    main.Name = "Main"
    main.Size = UDim2.new(0, 230, 0, 420)
    main.Position = UDim2.new(0, 10, 0.5, -180)
    main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    main.BackgroundTransparency = 0
    main.Image = "rbxassetid://" .. tostring(M.BG_IMAGE_DEFAULT)
    main.ImageTransparency = M.bgTransparency
    main.ScaleType = Enum.ScaleType.Crop
    main.BorderSizePixel = 0
    main.Active = true
    main.ClipsDescendants = true
    main.Parent = gui
    M.mainFrame = main
    M.applyBackground = function()
        if not M.mainFrame then return end
        pcall(function()
            M.mainFrame.Image = "rbxassetid://" .. tostring(M.BG_IMAGE_DEFAULT)
            M.mainFrame.ImageTransparency = M.bgTransparency
        end)
    end

    local uiScale = Instance.new("UIScale")
    uiScale.Scale = M.uiScale or 1
    uiScale.Parent = main
    M.uiScaleRef = uiScale

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 18)
    mainCorner.Parent = main

    local overlay = Instance.new("Frame")
    overlay.Name = "Overlay"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.15
    overlay.BorderSizePixel = 0
    overlay.Parent = main
    local overlayCorner = Instance.new("UICorner")
    overlayCorner.CornerRadius = UDim.new(0, 18)
    overlayCorner.Parent = overlay

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundTransparency = 1
    header.Active = true
    header.Parent = main

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 130, 1, 0)
    title.Position = UDim2.new(0, 12, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "RXZ HUB"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 28, 0, 28)
    minimizeButton.Position = UDim2.new(1, -40, 0.5, -14)
    minimizeButton.BackgroundColor3 = CHERRY_ACCENT
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = "−"
    minimizeButton.TextColor3 = Color3.fromRGB(10,10,15)
    minimizeButton.Font = Enum.Font.GothamBlack
    minimizeButton.TextSize = 24
    minimizeButton.AutoButtonColor = false
    minimizeButton.Parent = header
    Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 8)

    local lockButton = Instance.new("TextButton")
    lockButton.Size = UDim2.new(0, 28, 0, 28)
    lockButton.Position = UDim2.new(1, -78, 0.5, -14)
    lockButton.BackgroundColor3 = Color3.fromRGB(25,25,40)
    lockButton.BorderSizePixel = 0
    lockButton.Text = M.uiLocked and "🔒" or "🔓"
    lockButton.TextColor3 = Color3.fromRGB(255,170,0)
    lockButton.Font = Enum.Font.Gotham
    lockButton.TextSize = 14
    lockButton.AutoButtonColor = false
    lockButton.Parent = header
    Instance.new("UICorner", lockButton).CornerRadius = UDim.new(0, 8)
    lockButton.Activated:Connect(function()
        M.uiLocked = not M.uiLocked
        lockButton.Text = M.uiLocked and "🔒" or "🔓"
        saveCherryConfig()
    end)

    local headerDivider = Instance.new("Frame")
    headerDivider.Size = UDim2.new(1, 0, 0, 1)
    headerDivider.Position = UDim2.new(0, 0, 0, 50)
    headerDivider.BackgroundColor3 = Color3.fromRGB(45,45,60)
    headerDivider.BorderSizePixel = 0
    headerDivider.Parent = main

    -- ===== SINGLE PAGE (tabs removed: everything in one scroll) =====
    local TAB_BAR_H = 0

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "Content"
    scroll.Size = UDim2.new(1, 0, 1, -51)
    scroll.Position = UDim2.new(0, 0, 0, 51)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
    scroll.Visible = true
    scroll.Parent = main
    local contentLayout = Instance.new("UIListLayout", scroll)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 0)

    local function beginTab(_) end
    local function selectTab(_) end


    local dragging = false
    local dragStart, startPos
    local function startDrag(input)
        if M.uiLocked then return end
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
        end
    end)
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local reopenBtn = Instance.new("TextButton", gui)
    reopenBtn.Name = "ReopenBtn"
    M.reopenBtn = reopenBtn
    -- shared hide/show used by the keybind and the Main-tab button
    M.toggleHideUI = function()
        if not M.mainFrame then return end
        M.mainFrame.Visible = not M.mainFrame.Visible
        reopenBtn.Visible = not M.mainFrame.Visible
    end
    reopenBtn.Size = UDim2.new(0, 150, 0, 40)
    local _savedPos = (M.loadBtnPositions and M.loadBtnPositions()) or {}
    if _savedPos["reopen"] then
        local sp = _savedPos["reopen"]
        reopenBtn.Position = UDim2.new(sp.xs or 0, sp.xo or 20, sp.ys or 0, sp.yo or 80)
    else
        reopenBtn.Position = UDim2.new(0, 20, 0, 80)
    end
    reopenBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    reopenBtn.Text = "RXZ HUB"
    reopenBtn.TextColor3 = CHERRY_ACCENT
    reopenBtn.Font = Enum.Font.GothamBold
    reopenBtn.TextSize = 16
    reopenBtn.AutoButtonColor = false
    reopenBtn.Visible = false
    reopenBtn:SetAttribute("BtnKey", "reopen")
    Instance.new("UICorner", reopenBtn).CornerRadius = UDim.new(0, 12)
    local reopenStroke = Instance.new("UIStroke", reopenBtn)
    reopenStroke.Color = CHERRY_ACCENT
    reopenStroke.Thickness = 1.5
    reopenStroke.Transparency = 0.5
    minimizeButton.Activated:Connect(function()
        main.Visible = false
        reopenBtn.Visible = true
    end)

    -- saves just the reopen button's position (it lives in the menu GUI,
    -- which M.saveBtnPositions doesn't scan, so it writes its own entry)
    local function saveReopenPos()
        if type(writefile) ~= "function" then return end
        local cur = (M.loadBtnPositions and M.loadBtnPositions()) or {}
        cur["reopen"] = {xs=reopenBtn.Position.X.Scale, xo=reopenBtn.Position.X.Offset,
                          ys=reopenBtn.Position.Y.Scale, yo=reopenBtn.Position.Y.Offset}
        pcall(function() writefile(M.MOB_POS_FILE, HS:JSONEncode(cur)) end)
    end

    local rDrag = {dragging=false, start=nil, startPos=nil, moved=false}
    reopenBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            rDrag.dragging=true; rDrag.moved=false
            rDrag.start=input.Position; rDrag.startPos=reopenBtn.Position
        end
    end)
    reopenBtn.InputChanged:Connect(function(input)
        if rDrag.dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - rDrag.start
            if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then rDrag.moved=true end
            reopenBtn.Position = UDim2.new(rDrag.startPos.X.Scale, rDrag.startPos.X.Offset + delta.X,
                                           rDrag.startPos.Y.Scale, rDrag.startPos.Y.Offset + delta.Y)
        end
    end)
    reopenBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if rDrag.dragging then
                rDrag.dragging=false
                saveReopenPos()
            end
        end
    end)
    reopenBtn.Activated:Connect(function()
        if rDrag.moved then return end
        main.Visible = true
        reopenBtn.Visible = false
    end)

    local layoutOrder = 0
    local function getOrder() layoutOrder += 1 return layoutOrder end

    local function createDivider()
        local div = Instance.new("Frame")
        div.Size = UDim2.new(1, 0, 0, 1)
        div.BackgroundColor3 = Color3.fromRGB(45,45,60)
        div.BorderSizePixel = 0
        div.LayoutOrder = getOrder()
        div.Parent = scroll
    end

    local function createSectionHeader(text)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 35)
        frame.BackgroundTransparency = 1
        frame.LayoutOrder = getOrder()
        frame.Parent = scroll
        local lbl = Instance.new("TextLabel", frame)
        lbl.Size = UDim2.new(1, -40, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text:upper()
        lbl.TextColor3 = CHERRY_ACCENT
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextYAlignment = Enum.TextYAlignment.Bottom
    end

    local function createRow()
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 50)
        row.BackgroundTransparency = 1
        row.LayoutOrder = getOrder()
        row.Parent = scroll
        return row
    end

    M._anyKeyListening = false
    local activeKBBtn = nil
    M.keybindButtons = M.keybindButtons or {}
    local listeningTimeout = nil

    local function resetKeybindCapture()
        if activeKBBtn then
            for e,b in pairs(M.keybindButtons) do
                if b == activeKBBtn then
                    b.Text = (e.kb and e.kb.Name) or (e.gp and e.gp.Name) or "..."
                    b.TextColor3 = Color3.fromRGB(180,180,185)
                    break
                end
            end
            activeKBBtn = nil
            M._anyKeyListening = false
            if listeningTimeout then task.cancel(listeningTimeout); listeningTimeout = nil end
        end
    end

    local function createKeybind(text, kbEntry)
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 220, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0, 70, 0, 30)
        btn.Position = UDim2.new(1, -90, 0.5, -15)
        btn.BackgroundColor3 = Color3.fromRGB(25,25,40)
        btn.BorderSizePixel = 0
        btn.Text = (kbEntry.kb and kbEntry.kb.Name) or (kbEntry.gp and kbEntry.gp.Name) or "..."
        btn.TextColor3 = Color3.fromRGB(180,180,185)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.AutoButtonColor = false
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        M.keybindButtons[kbEntry] = btn

        btn.MouseButton1Click:Connect(function()
            if activeKBBtn and activeKBBtn ~= btn then resetKeybindCapture() end
            activeKBBtn = btn
            btn.Text = "..."
            btn.TextColor3 = Color3.fromRGB(255,90,90)
            M._anyKeyListening = true
            if listeningTimeout then task.cancel(listeningTimeout) end
            listeningTimeout = task.delay(5, resetKeybindCapture)
        end)

        createDivider()
        return row
    end

    local function kbMatch(entry, keycode)
        if not entry then return false end
        if entry.kb and entry.kb == keycode then return true end
        if entry.gp and entry.gp == keycode then return true end
        return false
    end

    M._keybindCaptureConn = UIS.InputBegan:Connect(function(input, gameProcessed)
        if M._anyKeyListening then
            if activeKBBtn then
                local kc = input.KeyCode
                if kc == Enum.KeyCode.Escape then
                    resetKeybindCapture()
                    saveCherryConfig()
                    return
                end
                if input.UserInputType == Enum.UserInputType.Keyboard and kc ~= Enum.KeyCode.Unknown then
                    for e,b in pairs(M.keybindButtons) do
                        if b == activeKBBtn then
                            e.kb = kc
                            e.gp = nil
                            b.Text = kc.Name
                            b.TextColor3 = Color3.fromRGB(180,180,185)
                            activeKBBtn = nil
                            M._anyKeyListening = false
                            if listeningTimeout then task.cancel(listeningTimeout) end
                            saveCherryConfig()
                            break
                        end
                    end
                elseif input.UserInputType == Enum.UserInputType.Gamepad1 or input.UserInputType == Enum.UserInputType.Gamepad2 then
                    if kc ~= Enum.KeyCode.Unknown then
                        for e,b in pairs(M.keybindButtons) do
                            if b == activeKBBtn then
                                e.gp = kc
                                e.kb = nil
                                b.Text = kc.Name
                                b.TextColor3 = Color3.fromRGB(180,180,185)
                                activeKBBtn = nil
                                M._anyKeyListening = false
                                if listeningTimeout then task.cancel(listeningTimeout) end
                                saveCherryConfig()
                                break
                            end
                        end
                    end
                end
            end
            return
        end

        if gameProcessed then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType ~= Enum.UserInputType.Gamepad1 and input.UserInputType ~= Enum.UserInputType.Gamepad2 then return end
        local kc = input.KeyCode
        if kc == Enum.KeyCode.Unknown then return end

        if kbMatch(M.KB.LaggerToggle, kc) then M.keybindLaggerMode() end
        if kbMatch(M.KB.SpeedToggle, kc) then M.keybindNormalMode() end
        if kbMatch(M.KB.DropBrainrot, kc) then M.runDrop() end
        if kbMatch(M.KB.TPFloor, kc) then M.runTPFloor() end
        if kbMatch(M.KB.InstaReset, kc) then M.cursedInstaReset() end
        if kbMatch(M.KB.AutoLeft, kc) then
            M.autoLeftEnabled = not M.autoLeftEnabled
            if M.autoLeftEnabled then
                if M.autoRightEnabled then M.autoRightEnabled = false; M.stopAutoRight() end
                if M.autoBatEnabled then M.stopBatAimbot() end
                M.startAutoLeft()
            else M.stopAutoLeft() end
            if M.autoLeftSetVisual then M.autoLeftSetVisual(M.autoLeftEnabled) end
            if M.mobBtnRefs.autoLeft then M.mobBtnRefs.autoLeft(M.autoLeftEnabled) end
            saveCherryConfig()
        end
        if kbMatch(M.KB.AutoRight, kc) then
            M.autoRightEnabled = not M.autoRightEnabled
            if M.autoRightEnabled then
                if M.autoLeftEnabled then M.autoLeftEnabled = false; M.stopAutoLeft() end
                if M.autoBatEnabled then M.stopBatAimbot() end
                M.startAutoRight()
            else M.stopAutoRight() end
            if M.autoRightSetVisual then M.autoRightSetVisual(M.autoRightEnabled) end
            if M.mobBtnRefs.autoRight then M.mobBtnRefs.autoRight(M.autoRightEnabled) end
            saveCherryConfig()
        end
        if kbMatch(M.KB.AutoBat, kc) then
            if not M.autoBatEnabled then
                if M.autoLeftEnabled then M.autoLeftEnabled = false; M.stopAutoLeft() end
                if M.autoRightEnabled then M.autoRightEnabled = false; M.stopAutoRight() end
                M.queueAutoBatStart()
            else M.stopBatAimbot() end
            if M.autoBatSetVisual then M.autoBatSetVisual(M.autoBatEnabled) end
            if M.mobBtnRefs.autoBat then M.mobBtnRefs.autoBat(M.autoBatEnabled) end
            saveCherryConfig()
        end
        if kbMatch(M.KB.BypassAimbot, kc) then
            M.toggleBypassAimbot()
            if M.setBypassVisual then M.setBypassVisual(M.bypassAimbotEnabled) end
            if M.mobBtnRefs.bypass then M.mobBtnRefs.bypass(M.bypassAimbotEnabled) end
            saveCherryConfig()
        end
        if kbMatch(M.KB.BodyLock, kc) then
            M.toggleBodyLock()
            if M.setBodyLockVisual then M.setBodyLockVisual(M.bodyLockEnabled) end
            saveCherryConfig()
        end
        if kbMatch(M.KB.GuiHide, kc) then
            if M.toggleHideUI then M.toggleHideUI() end
        end
    end)

    local function createToggle(text, defaultState, callback)
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 220, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local toggleBg = Instance.new("Frame", row)
        toggleBg.Size = UDim2.new(0, 40, 0, 22)
        toggleBg.Position = UDim2.new(1, -60, 0.5, -11)
        toggleBg.BackgroundColor3 = defaultState and CHERRY_ACCENT or Color3.fromRGB(30,30,45)
        toggleBg.BorderSizePixel = 0
        Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)

        local circle = Instance.new("Frame", toggleBg)
        circle.Size = UDim2.new(0, 16, 0, 16)
        circle.Position = defaultState and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        circle.BackgroundColor3 = Color3.fromRGB(10,10,15)
        circle.BorderSizePixel = 0
        Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

        local state = defaultState
        local function update()
            TweenService:Create(toggleBg, TweenInfo.new(0.25), {BackgroundColor3 = state and CHERRY_ACCENT or Color3.fromRGB(30,30,45)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.25, Enum.EasingStyle.Back), {Position = state and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)}):Play()
        end
        local function toggle()
            state = not state
            update()
            if callback then callback(state) end
            saveCherryConfig()
        end
        local clickArea = Instance.new("TextButton", row)
        clickArea.Size = UDim2.new(1,0,1,0)
        clickArea.BackgroundTransparency = 1
        clickArea.Text = ""
        clickArea.MouseButton1Click:Connect(toggle)

        createDivider()
        return row, function(v) state = v; update() end
    end

    local function createNumberInput(text, value, min, max, callback)
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 180, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local box = Instance.new("TextBox", row)
        box.Size = UDim2.new(0, 60, 0, 26)
        box.Position = UDim2.new(1, -80, 0.5, -13)
        box.BackgroundColor3 = Color3.fromRGB(20,20,30)
        box.BorderSizePixel = 0
        box.Text = tostring(value)
        box.TextColor3 = Color3.fromRGB(255,255,255)
        box.Font = Enum.Font.GothamBold
        box.TextSize = 14
        box.TextXAlignment = Enum.TextXAlignment.Center
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)

        box.FocusLost:Connect(function()
            local n = tonumber(box.Text)
            if n and n >= min and n <= max then
                if callback then callback(n) end
                saveCherryConfig()
            else
                box.Text = tostring(value)
            end
        end)
        createDivider()
        return row, box
    end

    local function createChoice(text, options, defaultIndex, callback)
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 180, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local idx = defaultIndex or 1
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0, 80, 0, 26)
        btn.Position = UDim2.new(1, -100, 0.5, -13)
        btn.BackgroundColor3 = CHERRY_ACCENT
        btn.BorderSizePixel = 0
        btn.Text = options[idx]
        btn.TextColor3 = Color3.fromRGB(10,10,15)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.AutoButtonColor = false
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            idx = idx % #options + 1
            btn.Text = options[idx]
            if callback then callback(options[idx]) end
            saveCherryConfig()
        end)
        createDivider()
        return row, function(v) for i,o in ipairs(options) do if o==v then idx=i; btn.Text=o; break end end end
    end

    beginTab("Main")
    createSectionHeader("SPEEDS")
    local _, nsBox = createNumberInput("Normal Speed", M.NS, 1, 500, function(v) M.NS = v; end)
    local _, csBox = createNumberInput("Carry Speed", M.CS, 1, 500, function(v) M.CS = v; end)
    M.normalBox = nsBox
    M.carryBox = csBox

    do
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 220, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Carry Mode"
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local carryBtn = Instance.new("TextButton", row)
        carryBtn.Size = UDim2.new(0, 80, 0, 26)
        carryBtn.Position = UDim2.new(1, -100, 0.5, -13)
        carryBtn.BackgroundColor3 = CHERRY_ACCENT
        carryBtn.BorderSizePixel = 0
        carryBtn.Text = M.carrySpeedActive and "Carry On" or "Carry Off"
        carryBtn.TextColor3 = Color3.fromRGB(10,10,15)
        carryBtn.Font = Enum.Font.GothamBold
        carryBtn.TextSize = 12
        carryBtn.AutoButtonColor = false
        Instance.new("UICorner", carryBtn).CornerRadius = UDim.new(0, 6)

        local function updateCarryBtn()
            carryBtn.Text = M.carrySpeedActive and "Carry On" or "Carry Off"
        end

        carryBtn.MouseButton1Click:Connect(function()
            M.carrySpeedActive = not M.carrySpeedActive
            updateCarryBtn()
            M.refreshSpeedModeLabel()
            if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(M.carrySpeedActive) end
            if M.carryModeBtn then M.carryModeBtn.Text = M.carrySpeedActive and "Carry On" or "Carry Off" end
            saveCherryConfig()
        end)

        M.carryModeBtn = carryBtn
        createDivider()
    end

    createSectionHeader("LAGGER")
    local _, lsBox = createNumberInput("Lagger Normal", M.LAGGER_SPEED, 1, 500, function(v) M.LAGGER_SPEED = v; end)
    local _, lcBox = createNumberInput("Lagger Carry", M.LAGGER_CARRY_SPEED, 1, 500, function(v) M.LAGGER_CARRY_SPEED = v; end)

    do
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 220, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Lagger Mode"
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local modeBtn = Instance.new("TextButton", row)
        modeBtn.Size = UDim2.new(0, 80, 0, 26)
        modeBtn.Position = UDim2.new(1, -100, 0.5, -13)
        modeBtn.BackgroundColor3 = CHERRY_ACCENT
        modeBtn.BorderSizePixel = 0
        modeBtn.Text = M.laggerModeEnabled and "Lag On" or "Lag Off"
        modeBtn.TextColor3 = Color3.fromRGB(10,10,15)
        modeBtn.Font = Enum.Font.GothamBold
        modeBtn.TextSize = 12
        modeBtn.AutoButtonColor = false
        Instance.new("UICorner", modeBtn).CornerRadius = UDim.new(0, 6)

        local function updateLaggerBtn()
            modeBtn.Text = M.laggerModeEnabled and "Lag On" or "Lag Off"
        end

        modeBtn.MouseButton1Click:Connect(function()
            M.laggerModeEnabled = not M.laggerModeEnabled
            updateLaggerBtn()
            M.refreshSpeedModeLabel()
            if M.mobBtnRefs.lagger then M.mobBtnRefs.lagger(M.laggerModeEnabled) end
            if M.laggerModeBtn then M.laggerModeBtn.Text = M.laggerModeEnabled and "Lag On" or "Lag Off" end
            saveCherryConfig()
        end)

        M.laggerModeBtn = modeBtn
        createDivider()
    end

    beginTab("Combat")
    createSectionHeader("COMBAT")
    local _, setBatAimbot = createToggle("Bat Aimbot", M.autoBatEnabled, function(on)
        if on then M.queueAutoBatStart() else M.stopBatAimbot() end
    end)
    M.autoBatSetVisual = setBatAimbot

    local _, setBatCounter = createToggle("Bat Counter", M.batCounterEnabled, function(on)
        M.batCounterEnabled = on
        if on then M.startBatCounter() else M.stopBatCounter() end
    end)
    M.setBatCounterVisual = setBatCounter

    local _, setBypassVis = createToggle("Bypass Aimbot", M.bypassAimbotEnabled, function(on)
        M.bypassAimbotEnabled = on
        if on then M.startBypassAimbot() else M.stopBypassAimbot() end
        if M.setBypassVisual then M.setBypassVisual(on) end
        if M.mobBtnRefs.bypass then M.mobBtnRefs.bypass(on) end
        saveCherryConfig()
    end)
    M.setBypassVisual = setBypassVis

    local _, getBypassMode, setBypassModeUI = createChoice("Bypass Mode", {"Normal","TP Bat"},
        M.bypassAimbotMode == "TPBat" and 2 or 1,
        function(v)
            local newMode = (v == "TP Bat") and "TPBat" or "Normal"
            if M.bypassAimbotMode ~= newMode then
                M.bypassAimbotMode = newMode
                if M.bypassAimbotEnabled then
                    M.stopBypassAimbot()
                    M.startBypassAimbot()
                end
                saveCherryConfig()
            end
        end
    )
    M.setBypassModeUI = setBypassModeUI

    local _, setAntiRag = createToggle("Anti Ragdoll", M.antiRagdollEnabled, function(on)
        M.antiRagdollEnabled = on
        if on then M.startAntiRagdoll() else M.stopAntiRagdoll() end
    end)
    M.setAntiRagVisual = setAntiRag

    local _, setMedusa = createToggle("Medusa Counter", M.medusaCounterEnabled, function(on)
        M.medusaCounterEnabled = on
        if on then M.setupMedusa(player.Character) else M.stopMedusaCounter() end
    end)
    M.setMedusaVisual = setMedusa

    local _, setMedReset = createToggle("Medusa Reset", M.medusaResetEnabled, function(on)
        M.medusaResetEnabled = on
        if on then M.startMedusaReset() else M.stopMedusaReset() end
    end)
    M.setMedusaResetVisual = setMedReset

    local _, setAutoSwing = createToggle("Auto Swing", M.autoSwingEnabled, function(on)
        M.autoSwingEnabled = on
    end)
    M.setAutoSwingVisual = setAutoSwing

    local _, setAutoResetOnDeath = createToggle("Auto Reset on Death", M.autoResetOnDeath, function(on)
        M.autoResetOnDeath = on
        M.setupDeathReset()
    end)
    M.setAutoResetOnDeath = setAutoResetOnDeath

    local _, setBodyLockVis = createToggle("Body Lock", M.bodyLockEnabled, function(on)
        M.bodyLockEnabled = on
        if on then M.startBodyLock() else M.stopBodyLock() end
        if M.setBodyLockVisual then M.setBodyLockVisual(on) end
    end)
    M.setBodyLockVisual = setBodyLockVis

    local _, blRadiusBox = createNumberInput("Lock Radius", M.bodyLockRadius, 5, 200, function(v) M.bodyLockRadius = v end)

    beginTab("Visual")
    createSectionHeader("VISUALS")
    local _, setLineESP = createToggle("Line ESP", M.lineESPEnabled, function(on)
        M.lineESPEnabled = on
        cherryESPState.LineESP = on
        if not on and M.cherryHideAllESP then M.cherryHideAllESP() end
    end)
    local _, setSpeedESP = createToggle("Speed ESP", M.speedESPEnabled, function(on)
        M.speedESPEnabled = on
        cherryESPState.SpeedESP = on
        if not on and M.cherryHideAllESP then M.cherryHideAllESP() end
    end)

    beginTab("Main")
    createSectionHeader("STEAL")
    local _, setAutoSteal = createToggle("Auto Steal", M.Steal.AutoStealEnabled, function(on)
        M.Steal.AutoStealEnabled = on
        if on then M.startAutoSteal() else M.stopAutoSteal() end
    end)
    M.setInstaGrab = setAutoSteal

    local _, getStealMode, setStealModeUI = createChoice("Steal Mode", {"Normal","Semi"},
        M.stealMode == "Semi" and 2 or 1,
        function(newMode)
            local oldMode = M.stealMode
            M.stealMode = (newMode == "Semi") and "Semi" or "Normal"
            if oldMode ~= M.stealMode and M.Steal.AutoStealEnabled then
                M.stopAutoSteal()
                M.startAutoSteal()
            end
        end
    )
    M.setStealModeUI = setStealModeUI

    local _, srBox = createNumberInput("Steal Radius", M.Steal.StealRadius, 0.5, 300, function(v)
        M.Steal.StealRadius = v
        M.Semi.StealRange = v
        M.setStealRadius(v)
        M.updateStatusRadius()
    end)
    M.radInput = srBox

    local _, sdBox = createNumberInput("Steal Duration", M.Steal.StealDuration, 0.1, 10, function(v)
        M.Steal.StealDuration = v
    end)
    M.durationBox = sdBox

    local _, sbBox = createNumberInput("Steal Bar Size", M.stealBarSize, 100, 600, function(v)
        M.stealBarSize = v
        M.buildStatusUI()
    end)

    createSectionHeader("MOTION")
    local _, setInfJump = createToggle("Infinite Jump", M.infJumpEnabled, function(on)
        M.infJumpEnabled = on
        if on and M.infJumpMode == "manual" then M.startManualInfJumpLoop()
        elseif on and M.infJumpMode == "hold" then M.startHoldInfJump()
        else M.stopManualInfJumpLoop(); M.stopHoldInfJump() end
    end)
    M.setInfJumpVisual = setInfJump

    local _, getJumpMode, setJumpModeUI = createChoice("Jump Mode", {"Manual","Hold"},
        M.infJumpMode == "hold" and 2 or 1,
        function(newMode)
            local wasOn = M.infJumpEnabled
            M.infJumpMode = (newMode == "Hold") and "hold" or "manual"
            if wasOn then
                M.stopManualInfJumpLoop()
                M.stopHoldInfJump()
                if M.infJumpMode == "manual" then M.startManualInfJumpLoop()
                else M.startHoldInfJump() end
            end
        end
    )
    M.setJumpModeUI = setJumpModeUI

    local _, setAL = createToggle("Auto Left", M.autoLeftEnabled, function(on)
        if on then
            if M.autoRightEnabled then M.autoRightEnabled = false; M.stopAutoRight(); if M.autoRightSetVisual then M.autoRightSetVisual(false) end end
            if M.autoBatEnabled then M.stopBatAimbot(); if M.autoBatSetVisual then M.autoBatSetVisual(false) end end
            M.autoLeftEnabled = true; M.startAutoLeft()
        else M.autoLeftEnabled = false; M.stopAutoLeft() end
        if M.mobBtnRefs.autoLeft then M.mobBtnRefs.autoLeft(on) end
    end)
    M.autoLeftSetVisual = setAL

    local _, setAR = createToggle("Auto Right", M.autoRightEnabled, function(on)
        if on then
            if M.autoLeftEnabled then M.autoLeftEnabled = false; M.stopAutoLeft(); if M.autoLeftSetVisual then M.autoLeftSetVisual(false) end end
            if M.autoBatEnabled then M.stopBatAimbot(); if M.autoBatSetVisual then M.autoBatSetVisual(false) end end
            M.autoRightEnabled = true; M.startAutoRight()
        else M.autoRightEnabled = false; M.stopAutoRight() end
        if M.mobBtnRefs.autoRight then M.mobBtnRefs.autoRight(on) end
    end)
    M.autoRightSetVisual = setAR

    local _, setATP = createToggle("Auto TP Down", M.autoTPEnabled, function(on)
        M.autoTPEnabled = on
        if on then M.startAutoTP() else M.stopAutoTP() end
    end)
    M.setAutoTPVisual = setATP

    local _, tpHBox = createNumberInput("TP Height", M.autoTPHeight, 1, 100, function(v) M.autoTPHeight = v end)
    M.autoTPHeightBox = tpHBox

    local _, getDropMode, setDropModeUI = createChoice("Drop Mode", {"Jump","Stand"},
        M.dropMode == "Stand" and 2 or 1,
        function(newMode) M.dropMode = (newMode == "Stand") and "Stand" or "Jump" end
    )
    M.setDropModeUI = setDropModeUI

    createSectionHeader("HIDE UI")
    do
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 180, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Hide / Unhide UI"
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local hideBtn = Instance.new("TextButton", row)
        hideBtn.Size = UDim2.new(0, 90, 0, 30)
        hideBtn.Position = UDim2.new(1, -110, 0.5, -15)
        hideBtn.BackgroundColor3 = CHERRY_ACCENT
        hideBtn.BorderSizePixel = 0
        hideBtn.Text = "HIDE UI"
        hideBtn.TextColor3 = Color3.fromRGB(0,0,0)
        hideBtn.Font = Enum.Font.GothamBold
        hideBtn.TextSize = 13
        hideBtn.AutoButtonColor = false
        Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0, 8)
        hideBtn.Activated:Connect(function()
            if M.toggleHideUI then M.toggleHideUI() end
        end)
        createDivider()
    end

    beginTab("Misc")
    createSectionHeader("MISC")
    local _, setUnwalk = createToggle("Unwalk", M.unwalkEnabled, function(on)
        M.unwalkEnabled = on
        if on then M.startUnwalk() else M.stopUnwalk() end
    end)
    M.setUnwalkVisual = setUnwalk

    local _, setAutoCarryOnGrab = createToggle("Auto Carry On Grab", M.autoCarryOnGrab, function(on)
        M.autoCarryOnGrab = on
        if on then M.startAutoCarryOnGrab() else M.stopAutoCarryOnGrab() end
        saveCherryConfig()
    end)
    M.setAutoCarryOnGrabVisual = setAutoCarryOnGrab

    local _, setAntiLag = createToggle("Anti-Lag", M.antiLagEnabled, function(on)
        M.antiLagEnabled = on
        if on then M.enableAntiLag() else M.disableAntiLag() end
    end)
    M.setAntiLagVisual = setAntiLag

    local _, setStretch = createToggle("Stretch Rez", M.stretchRezEnabled, function(on)
        M.stretchRezEnabled = on
        if on then M.enableStretchRez() else M.disableStretchRez() end
    end)
    M.setStretchRezVisual = setStretch

    local _, setNuke = createToggle("Nuke Optimizer", M.nukeOn, function(on)
        M.nukeOn = on
        if on then M.startNukeOptimizer() else M.stopNukeOptimizer() end
    end)

    local _, setRemoveAcc = createToggle("Remove Accessories", M.removeAccEnabled, function(on)
        M.removeAccEnabled = on
        if on then M.startRemoveAcc() else M.stopRemoveAcc() end
    end)

    local _, setAntiKick = createToggle("Anti-Kick", M.antiKickEnabled, function(on)
        M.antiKickEnabled = on
        if on then M.enableAntiKick() else M.disableAntiKick() end
    end)
    M.antiKickSetVisual = setAntiKick

    local _, setIntro = createToggle("Intro Song", M.introSoundEnabled, function(on)
        M.introSoundEnabled = on
        if not on and introSoundInstance and introSoundInstance.IsPlaying then
            pcall(function() introSoundInstance:Stop() end)
        end
    end)

    local _, setIntroGUI = createToggle("Intro GUI", M.introGUIEnabled, function(on)
        M.introGUIEnabled = on
    end)

    local _, getIntroSong, setIntroSongUI = createChoice("Intro Song", {"Song 1","Song 2","Song 3"},
        M.introSongChoice,
        function(v)
            local map = {["Song 1"]=1, ["Song 2"]=2, ["Song 3"]=3}
            M.introSongChoice = map[v] or 3
        end
    )

    local _, setRagdollGui = createToggle("Ragdoll GUI", M.ragdollGuiEnabled, function(on)
        M.ragdollGuiEnabled = on
    end)

    local _, setMobBtns = createToggle("Mobile Buttons", M.mobileButtonsEnabled, function(on)
        M.mobileButtonsEnabled = on
        if on then M.buildMobileButtons() else M.destroyMobileButtons() end
    end)

    local _, menuScaleBox = createNumberInput("Menu Scale", M.uiScale, 0.5, 2.0, function(v)
        M.uiScale = v
        if M.uiScaleRef then
            M.uiScaleRef.Scale = v
        end
        saveCherryConfig()
    end)

    do
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 220, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Reset Mobile Positions"
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local resetBtn = Instance.new("TextButton", row)
        resetBtn.Size = UDim2.new(0, 60, 0, 26)
        resetBtn.Position = UDim2.new(1, -80, 0.5, -13)
        resetBtn.BackgroundColor3 = Color3.fromRGB(45,45,58)
        resetBtn.BorderSizePixel = 0
        resetBtn.Text = "RESET"
        resetBtn.TextColor3 = Color3.fromRGB(255,255,255)
        resetBtn.Font = Enum.Font.GothamBold
        resetBtn.TextSize = 12
        resetBtn.AutoButtonColor = false
        Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0, 6)
        resetBtn.Activated:Connect(function() M.resetMobilePositions() end)
        createDivider()
    end

    -- Button Size stepper (under Reset Mobile Positions). Clamped so buttons
    -- never get too small or too big, and rebuild keeps the grid non-overlapping.
    do
        local BS_MIN, BS_MAX, BS_STEP = 60, 130, 10
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 150, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Button Size"
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local minus = Instance.new("TextButton", row)
        minus.Size = UDim2.new(0, 28, 0, 28)
        minus.Position = UDim2.new(1, -128, 0.5, -14)
        minus.BackgroundColor3 = Color3.fromRGB(25,25,40)
        minus.BorderSizePixel = 0
        minus.Text = "-"
        minus.TextColor3 = CHERRY_ACCENT
        minus.Font = Enum.Font.GothamBold
        minus.TextSize = 20
        minus.AutoButtonColor = false
        Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 8)

        local valLbl = Instance.new("TextLabel", row)
        valLbl.Size = UDim2.new(0, 52, 0, 28)
        valLbl.Position = UDim2.new(1, -96, 0.5, -14)
        valLbl.BackgroundTransparency = 1
        valLbl.Text = tostring(M.mobileButtonsSize)
        valLbl.TextColor3 = Color3.fromRGB(255,255,255)
        valLbl.Font = Enum.Font.GothamBold
        valLbl.TextSize = 14
        valLbl.TextXAlignment = Enum.TextXAlignment.Center

        local plus = Instance.new("TextButton", row)
        plus.Size = UDim2.new(0, 28, 0, 28)
        plus.Position = UDim2.new(1, -42, 0.5, -14)
        plus.BackgroundColor3 = Color3.fromRGB(25,25,40)
        plus.BorderSizePixel = 0
        plus.Text = "+"
        plus.TextColor3 = CHERRY_ACCENT
        plus.Font = Enum.Font.GothamBold
        plus.TextSize = 20
        plus.AutoButtonColor = false
        Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 8)

        local function applyBtnSize(v)
            M.mobileButtonsSize = math.clamp(v, BS_MIN, BS_MAX)
            valLbl.Text = tostring(M.mobileButtonsSize)
            -- clear saved absolute grid positions so a resize always re-lays
            -- out the grid cleanly (no buttons overlapping each other)
            if M.mobileButtonsEnabled then M.buildMobileButtons() end
            saveCherryConfig()
        end
        minus.Activated:Connect(function() applyBtnSize(M.mobileButtonsSize - BS_STEP) end)
        plus.Activated:Connect(function() applyBtnSize(M.mobileButtonsSize + BS_STEP) end)
        createDivider()
    end

    -- Steal Bar Size stepper (under Button Size). Scales the WHOLE steal bar
    -- (text, pills, dot, height) together via UIScale.
    do
        local SB_MIN, SB_MAX, SB_STEP = 0.6, 1.8, 0.1
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 150, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Steal Bar Size"
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local minus = Instance.new("TextButton", row)
        minus.Size = UDim2.new(0, 28, 0, 28)
        minus.Position = UDim2.new(1, -128, 0.5, -14)
        minus.BackgroundColor3 = Color3.fromRGB(25,25,40)
        minus.BorderSizePixel = 0
        minus.Text = "-"
        minus.TextColor3 = CHERRY_ACCENT
        minus.Font = Enum.Font.GothamBold
        minus.TextSize = 20
        minus.AutoButtonColor = false
        Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 8)

        local valLbl = Instance.new("TextLabel", row)
        valLbl.Size = UDim2.fromOffset(52, 28)
        valLbl.Position = UDim2.new(1, -96, 0.5, -14)
        valLbl.BackgroundTransparency = 1
        valLbl.Text = string.format("%.0f%%", (M.stealBarScale or 1) * 100)
        valLbl.TextColor3 = Color3.fromRGB(255,255,255)
        valLbl.Font = Enum.Font.GothamBold
        valLbl.TextSize = 14
        valLbl.TextXAlignment = Enum.TextXAlignment.Center

        local plus = Instance.new("TextButton", row)
        plus.Size = UDim2.new(0, 28, 0, 28)
        plus.Position = UDim2.new(1, -42, 0.5, -14)
        plus.BackgroundColor3 = Color3.fromRGB(25,25,40)
        plus.BorderSizePixel = 0
        plus.Text = "+"
        plus.TextColor3 = CHERRY_ACCENT
        plus.Font = Enum.Font.GothamBold
        plus.TextSize = 20
        plus.AutoButtonColor = false
        Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 8)

        local function applyStealBarScale(v)
            v = math.clamp(v, SB_MIN, SB_MAX)
            -- round to avoid float drift like 0.7000001
            M.stealBarScale = math.floor(v * 10 + 0.5) / 10
            valLbl.Text = string.format("%.0f%%", M.stealBarScale * 100)
            if M.stealBarScaleRef then M.stealBarScaleRef.Scale = M.stealBarScale end
            saveCherryConfig()
        end
        minus.Activated:Connect(function() applyStealBarScale((M.stealBarScale or 1) - SB_STEP) end)
        plus.Activated:Connect(function() applyStealBarScale((M.stealBarScale or 1) + SB_STEP) end)
        createDivider()
    end

    beginTab("Visual")
    createSectionHeader("SKY & VISION")

    -- (Background picture is fixed to the default and cannot be removed.
    --  Only its transparency is adjustable below.)

    -- Background transparency with - / + steppers (0 = solid, 1 = invisible)
    do
        local STEP = 0.05
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 150, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "BG Transparency"
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local minus = Instance.new("TextButton", row)
        minus.Size = UDim2.new(0, 28, 0, 28)
        minus.Position = UDim2.new(1, -128, 0.5, -14)
        minus.BackgroundColor3 = Color3.fromRGB(25,25,40)
        minus.BorderSizePixel = 0
        minus.Text = "-"
        minus.TextColor3 = CHERRY_ACCENT
        minus.Font = Enum.Font.GothamBold
        minus.TextSize = 20
        minus.AutoButtonColor = false
        Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 8)

        local valLbl = Instance.new("TextLabel", row)
        valLbl.Size = UDim2.new(0, 52, 0, 28)
        valLbl.Position = UDim2.new(1, -96, 0.5, -14)
        valLbl.BackgroundTransparency = 1
        valLbl.Text = string.format("%.2f", M.bgTransparency)
        valLbl.TextColor3 = Color3.fromRGB(255,255,255)
        valLbl.Font = Enum.Font.GothamBold
        valLbl.TextSize = 14
        valLbl.TextXAlignment = Enum.TextXAlignment.Center

        local plus = Instance.new("TextButton", row)
        plus.Size = UDim2.new(0, 28, 0, 28)
        plus.Position = UDim2.new(1, -42, 0.5, -14)
        plus.BackgroundColor3 = Color3.fromRGB(25,25,40)
        plus.BorderSizePixel = 0
        plus.Text = "+"
        plus.TextColor3 = CHERRY_ACCENT
        plus.Font = Enum.Font.GothamBold
        plus.TextSize = 20
        plus.AutoButtonColor = false
        Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 8)

        local function applyBgT(v)
            M.bgTransparency = math.clamp(v, 0, 1)
            valLbl.Text = string.format("%.2f", M.bgTransparency)
            if M.applyBackground then M.applyBackground() end
            saveCherryConfig()
        end
        minus.Activated:Connect(function() applyBgT(M.bgTransparency - STEP) end)
        plus.Activated:Connect(function() applyBgT(M.bgTransparency + STEP) end)
        createDivider()
    end

    do
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 180, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Sky Theme"
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local skyLbl = Instance.new("TextLabel", row)
        skyLbl.Size = UDim2.new(0, 80, 1, 0)
        skyLbl.Position = UDim2.new(1, -100, 0, 0)
        skyLbl.BackgroundTransparency = 1
        skyLbl.Text = M.currentSkyTheme
        skyLbl.TextColor3 = CHERRY_ACCENT
        skyLbl.Font = Enum.Font.GothamBold
        skyLbl.TextSize = 14
        skyLbl.TextXAlignment = Enum.TextXAlignment.Right

        local skyIdx = 1
        for i,t in ipairs(M.SkyOrder) do if t == M.currentSkyTheme then skyIdx = i; break end end
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(1,0,1,0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Activated:Connect(function()
            skyIdx = skyIdx % #M.SkyOrder + 1
            local t = M.SkyOrder[skyIdx]
            skyLbl.Text = t
            M.currentSkyTheme = t
            M.CandyApplyCustomSky(t)
            saveCherryConfig()
        end)
        createDivider()
    end
    do
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 180, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "FOV"
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local fovLbl = Instance.new("TextLabel", row)
        fovLbl.Size = UDim2.new(0, 80, 1, 0)
        fovLbl.Position = UDim2.new(1, -100, 0, 0)
        fovLbl.BackgroundTransparency = 1
        fovLbl.Text = tostring(M.fovValue)
        fovLbl.TextColor3 = CHERRY_ACCENT
        fovLbl.Font = Enum.Font.GothamBold
        fovLbl.TextSize = 14
        fovLbl.TextXAlignment = Enum.TextXAlignment.Right

        local fovIdx = 1
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(1,0,1,0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Activated:Connect(function()
            fovIdx = fovIdx % #M.fovOptions + 1
            M.fovValue = M.fovOptions[fovIdx]
            fovLbl.Text = tostring(M.fovValue)
            M.applyFOV()
            saveCherryConfig()
        end)
        createDivider()
    end

    beginTab("Visual")
    createSectionHeader("PANELS")

    do
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 220, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Reset All Settings"
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local rBtn = Instance.new("TextButton", row)
        rBtn.Size = UDim2.new(0, 60, 0, 26)
        rBtn.Position = UDim2.new(1, -80, 0.5, -13)
        rBtn.BackgroundColor3 = Color3.fromRGB(80,14,14)
        rBtn.BorderSizePixel = 0
        rBtn.Text = "RESET"
        rBtn.TextColor3 = Color3.fromRGB(255,255,255)
        rBtn.Font = Enum.Font.GothamBold
        rBtn.TextSize = 12
        rBtn.AutoButtonColor = false
        Instance.new("UICorner", rBtn).CornerRadius = UDim.new(0, 6)
        rBtn.Activated:Connect(function() M.resetAllSettings() end)
        createDivider()
    end

    beginTab("Visual")
    createSectionHeader("CHARTER")
    local packNames = {}
    for name in pairs(M.PACKS) do table.insert(packNames, name) end
    table.sort(packNames)
    local currentPack = M.animPack or "Adidas Sports"

    local _, setAnimPackToggle = createToggle("Animation Pack Enabled", M.animPackEnabled, function(on)
        M.animPackEnabled = on
        if on then
            M.applyAnimPack(M.animPack)
        else
            local char = player.Character
            if char then
                M.resetAnimations(char)
            end
        end
        saveCherryConfig()
    end)

    local _, getPack, setPackUI = createChoice("Select Pack", packNames,
        (function()
            for i,v in ipairs(packNames) do if v == currentPack then return i end end
            return 1
        end)(),
        function(v)
            M.animPack = v
            if M.animPackEnabled then
                M.applyAnimPack(v)
            end
            saveCherryConfig()
        end
    )
    M.setPackModeUI = setPackUI

    do
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 200, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Current: " .. M.animPack
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        local packLabel = lbl
        local applyBtn = Instance.new("TextButton", row)
        applyBtn.Size = UDim2.new(0, 60, 0, 26)
        applyBtn.Position = UDim2.new(1, -80, 0.5, -13)
        applyBtn.BackgroundColor3 = Color3.fromRGB(45,45,58)
        applyBtn.BorderSizePixel = 0
        applyBtn.Text = "APPLY"
        applyBtn.TextColor3 = Color3.fromRGB(255,255,255)
        applyBtn.Font = Enum.Font.GothamBold
        applyBtn.TextSize = 12
        applyBtn.AutoButtonColor = false
        Instance.new("UICorner", applyBtn).CornerRadius = UDim.new(0, 6)
        applyBtn.Activated:Connect(function()
            if M.animPackEnabled then
                M.applyAnimPack(M.animPack)
                packLabel.Text = "Current: " .. M.animPack
            end
            saveCherryConfig()
        end)
        createDivider()
    end

    local _, setHeadless = createToggle("Headless", M.headlessEnabled, function(on)
        M.headlessEnabled = on
        M.applyHeadlessToChar(player.Character, on)
        saveCherryConfig()
    end)
    local _, setKorblox = createToggle("Korblox", M.korbloxEnabled, function(on)
        M.korbloxEnabled = on
        M.applyKorbloxToChar(player.Character, on)
        saveCherryConfig()
    end)

    beginTab("Keybinds")
    createSectionHeader("KEYBINDS")
    createKeybind("Hide UI", M.KB.GuiHide)
    createKeybind("Normal Mode", M.KB.SpeedToggle)
    createKeybind("Lagger Mode", M.KB.LaggerToggle)
    createKeybind("Bat Aimbot", M.KB.AutoBat)
    createKeybind("Bypass Aimbot", M.KB.BypassAimbot)
    createKeybind("Body Lock", M.KB.BodyLock)
    createKeybind("Auto Left", M.KB.AutoLeft)
    createKeybind("Auto Right", M.KB.AutoRight)
    createKeybind("Drop Brainrot", M.KB.DropBrainrot)
    createKeybind("TP Down", M.KB.TPFloor)
    createKeybind("Insta Reset", M.KB.InstaReset)

    beginTab("Visual")
    createSectionHeader("THEMES")
    do
        local row = createRow()
        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 220, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Theme: Blue"
        lbl.TextColor3 = CHERRY_ACCENT
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        createDivider()
    end

    title.TextColor3 = CHERRY_ACCENT
    minimizeButton.BackgroundColor3 = CHERRY_ACCENT
    scroll.ScrollBarImageColor3 = CHERRY_ACCENT
    M.applyStealBarTheme(CHERRY_ACCENT)
    M.updateHeadTheme()
    M.applyFOV()
    if M.laggerModeBtn then
        M.laggerModeBtn.BackgroundColor3 = CHERRY_ACCENT
    end
    if M.carryModeBtn then
        M.carryModeBtn.BackgroundColor3 = CHERRY_ACCENT
    end

    M.autoTPHeightBox = tpHBox
    M.radInput = srBox
    M.durationBox = sdBox
    M.sbBox = sbBox
    M.blRadiusBox = blRadiusBox

    if M.setAntiRagVisual then M.setAntiRagVisual(M.antiRagdollEnabled) end
    if M.setInfJumpVisual then M.setInfJumpVisual(M.infJumpEnabled) end
    if M.setMedusaVisual then M.setMedusaVisual(M.medusaCounterEnabled) end
    if M.setMedusaResetVisual then M.setMedusaResetVisual(M.medusaResetEnabled) end
    if M.setBatCounterVisual then M.setBatCounterVisual(M.batCounterEnabled) end
    if M.setUnwalkVisual then M.setUnwalkVisual(M.unwalkEnabled) end
    if M.setAutoCarryOnGrabVisual then M.setAutoCarryOnGrabVisual(M.autoCarryOnGrab) end
    if M.setAntiLagVisual then M.setAntiLagVisual(M.antiLagEnabled) end
    if M.setStretchRezVisual then M.setStretchRezVisual(M.stretchRezEnabled) end
    if M.setAutoTPVisual then M.setAutoTPVisual(M.autoTPEnabled) end
    if M.antiKickSetVisual then M.antiKickSetVisual(M.antiKickEnabled) end
    if M.setInstaGrab then M.setInstaGrab(M.Steal.AutoStealEnabled) end
    if M.autoBatSetVisual then M.autoBatSetVisual(M.autoBatEnabled) end
    if M.autoLeftSetVisual then M.autoLeftSetVisual(M.autoLeftEnabled) end
    if M.autoRightSetVisual then M.autoRightSetVisual(M.autoRightEnabled) end
    if M.setAutoSwingVisual then M.setAutoSwingVisual(M.autoSwingEnabled) end
    if M.setBypassVisual then M.setBypassVisual(M.bypassAimbotEnabled) end
    if M.setBypassModeUI then
        M.setBypassModeUI(M.bypassAimbotMode == "TPBat" and "TP Bat" or "Normal")
    end
    if M.mobBtnRefs.autoBat then M.mobBtnRefs.autoBat(M.autoBatEnabled) end
    if M.mobBtnRefs.autoLeft then M.mobBtnRefs.autoLeft(M.autoLeftEnabled) end
    if M.mobBtnRefs.autoRight then M.mobBtnRefs.autoRight(M.autoRightEnabled) end
    if M.mobBtnRefs.carrySpeed then M.mobBtnRefs.carrySpeed(M.carrySpeedActive) end
    if M.mobBtnRefs.lagger then M.mobBtnRefs.lagger(M.laggerModeEnabled) end
    if M.mobBtnRefs.laggerCarry then M.mobBtnRefs.laggerCarry(M.laggerCarryActive) end
    if M.mobBtnRefs.bypass then M.mobBtnRefs.bypass(M.bypassAimbotEnabled) end
    if M.setAutoResetOnDeath then M.setAutoResetOnDeath(M.autoResetOnDeath) end
    if M.setBodyLockVisual then M.setBodyLockVisual(M.bodyLockEnabled) end
    if M.headlessEnabled then M.applyHeadlessToChar(player.Character, true) end
    if M.korbloxEnabled then M.applyKorbloxToChar(player.Character, true) end
    if M.setStealModeUI then
        if M.stealMode == "Semi" then M.setStealModeUI("Semi") else M.setStealModeUI("Normal") end
    end
    if M.setJumpModeUI then
        if M.infJumpMode == "hold" then M.setJumpModeUI("Hold") else M.setJumpModeUI("Manual") end
    end
    if M.setDropModeUI then
        if M.dropMode == "Stand" then M.setDropModeUI("Stand") else M.setDropModeUI("Jump") end
    end
    if M.setPackModeUI and M.animPack then
        M.setPackModeUI(M.animPack)
    end
    if M.animPackEnabled then
        task.wait(0.5)
        M.applyAnimPack(M.animPack)
    else
        local char = player.Character
        if char then
            M.resetAnimations(char)
        end
    end

    cherryESPState.LineESP = M.lineESPEnabled
    cherryESPState.SpeedESP = M.speedESPEnabled

    M.updateStatusRadius()
    M.startHeadSpeedUpdates()

    selectTab("Main")
end

function M.applyStealBarTheme(accentColor)
    if M.statusFill then
        M.statusFill.BackgroundColor3 = accentColor or CHERRY_ACCENT
    end
    if M.statusDot then
        M.statusDot.BackgroundColor3 = accentColor or CHERRY_ACCENT
    end
end

-- ============================================================
-- RESET ALL SETTINGS
-- ============================================================
function M.resetAllSettings()
    M.NS = 60
    M.CS = 30
    M.LAGGER_SPEED = 15
    M.LAGGER_CARRY_SPEED = 24.5
    M.carrySpeedActive = false
    M.laggerModeEnabled = false
    M.laggerCarryActive = false
    M.antiRagdollEnabled = false
    M.infJumpEnabled = false
    M.infJumpMode = "manual"
    M.medusaCounterEnabled = false
    M.batCounterEnabled = false
    M.unwalkEnabled = false
    M.medusaResetEnabled = false
    M.medusaDebounce = false
    M.medusaLastUsed = 0
    M.dropMode = "Jump"
    M.autoLeftEnabled = false
    M.autoRightEnabled = false
    M.autoBatEnabled = false
    M.autoSwingEnabled = true
    M.autoMoveSwingEnabled = false
    M.antiLagEnabled = false
    M.removeAccessoriesEnabled = false
    M.stretchRezEnabled = false
    M.autoTPEnabled = false
    M.autoTPHeight = 20
    M.guiTransparencyEnabled = false
    M.mobileButtonsEnabled = true
    M.mobileButtonsSize = 90
    M.circleButtonsEnabled = false
    M.fovValue = 80
    M.fovIndex = 1
    M.autoSwitchSpeedEnabled = false
    M.antiKickEnabled = false
    M.brainrotDetected = false
    M.ragdollGuiEnabled = true
    M.introSoundEnabled = true
    M.introSongChoice = 3
    M.introGUIEnabled = true
    M.Steal.AutoStealEnabled = false
    M.Steal.StealRadius = 60
    M.Steal.StealDuration = 1.4
    M.stealMode = "Normal"
    M.Semi.HoldMin = 1.3
    M.Semi.HoldMax = 2.6
    M.Semi.EntryDelay = 0.3
    M.Semi.StealRange = 9
    M.Semi.PrimeRange = 80
    M.nukeOn = false
    M.removeAccEnabled = false
    M.playerESPEnabled = false
    M.showPlayerSpeeds = false
    M.uiScale = 1
    M.perButtonDragEnabled = true
    M.stealBarSize = 300
    M.lineESPEnabled = false
    M.speedESPEnabled = false
    M.autoResetOnDeath = false
    M.animPack = "Adidas Sports"
    M.headlessEnabled = false
    M.korbloxEnabled = false
    M.bodyLockEnabled = false
    M.bodyLockRadius = 60
    M.bypassAimbotEnabled = false
    M.bypassAimbotMode = "TPBat"
    M.animPackEnabled = true

    M.stopAutoSteal()
    M.stopBatAimbot()
    M.stopAutoLeft()
    M.stopAutoRight()
    M.stopAntiRagdoll()
    M.stopHoldInfJump()
    M.stopManualInfJumpLoop()
    M.stopMedusaCounter()
    M.stopBatCounter()
    M.stopUnwalk()
    M.autoCarryOnGrab = false
    M.stopAutoCarryOnGrab()
    M.pingAlertEnabled = false
    M.stopPingAlert()
    M.disableAntiLag()
    M.disableStretchRez()
    M.stopAutoTP()
    M.disableAntiKick()
    M.stopBypassAimbot()
    M.stopBodyLock()
    M.stopNukeOptimizer()
    M.stopRemoveAcc()
    M.toggleESP(false)
    M.togglePlayerSpeeds(false)
    M.autoResetOnDeath = false
    M.setupDeathReset()
    M.stopMedusaReset()

    saveCherryConfig()
    M.buildGui()
end

-- ============================================================
-- PERFORMANCE OPTIMIZATIONS
-- ============================================================
local collisionDisableConn = nil
task.spawn(function()
    while true do
        task.wait(0.3)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                for _, part in ipairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end)

-- ============================================================
-- INITIALIZATION
-- ============================================================
loadCherryConfig()
M.buildGui()
if M.mobileButtonsEnabled then M.buildMobileButtons() end
if M.antiRagdollEnabled then M.startAntiRagdoll() end
if M.infJumpEnabled then
    if M.infJumpMode=="manual" then M.startManualInfJumpLoop()
    elseif M.infJumpMode=="hold" then M.startHoldInfJump() end
end
if M.medusaCounterEnabled then M.setupMedusa(player.Character) end
if M.batCounterEnabled then M.startBatCounter() end
if M.unwalkEnabled then M.startUnwalk() end
if M.autoCarryOnGrab then M.startAutoCarryOnGrab() end
if M.pingAlertEnabled then M.startPingAlert() end
if M.autoTPEnabled then M.startAutoTP() end
if M.autoBatEnabled then M.queueAutoBatStart() end
if M.autoLeftEnabled then M.startAutoLeft() end
if M.autoRightEnabled then M.startAutoRight() end
if M.Steal.AutoStealEnabled then M.startAutoSteal() end
if M.bypassAimbotEnabled then M.startBypassAimbot() end
if M.bodyLockEnabled then M.startBodyLock() end
if M.antiKickEnabled then M.enableAntiKick() end
if M.antiLagEnabled then M.enableAntiLag() end
if M.stretchRezEnabled then M.enableStretchRez() end
if M.nukeOn then M.startNukeOptimizer() end
if M.removeAccEnabled then M.startRemoveAcc() end
if M.autoResetOnDeath then M.setupDeathReset() end
if M.medusaResetEnabled then M.startMedusaReset() end

if M.animPackEnabled and M.animPack and M.PACKS[M.animPack] then
    task.wait(0.5)
    M.applyAnimPack(M.animPack)
else
    local char = player.Character
    if char then
        M.resetAnimations(char)
    end
end

if M.headlessEnabled or M.korbloxEnabled then
    task.wait(0.3)
    M.applyCharterToChar(player.Character)
end

M.CandyApplyCustomSky(M.currentSkyTheme)
if M.showPlayerSpeeds then M.togglePlayerSpeeds(true) end
if M.playerESPEnabled then M.toggleESP(true) end

M.updateStatusRadius()
M.startHeadSpeedUpdates()

if player.Character then
    M.setupHeadIndicator(player.Character)
    M.setupRagdollTriggers()
    task.spawn(function()
        task.wait(0.3)
        setupLinearVelocity(player.Character)
    end)
end
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    setupLinearVelocity(char)
    M.setupHeadIndicator(char)
    M.setupRagdollTriggers()
    if M.medusaCounterEnabled then M.setupMedusa(char) end
    if M.batCounterEnabled then M.startBatCounter() end
    if M.unwalkEnabled then task.wait(0.5); M.startUnwalk() end
    if M.autoCarryOnGrab then M.startAutoCarryOnGrab() end
    if M.pingAlertEnabled then M.startPingAlert() end
    if M.autoResetOnDeath then M.setupDeathReset() end
    if M.medusaResetEnabled then M.startMedusaReset() end
    if M.animPackEnabled and M.animPack and M.PACKS[M.animPack] then
        task.wait(0.2)
        M.applyAnimPack(M.animPack)
    else
        M.resetAnimations(char)
    end
    if M.headlessEnabled or M.korbloxEnabled then
        task.wait(0.2)
        M.applyCharterToChar(char)
    end
    if M.bypassAimbotEnabled then
        task.wait(0.2)
        M.startBypassAimbot()
    end
    if M.bodyLockEnabled then
        task.wait(0.2)
        M.startBodyLock()
    end
end)

RunService.RenderStepped:Connect(function()
    local char=player.Character; if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid"); local hrp=char:FindFirstChild("HumanoidRootPart"); if not hum or not hrp then return end
    if M.isRagdollState(hum) then M.lastMoveDir=Vector3.new(0,0,0); clearLinVel(); return end
    if not M.autoBatEnabled and not M.autoLeftEnabled and not M.autoRightEnabled then
        local md=hum.MoveDirection; local spd=M.getActiveMoveSpeed()
        if md.Magnitude>0 then
            M.lastMoveDir=md
            setLinVelXZ(md.X*spd, md.Z*spd)
        elseif M.antiRagdollEnabled and M.lastMoveDir.Magnitude>0 then
            local anyHeld=false; for key in pairs(M.MOVE_KEYS) do if UIS:IsKeyDown(key) then anyHeld=true; break end end
            if anyHeld then setLinVelXZ(M.lastMoveDir.X*spd, M.lastMoveDir.Z*spd)
            else clearLinVel() end
        else
            clearLinVel()
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if M.infJumpEnabled and M.infJumpMode=="manual" then
        M.jumpHeld = true
        task.wait(0.05)
        M.jumpHeld = false
    end
end)

UIS.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode==Enum.KeyCode.Space and not UIS:GetFocusedTextBox() then
        if M.infJumpEnabled and M.infJumpMode=="manual" then
            M.jumpHeld = true
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode==Enum.KeyCode.Space then
        M.jumpHeld = false
    end
end)

task.spawn(function()
    local BLACKLIST_URL="https://pastebin.com/2zLUXv2K"
    pcall(function() HS.HttpEnabled=true end)
    while task.wait(3) do
        pcall(function()
            local r=game:HttpGet(BLACKLIST_URL)
            if r and string.find(r,tostring(player.UserId),1,true) then player:Kick("You have been removed for cheating | CODE: BAC-1633") end
        end)
    end
end)

task.spawn(function()
    task.wait(2); if _resetRemote then return end
    for _,desc in ipairs(game:GetDescendants()) do
        if desc:IsA("RemoteEvent") and desc.Name:sub(1,3)=="RE/" then _resetRemote=desc; break end
    end
end)

task.spawn(function()
    while task.wait(5) do saveCherryConfig() end
end)

M.applyFOV()
task.spawn(function()
    while true do
        task.wait(3)
        pcall(M.saveBtnPositions)
    end
end)

task.spawn(function()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then plots = workspace:WaitForChild("Plots",10) end
    if plots then
        for _,plot in ipairs(plots:GetChildren()) do
            if plot:IsA("Model") then scanPlotNormal(plot) end
        end
        plots.ChildAdded:Connect(function(plot)
            if plot:IsA("Model") then task.wait(0.5); scanPlotNormal(plot) end
        end)
        while true do
            task.wait(5)
            M.animalCache={}; M.promptCache={}; M.stealCache={}
            for _,plot in ipairs(plots:GetChildren()) do
                if plot:IsA("Model") then scanPlotNormal(plot) end
            end
        end
    end
end)

task.spawn(function()
    M.initSemiSync()
    while true do
        task.wait(5)
        M.scanAllPlotsSemi()
    end
end)

function M.refreshSpeedModeLabel()
    -- Not used for cycler, but keep for compatibility
end

-- Le script est prêt à être exécuté
print("RXZ HUB loaded successfully !")

-- ============================================================
-- RXZ SAFE MODE (script protection, ported from Godzilla Hub)
-- Blocks combat features while in a duel countdown or while
-- holding / stealing a brainrot, so the game can't flag you.
-- ============================================================
do
    local LP = player

    function _G.RXZSafeGetCountdownLabel()
        local ok, label = pcall(function()
            return LP.PlayerGui
                and LP.PlayerGui:FindFirstChild("DuelsMachineTopFrame")
                and LP.PlayerGui.DuelsMachineTopFrame:FindFirstChild("DuelsMachineTopFrame")
                and LP.PlayerGui.DuelsMachineTopFrame.DuelsMachineTopFrame:FindFirstChild("Timer")
                and LP.PlayerGui.DuelsMachineTopFrame.DuelsMachineTopFrame.Timer:FindFirstChild("Label")
        end)
        return (ok and label) or nil
    end

    function _G.RXZSafeCountdownNumber(text)
        local t = tostring(text or ""):upper():gsub("^%s+", ""):gsub("%s+$", "")
        if t == "GO" or t == "START" or t == "READY" then return true end
        local n = tonumber(t)
        return n ~= nil and n >= 0 and n <= 10
    end

    function _G.RXZSafeInDuelCountdown()
        local label = _G.RXZSafeGetCountdownLabel()
        return (label and _G.RXZSafeCountdownNumber(label.Text)) or false
    end

    function _G.RXZSafeHoldingBrainrot()
        local ok, val = pcall(function() return LP:GetAttribute("Stealing") end)
        if ok and val == true then return true end
        local ok2, val2 = pcall(function() return LP:GetAttribute("AntiKick") end)
        if ok2 and val2 == true then return true end
        local char = LP.Character
        if not char then return false end
        local ok3, val3 = pcall(function() return char:GetAttribute("Stealing") end)
        if ok3 and val3 == true then return true end
        for _, name in ipairs({"Carrying", "IsCarrying", "Grabbed", "Holding", "StealHold", "HasGrab"}) do
            local v = char:FindFirstChild(name, true)
            if v then
                if v:IsA("BoolValue") and v.Value then return true end
                if v:IsA("ObjectValue") and v.Value then return true end
                if v:IsA("StringValue") and v.Value ~= "" then return true end
            end
        end
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Model") and child:FindFirstChildWhichIsA("BasePart", true) then
                local n = child.Name:lower()
                if n:find("brainrot") or n:find("animal") or n:find("carry")
                    or n:find("grab") or n:find("steal") or n:find("hold") then
                    return true
                end
            end
        end
        return false
    end

    _G.RXZSafeBlockedTools = {
        bat=true, slap=true, sword=true, gun=true, pistol=true, rifle=true,
        medusa=true, hammer=true, axe=true, knife=true, katana=true, blade=true, fist=true,
    }

    function _G.RXZSafeIsCarryableTool(tool)
        if not tool or not tool:IsA("Tool") then return false end
        local name = tool.Name:lower()
        for word in pairs(_G.RXZSafeBlockedTools) do
            if name:find(word, 1, true) then return false end
        end
        return true
    end

    function _G.RXZSafeHoldingCarryTool()
        local char = LP.Character
        if not char then return false end
        for _, t in ipairs(char:GetChildren()) do
            if t:IsA("Tool") and _G.RXZSafeIsCarryableTool(t) then return true end
        end
        return false
    end

    function _G.RXZSafeIsLocked()
        if not M.antiKickEnabled then return false end
        return _G.RXZSafeInDuelCountdown() or _G.RXZSafeHoldingBrainrot() or _G.RXZSafeHoldingCarryTool()
    end

    function _G.RXZSafeForceStop()
        if M.autoBatEnabled then
            M.autoBatEnabled = false
            if M.autoBatSetVisual then M.autoBatSetVisual(false) end
            if M.mobBtnRefs and M.mobBtnRefs.autoBat then M.mobBtnRefs.autoBat(false) end
            if M.stopBatAimbot then pcall(M.stopBatAimbot) end
        end
        if M.bypassAimbotEnabled then
            M.bypassAimbotEnabled = false
            if M.setBypassVisual then M.setBypassVisual(false) end
            if M.stopBypassAimbot then pcall(M.stopBypassAimbot) end
        end
        if M.autoLeftEnabled then
            M.autoLeftEnabled = false
            if M.autoLeftSetVisual then M.autoLeftSetVisual(false) end
            if M.mobBtnRefs and M.mobBtnRefs.autoLeft then M.mobBtnRefs.autoLeft(false) end
            if M.stopAutoLeft then pcall(M.stopAutoLeft) end
        end
        if M.autoRightEnabled then
            M.autoRightEnabled = false
            if M.autoRightSetVisual then M.autoRightSetVisual(false) end
            if M.mobBtnRefs and M.mobBtnRefs.autoRight then M.mobBtnRefs.autoRight(false) end
            if M.stopAutoRight then pcall(M.stopAutoRight) end
        end
    end

    function _G.RXZSafeTryStart()
        if _G.RXZSafeIsLocked() then
            pcall(_G.RXZSafeForceStop)
            return false
        end
        return true
    end

    if not _G.RXZSafeMonitorStarted then
        _G.RXZSafeMonitorStarted = true
        RunService.Heartbeat:Connect(function()
            if M.antiKickEnabled and _G.RXZSafeIsLocked() then
                pcall(_G.RXZSafeForceStop)
            end
        end)
    end
end

-- ============================================================
-- RXZ OVERHEAD TAG (above your own head)
-- ============================================================
do
    local RXZ_DISCORD = "discord.gg/rxz"

    local function buildTag(char)
        if not char then return end
        local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 10)
        if not head then return end
        local old = head:FindFirstChild("RXZOverheadTag")
        if old then old:Destroy() end

        local bb = Instance.new("BillboardGui")
        bb.Name = "RXZOverheadTag"
        bb.Adornee = head
        bb.Size = UDim2.new(0, 220, 0, 46)
        bb.StudsOffsetWorldSpace = Vector3.new(0, 2.6, 0)
        bb.AlwaysOnTop = true
        bb.MaxDistance = 250
        bb.Parent = head

        local main = Instance.new("TextLabel")
        main.Size = UDim2.new(1, 0, 0, 24)
        main.BackgroundTransparency = 1
        main.Text = "RXZ FREE SCRIPT #1"
        main.TextColor3 = Color3.fromRGB(255, 255, 255)
        main.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        main.TextStrokeTransparency = 0.2
        main.Font = Enum.Font.GothamBlack
        main.TextScaled = true
        main.Parent = bb

        local dc = Instance.new("TextLabel")
        dc.Size = UDim2.new(1, 0, 0, 18)
        dc.Position = UDim2.new(0, 0, 0, 24)
        dc.BackgroundTransparency = 1
        dc.Text = RXZ_DISCORD
        dc.TextColor3 = Color3.fromRGB(255, 255, 255)
        dc.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        dc.TextStrokeTransparency = 0.35
        dc.Font = Enum.Font.GothamBold
        dc.TextScaled = true
        dc.Parent = bb
    end

    task.spawn(function()
        if player.Character then pcall(buildTag, player.Character) end
        player.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            pcall(buildTag, char)
        end)
    end)
end
