DungeonFormer = LibStub("AceAddon-3.0"):NewAddon("DungeonFormer", "AceConsole-3.0", "AceEvent-3.0")
timer =0
lowest=1
highest=60
list={}
local options = {
    name = "DungeonFormer",
    handler = DungeonFormer,
    type = 'group',
    args = {
    },
}

function DungeonFormer:AddToScroll(name, playerTable)
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
  resultNumber=C_FriendList.GetNumWhoResults();
  for i=1,resultNumber do
    table.insert(list,C_FriendList.GetWhoInfo(i))
  end
  --local player = list[1]
  --print(player.fullName)
  ToggleFriendsFrame(2)
  tab:SelectTab("tab2")
end

function DungeonFormer:SearchPlayers()
  -- clear the list table
  list={}

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
  local warriorCheck = warriorCheck:GetValue();

  if(druid or hunter or mage or paladin or priest or rogue or shaman or warlock or warrior) then
    classChecked=true;
  end

  -- msg
  msg = "/who "

  -- level shit
  local low = lowLvl:GetText();
  local high = highLvl:GetText();

  -- attach zone to msg
  local subzone = GetZoneText();
  local checkarea = inareaCheck:GetValue();
  if(checkarea) then
    msg = msg .. "z-\""..subzone.."\" "
  end

  -- append class text to msg

  if(classChecked) then
    if(druid) then msg = msg .. "c-druid " end
    if(hunter) then msg = msg .. "c-hunter " end
    if(mage) then msg = msg .. "c-mage " end
    if(paladin) then msg = msg .. "c-paladin " end
    if(priest) then msg = msg .. "c-priest " end
    if(rogue) then msg = msg .. "c-rogue " end
    if(shaman) then msg = msg .. "c-shaman " end
    if(warlock) then msg = msg .. "c-warlock " end
    if(warrior) then msg = msg .. "c-warrior " end
  end

  -- append numbers to msg
  msg = msg .. low .. "-" .. high

  DEFAULT_CHAT_FRAME.editBox:SetText(msg) ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
  C_Timer.After(1, function() DungeonFormer:PullWho() end)
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

        lowLvl = AceGUI:Create("EditBox")
        lowLvl:SetText("1")
        lowLvl:SetLabel("Low Level")
        lowLvl:SetWidth(60)
        lowLvl:DisableButton(true)
        container:AddChild(lowLvl)

        highLvl = AceGUI:Create("EditBox")
        highLvl:SetText("60")
        highLvl:SetLabel("High Level")
        highLvl:SetWidth(60)
        highLvl:DisableButton(true)
        container:AddChild(highLvl)

        local searchButton = AceGUI:Create("Button")
        searchButton:SetText("Search")
        searchButton:SetWidth(100)
        searchButton:SetCallback("OnClick", function() DungeonFormer:SearchPlayers() end)
        container:AddChild(searchButton)

        inareaCheck = AceGUI:Create("CheckBox")
        inareaCheck:SetLabel("Search Only In Current Map")
        inareaCheck:SetValue(false)
        inareaCheck:SetType("checkbox")
        container:AddChild(inareaCheck)

        local classHeading = AceGUI:Create("Heading")
        classHeading:SetText("Class Inclusion")
        classHeading:SetHeight(50)
        container:AddChild(classHeading)

        druidCheck = AceGUI:Create("CheckBox")
        druidCheck:SetLabel("Druid")
        druidCheck:SetValue(true)
        druidCheck:SetType("checkbox")
        container:AddChild(druidCheck)

        hunterCheck = AceGUI:Create("CheckBox")
        hunterCheck:SetLabel("Hunter")
        hunterCheck:SetValue(false)
        hunterCheck:SetType("checkbox")
        container:AddChild(hunterCheck)

        mageCheck = AceGUI:Create("CheckBox")
        mageCheck:SetLabel("Mage")
        mageCheck:SetValue(false)
        mageCheck:SetType("checkbox")
        container:AddChild(mageCheck)

        paladinCheck = AceGUI:Create("CheckBox")
        paladinCheck:SetLabel("Paladin")
        paladinCheck:SetValue(false)
        paladinCheck:SetType("checkbox")
        container:AddChild(paladinCheck)

        priestCheck = AceGUI:Create("CheckBox")
        priestCheck:SetLabel("Priest")
        priestCheck:SetValue(false)
        priestCheck:SetType("checkbox")
        container:AddChild(priestCheck)

        rogueCheck = AceGUI:Create("CheckBox")
        rogueCheck:SetLabel("Rogue")
        rogueCheck:SetValue(false)
        rogueCheck:SetType("checkbox")
        container:AddChild(rogueCheck)

        shamanCheck = AceGUI:Create("CheckBox")
        shamanCheck:SetLabel("Shaman")
        shamanCheck:SetValue(false)
        shamanCheck:SetType("checkbox")
        container:AddChild(shamanCheck)

        warlockCheck = AceGUI:Create("CheckBox")
        warlockCheck:SetLabel("Warlock")
        warlockCheck:SetValue(false)
        warlockCheck:SetType("checkbox")
        container:AddChild(warlockCheck)

        warriorCheck = AceGUI:Create("CheckBox")
        warriorCheck:SetLabel("Warrior")
        warriorCheck:SetValue(false)
        warriorCheck:SetType("checkbox")
        container:AddChild(warriorCheck)

    end

    -- function that draws the widgets for the second tab
    local function DrawGroup2(container)
      local f = AceGUI:Create("SimpleGroup")
      container:AddChild(f)
      f:SetLayout("Fill") --Fill will make the first child fill the whole content area
      local scrollWindow = AceGUI:Create("ScrollFrame")
      f:AddChild(scrollWindow)
      scrollWindow:SetLayout("Flow")
      local labels = {}
      for i=1,table.getn(list) do
        local name = list[i].fullName;
        local level = list[i].level
        local class = list[i].classStr
        local area = list[i].area
        local playerString = name .. " " .. level .. " " .. class .. " " .. area
        tempLabel = AceGUI:Create("Label")
        tempLabel:SetText(playerString)
        tempLabel:SetFullWidth(true)
        container:AddChild(tempLabel)
      end
      

    end

    -- function that draws the widgets for the third tab
    local function DrawGroup3(container)
      local desc = AceGUI:Create("Label")
      desc:SetText("Blacklist")
      desc:SetFullWidth(true)
      container:AddChild(desc)

      local button = AceGUI:Create("Button")
      button:SetText("Tab 3 Button")
      button:SetWidth(200)
      container:AddChild(button)
    end

    -- Callback function for OnGroupSelected
    local function SelectGroup(container, event, group)
       container:ReleaseChildren()
       if group == "tab1" then
          DrawGroup1(container)
       elseif group == "tab2" then
          DrawGroup2(container)
       elseif group == "tab3" then
          DrawGroup3(container)
       end
    end

    -- Create the frame container
    frame = AceGUI:Create("Frame")
    frame:SetTitle("Dungeon Former")
    frame:SetStatusText("Hotdogs.")
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    -- Fill Layout - the TabGroup widget will fill the whole frame
    frame:SetLayout("Fill")
    frame:SetWidth(300)

    -- Create the TabGroup
    tab =  AceGUI:Create("TabGroup")
    tab:SetLayout("Flow")
    -- Setup which tabs to show
    tab:SetTabs({{text="Search", value="tab1"}, {text="Results", value="tab2"}, {text="Blacklist", value="tab3"}})
    -- Register callback
    tab:SetCallback("OnGroupSelected", SelectGroup)
    -- Set initial Tab (this will fire the OnGroupSelected callback)
    tab:SelectTab("tab1")

    -- add to the frame container
    frame:AddChild(tab)
end

function DungeonFormer:OnEnable()
    -- Called when the addon is enabled

end

function DungeonFormer:OnDisable()
    -- Called when the addon is disabled
end
