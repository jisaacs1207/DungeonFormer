DungeonFormer = LibStub("AceAddon-3.0"):NewAddon("DungeonFormer", "AceConsole-3.0", "AceEvent-3.0")
timer = 0
lowest = 1
highest = 60
list = {}
currentTab = 1
-- Variables to keep tab variables static rather than to redefine them every time the tab changes
DungeonDropdown = "Choose A Dungeon"
ZoneDropdown = "All Zones"
LowLevel = 1
HighLevel = 10
InAreaCheck = false
DruidCheck = false
HunterCheck = false
MageCheck = false
PaladinCheck = false
PriestCheck = false
RogueCheck = false
ShamanCheck = false
WarlockCheck = false
WarriorCheck = false
MessageBox = "Hey, wanna watch Zool Babies with me?"
ReplyText = "Group's filled, sorry!"
ReplyingButton = "Off"

DungeonFormer:RegisterChatCommand("df", "ToggleShowPlugin")

ClassColors = {
    CustomColor = { r = 0.77, g = 0.12, b = 0.23, a = 1 },
    DeathKnight = { r = 0.77, g = 0.12, b = 0.23 },
    Druid = { r = 1.00, g = 0.49, b = 0.04 },
    Hunter = { r = 0.67, g = 0.83, b = 0.45 },
    Mage = { r = 0.41, g = 0.80, b = 0.94 },
    Monk = { r = 0, g = 1, b = 0.59 },
    Paladin = { r = 0.96, g = 0.55, b = 0.73 },
    Priest = { r = 1.00, g = 1.00, b = 1.00 },
    Rogue = { r = 1.00, g = 0.96, b = 0.41 },
    Shaman = { r = 0.0, g = 0.44, b = 0.87 },
    Warlock = { r = 0.58, g = 0.51, b = 0.79 },
    Warrior = { r = 0.78, g = 0.61, b = 0.43 },
}

Dungeons = {
    { name = "Choose A Dungeon", low = 1, high = 10, sname = "a dungeon" },
    { name = "[13-18] Ragefire Chasm - Orgrimar", low = 13, high = 18, sname = "Ragefire Chasm" },
    { name = "[17-24] Wailing Caverns - The Barrens", low = 17, high = 24, sname = "Wailing Caverns" },
    { name = "[17-26] The Deadmines - Westfall", low = 17, high = 26, sname = "The Deadmines" },
    { name = "[22-30] Shadowfang Keep - Silverpine Forest", low = 22, high = 30, sname = "Shadowfang Keep" },
    { name = "[24-32] Blackfathom Deeps - Ashenvale", low = 24, high = 32, sname = "Blackfathom Deeps" },
    { name = "[24-32] The Stockade - Stormwind", low = 24, high = 32, sname = "The Stockade" },
    { name = "[29-38] Gnomeregan - Dun Morogh", low = 29, high = 38, sname = "Gnomeregan" },
    { name = "[29-38] Razorfen Kraul - The Barrens", low = 29, high = 38, sname = "Razorfen Kraul" },
    { name = "[26-36] SM Graveyard - Tirisfal Glades", low = 26, high = 36, sname = "SM Graveyard" },
    { name = "[29-39] SM Library - Tirisfal Glades", low = 29, high = 39, sname = "SM Library" },
    { name = "[32-42] SM Armory - Tirisfal Glades", low = 32, high = 42, sname = "SM Armory" },
    { name = "[35-45] SM Cathedral - Tirisfal Glades", low = 35, high = 45, sname = "SM Cathedral" },
    { name = "[37-46] Razorfen Downs - Thousand Needles", low = 37, high = 46, sname = "Razorfen Downs" },
    { name = "[41-51] Uldaman - Badlands", low = 41, high = 51, sname = "Uldaman" },
    { name = "[42-46] Zul'Farrak - Tanaris", low = 42, high = 56, sname = "Zul'Farrak" },
    { name = "[46-55] Maraudon - Desolace", low = 46, high = 55, sname = "Maraudon" },
    { name = "[50-56] Sunken Temple - Swamp of Sorrows", low = 50, high = 56, sname = "Sunken Temple" },
    { name = "[52-60] Blackrock Depths - Burning Steppes", low = 52, high = 60, sname = "Blackrock Depths" },
    { name = "[55-60] L Blackrock Spire - Burning Steppes", low = 55, high = 60, sname = "L Blackrock Spire" },
    { name = "[55-60] U Blackrock Spire - Burning Steppes", low = 55, high = 60, sname = "U Blackrock Spire" },
    { name = "[55-60] Dire Maul East - Feralas", low = 55, high = 60, sname = "Dire Maul East" },
    { name = "[55-60] Dire Maul West - Feralas", low = 55, high = 60, sname = "Dire Maul West" },
    { name = "[55-60] Dire Maul North - Feralas", low = 55, high = 60, sname = "Dire Maul North" },
    { name = "[58-60] Scholomance - Western Plaguelands", low = 58, high = 60, sname = "Scholomance" },
    { name = "[58-60] Stratholme - Eastern Plaguelands", low = 58, high = 60, sname = "Stratholme" },
}

