-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- enable qutebrowser bindings to appear in the hotkey menu
require("awful.hotkeys_popup.keys.qutebrowser")
-- enable tmux bindings to appear in the hotkey menu
require("awful.hotkeys_popup.keys.tmux")
-- }}}


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions

-- This is used later as the default terminal and editor to run.
local conf_dir = table.concat({os.getenv("XDG_CONFIG_HOME"), "awesome"}, "/")
local terminal = "termite"
local term_exec = terminal .. " -e "
local editor = os.getenv("EDITOR") or "nano"
local theme_fname = "theme.lua"
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"


-- }}}


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
     --awful.layout.suit.corner.ne,
     --awful.layout.suit.corner.sw,
     --awful.layout.suit.corner.se,
}
-- }}}

-- Load theme file
-- Themes define colours, icons, font and wallpapers.
beautiful.init(table.concat({conf_dir, theme_fname}, "/"))
theme = beautiful.get()
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

-- Use mypromptbox as a zsh shell.
-- https://awesomewm.org/doc/api/libraries/awful.spawn.html
local function zsh_exec()
    awful.prompt.run {
        prompt       = '<b>Zsh prompt: </b>',
        bg_cursor    = '#ff0000',
        -- Use the default rc.lua prompt (i.e. mypromptbox)
        textbox      = mouse.screen.mypromptbox.widget,
        exe_callback = function(input)
            local cmd = string.format("zsh -i -c '%s'", input)
            if not input or #input == 0 then return end
            awful.spawn.with_line_callback(cmd, {
                stdout = function(line)
                    naughty.notify { text = "LINE:"..line }
                end,
                stderr = function(line)
                    naughty.notify { text = "ERR:"..line}
                end,
            })
        end
    }
end

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "suspend", term_exec .. "'zsh -i -c suspend'" },
                                    { "poweroff", term_exec .. "'zsh -i -c poweroff'" },
                                    { "reboot", term_exec .. "'zsh -i -c reboot'" }
                                  }
                        })
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Mute state and volume percentage indicator
local mymaster_info = wibox.widget {
    {
        id = "mystate",
        image  = theme.widget_vol_mute,
        resize = false,
        visible = false,
        -- opacity = 0,
        widget = wibox.widget.imagebox
    },
    {
        id           = "myvol",
        markup       = nil,
        widget       = wibox.widget.textbox,
    },
    layout      = wibox.layout.align.horizontal,
    set_volume = function(self, vol)
        self.myvol.markup  = '<span foreground="'..theme.gray..'">Vol </span>'..vol
    end,
    set_state = function(self, sta)
            self.mystate.visible = sta
    end
}

-- Reminder indicator
local myreminder_nb = wibox.widget {
    {
        id           = "myrmd",
        markup       = nil,
        widget       = wibox.widget.textbox,
    },
    layout      = wibox.layout.align.horizontal,
    set_nbreminder = function(self, nb_rmd)
        self.myrmd.markup  = '<span foreground="'..theme.gray..'">Rem </span>'..nb_rmd
    end,
}

-- Reminder tooltip that appear when hovering over myreminder_nb widget
local myreminder_t = awful.tooltip({
        objects = { myreminder_nb }
    })

-- display the tooltip when hovering the mouse over myreminder_nb textbox widget
myreminder_nb:connect_signal("mouse::enter", function()
    awful.spawn.easy_async_with_shell('rmind', function(stdout, stderr, reason, exit_code)
        myreminder_t.text = stdout
    end)
end)

-- screen brightness indicator
local myscreenbright_val = wibox.widget {
    {
        id           = "mybright",
        markup       = nil,
        widget       = wibox.widget.textbox,
    },
    layout      = wibox.layout.align.horizontal,
    set_scrn_brightness = function(self, bright_val)
        self.mybright.markup  = '<span foreground="'..theme.gray..'">Lum </span>'..bright_val
    end,
}

