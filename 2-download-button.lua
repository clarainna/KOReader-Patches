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
            
        -- Remove menu items you want to add to new tab from old tabs while keeping the menu items you want to keep in the same location (--- comments out the line, removes the item)
        --- tools = {
                --- ...
                --- "cloud_storage",
                ---"move_to_archive",
                --- "wallabag",
                --- ...
            ---},
            search = {
                --- ...
                ---"zlibrary_main",
                ---"rakuyomi",
            },
            
            -- Add removed menu items to the new tabs
            download = { -- new download tab menu items
                "zlibrary_main",
                "rakuyomi",
            },
        }
    ]]

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