Zones = {
    "All Zones",
    "Alterac Mountains",
    "Arathi Highlands",
    "Ashenvale",
    "Azshara",
    "Badlands",
    "Blackrock Mountain",
    "Blackrock Spire",
    "Blasted Lands",
    "Burning Steppes",
    "Caverns of Time",
    "Darkshore",
    "Darnassus",
    "Deadwind Pass",
    "Deeprun Tram",
    "Desolace",
    "Dun Morogh",
    "Durotar",
    "Duskwood",
    "Dustwallow Marsh",
    "Eastern Plaguelands",
    "Elwynn Forest",
    "Felwood",
    "Feralas",
    "Hillsbrad Foothills",
    "Ironforge",
    "Loch Modan",
    "Moonglade",
    "Mulgore",
    "Onyxia's Lair",
    "Orgrimmar",
    "Redridge Mountains",
    "Searing Gorge",
    "Silithus",
    "Silverpine Forest",
    "Stonetalon Mountains",
    "Stormwind City",
    "Stranglethorn Vale",
    "Swamp of Sorrows",
    "Tanaris",
    "Teldrassil",
    "The Barrens",
    "The Hinterlands",
    "Thousand Needles",
    "Thunder Bluff",
    "Tirisfal Glades",
    "Un'Goro Crater",
    "Undercity",
    "Western Plaguelands",
    "Westfall",
    "Wetlands",
    "Winterspring"
}

local options = {
    name = "DungeonFormer",
    handler = DungeonFormer,
    type = 'group',
    args = {

    },
}

function DungeonFormer:ToggleShowPlugin()
    -- Assuming "MyOptions" is the appName of a valid options table
    if frame:IsShown() then
        frame:Hide();
    else
        frame:Show();
    end
end


function DungeonFormer:AddToScroll(playerTable)
    local name = playerTable.fullName;
    local level = playerTable.level
    local class = playerTable.classStr
    local area = playerTable.area
    local playerString = name .. " " .. level .. " " .. class .. " " .. area
    local theLabel = AceGUI:Create("Label")
    theLabel:SetText(playerString)
    theLabel:SetFullWidth(true)
    return theLabel
end

function DungeonFormer:PullWho()
    if(carelessWhispered == nil) then
        carelessWhispered = {}
    end
    resultNumber = C_FriendList.GetNumWhoResults();
    for i = 1, resultNumber do
        local addToTable = true
        local newTableEntry =  C_FriendList.GetWhoInfo(i)
        for j = 1, table.getn(carelessWhispered) do
            if (carelessWhispered[j].fullName == newTableEntry.fullName) then
                addToTable = false
                break
            end
        end
        if(addToTable) then
            table.insert(list, newTableEntry)
        end
    end
    --local player = list[1]
    --print(player.fullName)
    ToggleFriendsFrame(2)
    tab:SelectTab("tab2")
end

