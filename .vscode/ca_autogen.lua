--- TODO autogen from all CA lib files

--- scripting_doc.html
local function parse_events()
    local file = io.open(".vscode/scripting_doc.html", "r")
    if not file then
        return print("No scripting_doc.html file found!")
    end

    print("Events file found!")

    --- First, loop through the "Events" section and define a table of events
    --- Then, loop through the "Interfaces" section and do the same

    --- Next, go through the events table, find those events in the file, parse the functions within, saving them within the events
    --- Next, go through interfaces and do the same

    --- Finaly, print out and write down all of these using EmmyLua annotations.
        --- In this, make a version of add_listener for each variant!

    local section = 0
    local events = {}
    local interfaces = {}

    local current_event
    local current_interface

    for line in file:lines("*a") do
        if section == 0 then -- Very top
            if line == "<h2>Events</h2>" then 
                section = 1
            end
        elseif section == 1 then -- Events section
            if line:find("Interfaces") then
                -- we're in Interfaces now!
                section = 2
            elseif line:find("a href=") then
                -- we're defining an event here - grab its name.
                -- print(line)
                local sx,ex = line:find('href=\"#%a+\"')
                if not sx then
                    -- err
                else
                    sx = sx + 7
                    ex = ex - 1
                    local name = line:sub(sx,ex)
                    print("Found event: " .. name)

                    events[name] = {
                        functions = {},
                    }
                end
            end
        elseif section == 2 then -- Interfaces def!
            if line:find("Event Functions") then
                -- we're in Interfaces now!
                section = 3
            elseif line:find("a href=") then
                -- we're defining an event here - grab its name.
                -- print(line)
                local sx,ex = line:find('href=\"#[%a_]+\"')
                if not sx then
                    -- err
                else
                    sx = sx + 7
                    ex = ex - 1
                    local name = line:sub(sx,ex)
                    print("Found interface: " .. name)

                    interfaces[name] = {
                        key = name,
                        functions = {},
                    }
                end
            end
        elseif section == 3 then -- Event Functions
            local sx,sy = line:find("name=\"%a+\"")
            if line:find("Interface Functions") then 
                section = 4
            elseif current_event then -- we're in an event function
                -- end is <br></dd> to next event
                if line:find("<br></dd>") then 
                    current_event = nil
                else
                    -- first line is "Function Name: ", for the actual index for the function
                    local fx,fy = line:find("Function Name: [%a_]+")
                    if fx then
                        -- grab the function index
                        local fn_index = line:sub(fx, fy)
                        fn_index = fn_index:gsub("Function Name: ", "")
                        -- print("Found function in event " .. current_event .. " with index " .. fn_index)
                        
                        events[current_event].functions[#events[current_event].functions+1] = {
                            index = fn_index,
                            description = "",
                            returns = nil,
                        }
                    else
                        -- we're in a function - grab the last one made
                        local fn_tab = events[current_event].functions[#events[current_event].functions]
                        
                        local ix,iy = line:find("Interface: <a href=\"#[%a_]+")
                        local dx,dy = line:find("Description: [%a%s%p]+")

                        if ix then
                            print("Retval found")
                            -- we're getting the return value!
                            local ret = line:sub(ix, iy)
                            ret = ret:gsub("Interface: <a href=\"#", "")
                            -- print("Return for function "..current_event..":"..fn_tab.index.."() is " .. ret)

                            fn_tab.returns = ret
                        elseif dx then
                            print("Desc found")
                            -- we're getting the description!
                            local desc = line:sub(dx, dy)
                            desc = desc:gsub("Description: ", "")
                            desc = desc:gsub("</dd>", "")
                            -- print("Description for function "..current_event..":"..fn_tab.index.."() is " .. desc)

                            fn_tab.description = desc
                        else
                            -- skip?
                        end
                    end
                end
            elseif sx then
                local event_name = line:sub(sx, sy):gsub("name=", "")
                event_name = event_name:gsub("\"", "")

                print(line)
                -- print("In functions for event " .. tostring(event_name))

                current_event = event_name
            end
        elseif section == 4 then -- interface functions
            -- could be the interface name or the function name
            local nx,ny = line:find("<a name=\"[%a_]+")
            if nx then
                print("Found a new thing")
                -- get rid of the HTML stuff
                local s = line:sub(nx, ny)
                s = s:gsub("<a name=\"", "")

                print(s)

                -- test if it's an existing interface
                if interfaces[s] then -- it's an interface!
                    current_interface = s
                else
                    -- functions are defined as <a name="INTERFACEfunction">, so we have to get rid of the interface name
                    s = s:gsub(current_interface, "")
                    -- we've got the name of a function
                    interfaces[current_interface].functions[#interfaces[current_interface].functions+1] = {
                        index = s,
                        params = nil,
                        returns = nil,
                        description = "",
                    }
                end
            elseif current_interface then
                print("In interface " .. current_interface)
                -- all we need from here is the desc/param/ret fields
                local dx,dy = line:find("Description: [%a%s%p]+")
                local px,py = line:find("Parameters: [%a%s%p]+")
                local rx,ry = line:find("Return: [%a%s%p]+")

                if dx and not interfaces[current_interface].description then 
                    local desc = line:sub(dx, dy)
                    desc = desc:gsub("</dd>", "")
                    interfaces[current_interface].description = desc
                else
                    local fn_tab = interfaces[current_interface].functions[#interfaces[current_interface].functions]
                    if dx then 
                        local desc = line:sub(dx, dy)
                        desc = desc:gsub("</dd>", "")
                        fn_tab.description = desc 
                    elseif px then 
                        --- Parameters: is_recipe_available(String recipe_key)
                        local param = line:sub(px, py)
                        param = param:gsub("</dd>", "")

                        param = param:gsub(fn_tab.index, "")
                        param = param:gsub("[()]", "")
                        print("Param: " .. param)
                        if param ~= "" then
                            fn_tab.params = param
                        end
                    elseif rx then 
                        local ret = line:sub(rx, ry)
                        ret = ret:gsub("Return: ", "")
                        ret = ret:gsub("</dd>", "")

                        --- TODO it will sometimes do an a href= here for interfaces, so check and fix!
                        local hx,hy = ret:find("<a href=\"#[%a_]+")
                        if hx then
                            print("HREF FOUND: " .. ret)
                            ret = ret:sub(hx, hy)
                            print("SUBBED: " .. ret)
                            ret = ret:gsub("<a href=\"#", "")
                            print("GSUB: " .. ret)
                        end

                        print("Ret: ".. ret)
                        fn_tab.returns = ret
                    end
                end
            end

            -- first line is interface key
            -- second is a description of this interface
            -- third is a list of all function indices
            -- following that is a breakdown of each function's description / parameters / returns
        end
    end

    --- Print file
    local new_file = io.open(".vscode/tw_events_and_interfaces.lua", "w+")

    local endl = "---============================---"
    local startl = "\t--- [[ %s ]] ---"

    local s = string.format("%s\n", "---@diagnostic disable\n")

    -- First, write out the events section
    s = s .. endl .. string.format("\n%s\n", string.format(startl, "Events")) .. endl
    for key,event in pairs(events) do
        local event_string = string.format("\n\n---@class %s", key)
        for i,fun in ipairs(event.functions) do
            event_string = event_string .. string.format("\n---@field %s fun(self:%s)%s", fun.index, key, type(fun.returns) == "nil" and "" or ":"..fun.returns)
        end

        s = s .. event_string
    end

    -- write out the interfaces section!
    s = s .. "\n\n" ..  endl .. string.format("\n%s\n", string.format(startl, "Interfaces")) .. endl
    for key,interface in pairs(interfaces) do
        local interface_string = string.format("\n\n---@class %s%s", key, (" " .. interface.description) or "")
        for i,fun in ipairs(interface.functions) do
            --- TODO params
            interface_string = interface_string .. string.format("\n---@field %s fun(self:%s)%s", fun.index, key, (fun.returns and fun.returns ~= "" and ":" .. fun.returns) or "")
        end

        s = s .. interface_string
    end

    -- add_listener variants!!
    s = s .. "\n\n" .. endl .. string.format("\n%s\n", string.format(startl, "Listeners")) .. endl .. "\n\n---@class Core"
    for key,_ in pairs(events) do 
        s = s .. string.format("\n---@field add_listener fun(self:Core, key:string, event: \"'%s'\", conditional: fun(context:%s), callback:fun(context:%s), persistent:boolean)", key, key, key)
    end

    new_file:write(s)
end

--- TODO campaign_manager.html
--- TODO load CM first and then ES
local function parse_cm()
    local file = io.open(".vscode/campaign_manager.html", "r")
    if not file then
        return print("No campaign_manager.html file found!")
    end

    print("CM file found!")

    --- TODO similar operation to what I did with events

    --- TODO skip everything until div id="content"
    local section = 0

    --- This is just for me
    local sections = {
        0, -- boilerplate nothing, just waiting for the next section
        1, -- just getting the description text for the CM ("content")
        2, -- every function! ("section_header"/"section_body" per header, ie. Creation, Usage, Loading Game)
    }

    local cm = {
        description = {}
    }

    for line in file:lines("*a") do
        if section == 0 then 
            if line:find("<div id=\"content\">") then 
                section = 1
            end
        elseif section == 1 then
            -- get every line that starts with <p>
            -- TODO change href to proper @see and kill other HTML tags
            if line:find("<p>") then
                cm.description[#cm.description+1] = line
            end
        end
    end
end

--- TODO the actual html files for episodic scripting, since we don't have raw files for those
local function parse_episodic()
    
end

--- TODO lib_battle_manager
local function parse_bm()

end



print("START")
package.path = package.path .. ";.vscode/?.lua"
-- parse_events()
parse_cm()
print("END")