-- {{{ Wibar
-- Create a textclock widget
-- mytextclock = wibox.widget.textclock()
-- see http://www.lua.org/pil/22.1.html for time format substitution
-- the default format is " %a %b %d, %H:%M" which add a space. I wanted to
-- remove the leading space thus defining my own format
mytextclock = wibox.widget.textclock (
    "%a %b %d, %H:%M"
)

-- Create a calendar widget and attach it to mytextclock
local month_calendar = awful.widget.calendar_popup.month()
month_calendar:attach(mytextclock, 'tr')

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    local names = { "1", "2", "3", "4", "5" }
    local l = awful.layout.suit  -- Just to save some typing: use an alias.
    local layouts = { l.tile, l.tile, l.tile, l.tile, l.tile }
    awful.tag(names, s, layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 2, -- spacing between each herebelow widgets
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 10, -- spacing between each herebelow widgets
            wibox.widget.systray(),
            myreminder_nb,
            myscreenbright_val,
            mymaster_info,
            mytextclock,
            s.mylayoutbox,
        },
    }

end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "k",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "t",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "s",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "t", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "s", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "t", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "s", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "l", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "r",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "c",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "c",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "r",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "c",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "r",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey }, "z", function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "à",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    awful.key({ modkey }, "e", zsh_exec,
        {description = "Execute a zsh code", group = "custom"}),

    awful.key({ modkey }, "q", function()
                                    local cmd="zsh -i -c 'clerk --add album'"
                                    awful.spawn(cmd)
                                end,
              {description = "Browse library by album", group = "clerk"}),

    awful.key({ modkey }, "l", function()
                                    local cmd="zsh -i -c 'clerk --add latest'"
                                    awful.spawn(cmd)
                                end,
              {description = "Browse most recent added music", group = "clerk"}),
    awful.key({ }, "Print", function ()
      awful.spawn("zsh -c 'import /tmp/$(date +%F_%H%M%S_%N).png'", false)
                              end,
              {description = "Take a screenshot to /tmp", group = "custom"})
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "h",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "j",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "feh",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- Focus Transparency
-- Only the focused client is not transparent
client.connect_signal("focus", function(c)
                              c.border_color = beautiful.border_focus
                              c.opacity = 1
                           end)
client.connect_signal("unfocus", function(c)
                                c.border_color = beautiful.border_normal
                                c.opacity = 0.90
                             end)
-- }}}

-- Timers
-- Timer for the volume and sound state
-- https://github.com/cedlemo/blingbling/blob/master/volume.lua
gears.timer {
    timeout   = 1,
    autostart = true,
    callback  = function()
        local cmd = "amixer get Master"
        awful.spawn.with_line_callback(cmd, {
            stdout = function(line)
                if string.match(line, "%s%[%d+%%%]%s") ~= nil then
                    volume=string.match(line, "%s%[%d+%%%]%s")
                    volume=string.gsub(volume, "[%[%]%%%s]","")
                    if (not volume) then
                        volume = 0
                    end
                    mymaster_info.volume = volume
                end
                if string.match(line, "%s%[[%l]+%]$") then
                    state=string.match(line, "%s%[[%l]+%]$")
                    state=string.gsub(state,"[%[%]%%%s]","")
                    if (not state or state == "yes" or state == "off") then
                        state = true  -- output is mute
                    else
                        state = false
                    end
                    mymaster_info.state = state
                end
            end,
        })
    end
}

-- Timers for the reminder textbox
-- The first one is used to initialize the textbox and run only once
gears.timer {
    timeout   = 1,
    autostart = true,
    single_shot = true,
    callback  = function()
        awful.spawn.easy_async(table.concat({conf_dir, "remind.sh"}, "/"),
            function(stdout, stderr, reason, exit_code)
                myreminder_nb.nbreminder = stdout
            end
        )
    end
}
-- The second one is used to update the reminder number every hour because the
-- reminder is not something that I modify every minutes.
gears.timer {
    timeout   = 3600,
    autostart = true,
    callback  = function()
        awful.spawn.easy_async(table.concat({conf_dir, "remind.sh"}, "/"),
            function(stdout, stderr, reason, exit_code)
                myreminder_nb.nbreminder = stdout
            end
        )
    end
}

-- Timer for the screen brightness
-- as before the first one is used to initialize the textbox
gears.timer {
    timeout = 1,
    autostart = true,
    single_shot = true,
    callback  = function()
        local cmd = 'ddcutil getvcp 10 --nodetect --bus 1'
        local brightness
        awful.spawn.easy_async(cmd,
            function(stdout, stderr, reason, exit_code)
                if string.match(stdout, "^VCP%s+code%s+0x10.*") ~= nil then
                    brightness = string.match(stdout, '.*current%s+value%s+=%s+(%d+).*')
                else
                    brightness = "Error"
                end
                myscreenbright_val.scrn_brightness = brightness
            end
        )
    end
}
-- the second one update the textbox every minutes. I don't need it to be real
-- time so 1 minutes seems enough.
gears.timer {
    timeout = 60,
    autostart = true,
    callback  = function()
        local cmd = 'ddcutil getvcp 10 --nodetect --bus 1'
        local brightness
        awful.spawn.easy_async(cmd,
            function(stdout, stderr, reason, exit_code)
                if string.match(stdout, "^VCP%s+code%s+0x10.*") ~= nil then
                    brightness = string.match(stdout, '.*current%s+value%s+=%s+(%d+).*')
                else
                    brightness = "Error"
                end
                myscreenbright_val.scrn_brightness = brightness
            end
        )
    end
}
-- }}}

-- Execute autorun.sh at startup
awful.spawn(table.concat({conf_dir, "autorun.sh"}, "/"))
-- }}}
