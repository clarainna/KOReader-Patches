-- This runs immediately when patch loads (safe)
local function createDownloadTab()
    -- This code runs later, after KOReader is initialized
    local DataStorage = require("datastorage")
    local FileManagerMenu = require("apps/filemanager/filemanagermenu")
    local fileMangerMenuInitOriginal = FileManagerMenu.init

    -- Custom menu tabs (Only make changes here to add tabs) -----------------------------------------------
    local subMenu = {
        -- tab_name = { icon = "tab_icon_name"},
        download = { icon = "appbar.download"},
    }
    ------------------------------------------------------------------
    
    local DataStorage = require("datastorage")
    local logger = require("logger")

    local FileManagerMenu = require("apps/filemanager/filemanagermenu")
    local fileMangerMenuInitOriginal = FileManagerMenu.init

    function FileManagerMenu:init()
        fileMangerMenuInitOriginal(self)

        for k, v in pairs(subMenu) do
            self.menu_items[k] =  v
        end
    end
-----------------------------------------------------------editing the shortcuts you want in the download menu is done HERE------------------
    code = [[
        return {
            ["KOMenu:menu_buttons"] = {
                "filemanager_settings",
                "setting",
                "tools",
                "search",
                "download", -- new download tab
                "plus_menu",
                "main",
            },
            
            -- no need to remove items from their default position -- 
    
            -- Add menu items to the new tabs, you need to find the name used for each plugin to appear in the menu. 
            -- in zlibrary plugin main.lua file it's here: 
    --function Zlibrary:addToMainMenu(menu_items)
    --if not self.ui.view then
        --menu_items.zlibrary_main = {
            --sorting_hint = "search",
            --text = T("Z-library"),
    
            download = { -- new download tab menu items
                "zlibrary_main",
                "rakuyomi", -- if you do not have either plugin, delete the line here to not cause issues
            },
        }
    ]]
--------------------------------------------------------------------------------------------------------------------
    
    local filepath = DataStorage:getSettingsDir() .. "/filemanager_menu_order.lua"

    -- Try to read existing file
    local file = io.open(filepath, "r")
    local existing_content = ""
    if file then
        existing_content = file:read("*all")
        file:close()
    end

    -- Only write if content is different
    if existing_content ~= code then
        file = io.open(filepath, "w")
        if file then
            file:write(code)
            file:close()
            logger.info("Menu order file updated")
        else
            logger.err("Failed to write menu order file: " .. filepath)
        end
    else
        logger.info("Menu order file already up to date")
    end
end

-- Schedule to run after initialization
local UIManager = require("ui/uimanager")
UIManager:scheduleIn(0.1, createDownloadTab)