function DungeonFormer:SearchPlayers()
    -- clear the list table
    list = {}

    -- Class Variable Checks
    local classChecked = false;
    local druid = druidCheck:GetValue();
    local hunter = hunterCheck:GetValue();
    local mage = mageCheck:GetValue();
    local paladin = paladinCheck:GetValue();
    local priest = priestCheck:GetValue();
    local rogue = rogueCheck:GetValue();
    local shaman = shamanCheck:GetValue();
    local warlock = warlockCheck:GetValue();
    local warrior = warriorCheck:GetValue();

    if (druid or hunter or mage or paladin or priest or rogue or shaman or warlock or warrior) then
        classChecked = true;
    end

    -- msg
    msg = "/who "

    -- level shit
    local low = lowLvl:GetText();
    local high = highLvl:GetText();

    -- attach zone to msg
    if (ZoneDropdown ~= "All Zones") then
        msg = msg .. "z-\"" .. ZoneDropdown .. "\" "
    end

    -- append class text to msg

    if (classChecked) then
        if (druid) then
            msg = msg .. "c-druid "
        end
        if (hunter) then
            msg = msg .. "c-hunter "
        end
        if (mage) then
            msg = msg .. "c-mage "
        end
        if (paladin) then
            msg = msg .. "c-paladin "
        end
        if (priest) then
            msg = msg .. "c-priest "
        end
        if (rogue) then
            msg = msg .. "c-rogue "
        end
        if (shaman) then
            msg = msg .. "c-shaman "
        end
        if (warlock) then
            msg = msg .. "c-warlock "
        end
        if (warrior) then
            msg = msg .. "c-warrior "
        end
    end

    -- append numbers to msg
    msg = msg .. low .. "-" .. high

    DEFAULT_CHAT_FRAME.editBox:SetText(msg)
    ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
    C_Timer.After(1, function()
        DungeonFormer:PullWho()
    end)
end

function DungeonFormer:OnInitialize()
    -- Called when the addon is loaded
    AceGUI = LibStub("AceGUI-3.0")

    -- function that draws the widgets for the first tab
    local function DrawGroup1(container)

        local desc = AceGUI:Create("Label")
        desc:SetText("Limit your search. The result max is 50.")
        desc:SetFullWidth(true)
        container:AddChild(desc)

        dungeonDropdown = AceGUI:Create("Dropdown")
        local dNames = {}
        for i = 1, #Dungeons do
            table.insert(dNames, Dungeons[i]['name'])
        end
        dungeonDropdown:SetList(dNames)
        dungeonDropdown:SetText(DungeonDropdown)
        dungeonDropdown:SetWidth(250)
        dungeonDropdown:SetCallback("OnValueChanged", function(this, event, key)
            local low = Dungeons[key]['low']
            local high = Dungeons[key]['high']
            local dungeonname1 = Dungeons[key]['name']
            local dungeonname1s = Dungeons[key]['sname']
            DungeonDropdown = dungeonname1
            for i = 1, #Dungeons do
                local dungeonname2s = Dungeons[i]['name']
                if string.find(dungeonname2s, dungeonname1s) then
                    LowLevel = low
                    HighLevel = high
                    MessageBox = "Hey, want to run " .. dungeonname1s .. "?"
                    tab:SelectTab("tab3") -- so lazy... just refreshing the tab by switching it.
                    tab:SelectTab("tab1")
                end
            end
        end)
        container:AddChild(dungeonDropdown)

        lowLvl = AceGUI:Create("EditBox")
        lowLvl:SetText(LowLevel)
        lowLvl:SetLabel("High Level")
        lowLvl:SetWidth(60)
        lowLvl:DisableButton(true)
        lowLvl:SetCallback("OnTextChanged", function()
            LowLevel = lowLvl:GetText()
        end)
        container:AddChild(lowLvl)

        highLvl = AceGUI:Create("EditBox")
        highLvl:SetText(HighLevel)
        highLvl:SetLabel("High Level")
        highLvl:SetWidth(60)
        highLvl:DisableButton(true)
        highLvl:SetCallback("OnTextChanged", function()
            HighLevel = highLvl:GetText()
        end)
        container:AddChild(highLvl)

        local searchButton = AceGUI:Create("Button")
        searchButton:SetText("Search")
        searchButton:SetWidth(100)
        searchButton:SetCallback("OnClick", function()
            DungeonFormer:SearchPlayers()
        end)
        container:AddChild(searchButton)

        zoneDropdown = AceGUI:Create("Dropdown")
        local zNames = {}
        for i = 1, #Zones do
            table.insert(zNames, Zones[i])
        end
        zoneDropdown:SetList(zNames)
        zoneDropdown:SetText(ZoneDropdown)
        zoneDropdown:SetWidth(250)
        zoneDropdown:SetCallback("OnValueChanged", function(this, event, key)
            local zonename = Zones[key]
            ZoneDropdown = zonename
        end)
        container:AddChild(zoneDropdown)

        druidCheck = AceGUI:Create("CheckBox")
        druidCheck:SetLabel("Druid")
        druidCheck:SetValue(DruidCheck)
        druidCheck:SetType("checkbox")
        druidCheck:SetCallback("OnValueChanged", function()
            DruidCheck = druidCheck:GetValue()
        end)
        container:AddChild(druidCheck)

        hunterCheck = AceGUI:Create("CheckBox")
        hunterCheck:SetLabel("Hunter")
        hunterCheck:SetValue(HunterCheck)
        hunterCheck:SetType("checkbox")
        hunterCheck:SetCallback("OnValueChanged", function()
            HunterCheck = hunterCheck:GetValue()
        end)
        container:AddChild(hunterCheck)

        mageCheck = AceGUI:Create("CheckBox")
        mageCheck:SetLabel("Mage")
        mageCheck:SetValue(MageCheck)
        mageCheck:SetType("checkbox")
        mageCheck:SetCallback("OnValueChanged", function()
            MageCheck = mageCheck:GetValue()
        end)
        container:AddChild(mageCheck)

        paladinCheck = AceGUI:Create("CheckBox")
        paladinCheck:SetLabel("Paladin")
        paladinCheck:SetValue(PaladinCheck)
        paladinCheck:SetType("checkbox")
        paladinCheck:SetCallback("OnValueChanged", function()
            PaladinCheck = paladinCheck:GetValue()
        end)
        container:AddChild(paladinCheck)

        priestCheck = AceGUI:Create("CheckBox")
        priestCheck:SetLabel("Priest")
        priestCheck:SetValue(PriestCheck)
        priestCheck:SetType("checkbox")
        priestCheck:SetCallback("OnValueChanged", function()
            PriestCheck = priestCheck:GetValue()
        end)
        container:AddChild(priestCheck)

        rogueCheck = AceGUI:Create("CheckBox")
        rogueCheck:SetLabel("Rogue")
        rogueCheck:SetValue(RogueCheck)
        rogueCheck:SetType("checkbox")
        rogueCheck:SetCallback("OnValueChanged", function()
            RogueCheck = rogueCheck:GetValue()
        end)
        container:AddChild(rogueCheck)

        shamanCheck = AceGUI:Create("CheckBox")
        shamanCheck:SetLabel("Shaman")
        shamanCheck:SetValue(ShamanCheck)
        shamanCheck:SetType("checkbox")
        shamanCheck:SetCallback("OnValueChanged", function()
            ShamanCheck = shamanCheck:GetValue()
        end)
        container:AddChild(shamanCheck)

        warlockCheck = AceGUI:Create("CheckBox")
        warlockCheck:SetLabel("Warlock")
        warlockCheck:SetValue(WarlockCheck)
        warlockCheck:SetType("checkbox")
        warlockCheck:SetCallback("OnValueChanged", function()
            WarlockCheck = warlockCheck:GetValue()
        end)
        container:AddChild(warlockCheck)

        warriorCheck = AceGUI:Create("CheckBox")
        warriorCheck:SetLabel("Warrior")
        warriorCheck:SetValue(WarriorCheck)
        warriorCheck:SetType("checkbox")
        warriorCheck:SetCallback("OnValueChanged", function()
            WarriorCheck = warriorCheck:GetValue()
        end)
        container:AddChild(warriorCheck)

    end

    -- function that draws the widgets for the second tab
    local function DrawGroup2(container)
        if(carelessWhispered == nil) then
            carelessWhispered = {}
        end
        msg = AceGUI:Create("EditBox")
        msg:SetText(MessageBox)
        msg:SetLabel("Message")
        msg:SetWidth(250)
        msg:DisableButton(true)
        msg:SetCallback("OnTextChanged", function()
            MessageBox = msg:GetText()
        end)
        container:AddChild(msg)
        local f = AceGUI:Create("SimpleGroup")
        f:SetFullHeight(true)
        f:SetFullWidth(true)
        container:AddChild(f)
        f:SetLayout("Fill") --Fill will make the first child fill the whole content area
        local scrollWindow = AceGUI:Create("ScrollFrame")
        scrollWindow.width = "fill";
        scrollWindow.height = "fill";
        f:AddChild(scrollWindow)
        scrollWindow:SetLayout("Flow")
        for i = 1, table.getn(list) do
            local name = list[i].fullName;
            local level = list[i].level
            local class = list[i].classStr
            local area = list[i].area
            local playerString = name .. " " .. level .. " " .. area
            local tempLabel = AceGUI:Create("InteractiveLabel")
            --tempLabel:SetFont(GameFontHighlightMedium:GetFont())
            tempLabel:SetText(playerString)
            if class == "Warrior" then
                tempLabel:SetColor(ClassColors.Warrior.r, ClassColors.Warrior.g, ClassColors.Warrior.b)
            elseif class == "Priest" then
                tempLabel:SetColor(ClassColors.Priest.r, ClassColors.Priest.g, ClassColors.Priest.b)
            elseif class == "Druid" then
                tempLabel:SetColor(ClassColors.Druid.r, ClassColors.Druid.g, ClassColors.Druid.b)
            elseif class == "Hunter" then
                tempLabel:SetColor(ClassColors.Hunter.r, ClassColors.Hunter.g, ClassColors.Hunter.b)
            elseif class == "Mage" then
                tempLabel:SetColor(ClassColors.Mage.r, ClassColors.Mage.g, ClassColors.Mage.b)
            elseif class == "Paladin" then
                tempLabel:SetColor(ClassColors.Paladin.r, ClassColors.Paladin.g, ClassColors.Paladin.b)
            elseif class == "Rogue" then
                tempLabel:SetColor(ClassColors.Rogue.r, ClassColors.Rogue.g, ClassColors.Rogue.b)
            elseif class == "Shaman" then
                tempLabel:SetColor(ClassColors.Shaman.r, ClassColors.Shaman.g, ClassColors.Shaman.b)
            elseif class == "Warlock" then
                tempLabel:SetColor(ClassColors.Warlock.r, ClassColors.Warlock.g, ClassColors.Warlock.b)
            end
            tempLabel:SetHighlight([[Interface\QuestFrame\UI-QuestTitleHighlight]])
            tempLabel:SetFont("Fonts\\FRIZQT__.TTF", 10)
            tempLabel:SetCallback("OnClick", function()
                DEFAULT_CHAT_FRAME.editBox:SetText("/tell " .. name .. " " .. msg:GetText())
                ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
                table.insert(carelessWhispered, list[i])
                table.remove(list, i)
                tab:SelectTab("tab1") -- so lazy... just refreshing the tab by switching it.
                tab:SelectTab("tab2")
            end)
            scrollWindow:AddChild(tempLabel)
            frame:SetStatusText("      " .. table.getn(list) .. " names collected.")
        end


    end

    -- function that draws the widgets for the third tab
    local function DrawGroup3(container)
        if(carelessWhispered == nil) then
            carelessWhispered = {}
        end

        replyText = AceGUI:Create("EditBox")
        replyText:SetText(ReplyText)
        replyText:SetLabel("Auto-reply")
        replyText:SetWidth(170)
        replyText:DisableButton(true)
        replyText:SetCallback("OnTextChanged", function()
            ReplyText = replyText:GetText()
        end)
        container:AddChild(replyText)

        local replyButton = AceGUI:Create("Button")
        replyButton:SetText(ReplyingButton)
        replyButton:SetWidth(65)
        replyButton:SetCallback("OnClick", function()
            if ReplyingButton == "Off" then
                ReplyingButton = "On"
                frame:SetStatusText("Auto-Replying.")
            else
                ReplyingButton = "Off"
                frame:SetStatusText("Stopped Auto-Replying")
            end

            tab:SelectTab("tab1") -- so lazy... just refreshing the tab by switching it.
            tab:SelectTab("tab3")

        end)
        container:AddChild(replyButton)

        local clearNRButton = AceGUI:Create("Button")
        clearNRButton:SetText("Clear No-Reply")
        clearNRButton:SetWidth(120)
        clearNRButton:SetCallback("OnClick", function()
            local toremove = {}
            for i = 1, table.getn(carelessWhispered) do
                if not carelessWhispered[i].recentChat then
                    table.insert(toremove, i)
                    --table.remove(carelessWhispered,i)
                end
            end
            for x = 1, table.getn(toremove) do
                table.remove(carelessWhispered, toremove[x])
            end
            tab:SelectTab("tab1") -- so lazy... just refreshing the tab by switching it.
            tab:SelectTab("tab3")
            frame:SetStatusText("No-Replies Cleared")
        end)
        container:AddChild(clearNRButton)

        local clearButton = AceGUI:Create("Button")
        clearButton:SetText("Clear List")
        clearButton:SetWidth(120)
        clearButton:SetCallback("OnClick", function()
            carelessWhispered = {}
            tab:SelectTab("tab1") -- so lazy... just refreshing the tab by switching it.
            tab:SelectTab("tab3")
            frame:SetStatusText("Whispers cleared.")
        end)
        container:AddChild(clearButton)

        local f = AceGUI:Create("SimpleGroup")
        f:SetFullHeight(true)
        f:SetFullWidth(true)
        container:AddChild(f)
        f:SetLayout("Fill") --Fill will make the first child fill the whole content area
        local scrollWindow = AceGUI:Create("ScrollFrame")
        scrollWindow.width = "fill";
        scrollWindow.height = "fill";
        f:AddChild(scrollWindow)
        scrollWindow:SetLayout("Flow")
        for i = 1, table.getn(carelessWhispered) do
            local playerString = nil
            local name = carelessWhispered[i].fullName;
            local level = carelessWhispered[i].level
            local class = carelessWhispered[i].classStr
            local area = carelessWhispered[i].area
            local message = carelessWhispered[i].recentChat
            if not message then
                playerString = level .. " " .. name
            else
                playerString = level .. " " .. name .. ": " .. message
            end

            local tempLabel = AceGUI:Create("InteractiveLabel")
            --tempLabel:SetFont(GameFontHighlightMedium:GetFont())
            tempLabel:SetText(playerString)
            if class == "Warrior" then
                tempLabel:SetColor(ClassColors.Warrior.r, ClassColors.Warrior.g, ClassColors.Warrior.b)
            elseif class == "Priest" then
                tempLabel:SetColor(ClassColors.Priest.r, ClassColors.Priest.g, ClassColors.Priest.b)
            elseif class == "Druid" then
                tempLabel:SetColor(ClassColors.Druid.r, ClassColors.Druid.g, ClassColors.Druid.b)
            elseif class == "Hunter" then
                tempLabel:SetColor(ClassColors.Hunter.r, ClassColors.Hunter.g, ClassColors.Hunter.b)
            elseif class == "Mage" then
                tempLabel:SetColor(ClassColors.Mage.r, ClassColors.Mage.g, ClassColors.Mage.b)
            elseif class == "Paladin" then
                tempLabel:SetColor(ClassColors.Paladin.r, ClassColors.Paladin.g, ClassColors.Paladin.b)
            elseif class == "Rogue" then
                tempLabel:SetColor(ClassColors.Rogue.r, ClassColors.Rogue.g, ClassColors.Rogue.b)
            elseif class == "Shaman" then
                tempLabel:SetColor(ClassColors.Shaman.r, ClassColors.Shaman.g, ClassColors.Shaman.b)
            elseif class == "Warlock" then
                tempLabel:SetColor(ClassColors.Warlock.r, ClassColors.Warlock.g, ClassColors.Warlock.b)
            end
            tempLabel:SetHighlight([[Interface\QuestFrame\UI-QuestTitleHighlight]])
            tempLabel:SetFont("Fonts\\FRIZQT__.TTF", 10)
            tempLabel:SetCallback("OnClick", function()
                table.insert(list, carelessWhispered[i])
                table.remove(carelessWhispered, i)
                tab:SelectTab("tab1") -- so lazy... just refreshing the tab by switching it.
                tab:SelectTab("tab3")
            end)
            scrollWindow:AddChild(tempLabel)
        end
        frame:SetStatusText("      " .. table.getn(list) .. " names collected.")
    end

    -- Callback function for OnGroupSelected
    local function SelectGroup(container, event, group)
        container:ReleaseChildren()
        if group == "tab1" then
            DrawGroup1(container)
            currentTab = 1
        elseif group == "tab2" then
            DrawGroup2(container)
            currentTab = 2
        elseif group == "tab3" then
            DrawGroup3(container)
            currentTab = 3
        end
    end

    -- Create the frame container
    frame = AceGUI:Create("Frame")
    frame:SetTitle("Dungeon Former")
    frame:SetStatusText("Hotdogs.")
    frame:SetCallback("OnClose", function()
        frame:Hide()
        --AceGUI:Release(widget)
    end)
    -- Fill Layout - the TabGroup widget will fill the whole frame
    frame:SetLayout("Fill")
    frame:SetWidth(300)

    -- Create the TabGroup
    tab = AceGUI:Create("TabGroup")
    tab:SetLayout("Flow")
    -- Setup which tabs to show
    tab:SetTabs({ { text = "Search", value = "tab1" }, { text = "Results", value = "tab2" }, { text = "Whispered", value = "tab3" } })
    -- Register callback
    tab:SetCallback("OnGroupSelected", SelectGroup)
    -- Set initial Tab (this will fire the OnGroupSelected callback)
    tab:SelectTab("tab1")
    currentTab = 1
    --frame:RegisterEvent("CHAT_MSG_WHISPER")
    --local function eventHandler(self, event, ...)
    --   print("got it")
    --end
    --frame:SetScript("OnEvent", eventHandler);

    -- add to the frame container
    frame:AddChild(tab)

    local cFrame = CreateFrame("FRAME", "FooAddonFrame"); -- worker frame to check incoming chats
    cFrame:RegisterEvent("CHAT_MSG_WHISPER");
    local function eventHandler(self, event, ...)
        local arg1, arg2 = ...
        local OtherPlayer = arg2;
        local message = arg1
        for i = 1, table.getn(carelessWhispered) do
            local name = carelessWhispered[i].fullName;
            if string.find(OtherPlayer, name) then
                carelessWhispered[i].recentChat = string.sub(message, 1, 20) -- Arbitrarily chose 20 char limit.
                if (currentTab == 3) then
                    tab:SelectTab("tab1") -- again with the lazy tab updates
                    tab:SelectTab("tab3")
                end
                if ReplyingButton == "On" then
                    -- auto reply if autoreply is on
                    if not carelessWhispered[i].autoreplied then
                        -- check if you've already autoreplied to this person
                        DEFAULT_CHAT_FRAME.editBox:SetText("/tell " .. OtherPlayer .. " " .. ReplyText)
                        ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
                        carelessWhispered[i].autoreplied = true
                    end
                end
            end
        end
    end
    cFrame:SetScript("OnEvent", eventHandler);

end

function DungeonFormer:OnEnable()
    -- Called when the addon is enabled

end

function DungeonFormer:OnDisable()
    -- Called when the addon is disabled
end
