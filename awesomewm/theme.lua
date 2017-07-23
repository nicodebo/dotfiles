---------------------------
-- Default awesome theme --
---------------------------


-- Additional awesome library

-- variables
local conf_dir = table.concat({os.getenv("XDG_CONFIG_HOME"), "awesome"}, "/")
local wallpaper_dir = table.concat({os.getenv("HOME"), "Pictures", "wallpaper"}, "/")

-- helper functions
-- list image files in dir
function listPngFiles(dir)
    local wallpapers = {}
    local cmd = 'find "'..dir..'" -type f -name "*.png" -o -name "*.jpg"'
    local p = io.popen(cmd)  --Open directory look for files, save data in p. By giving '-type f' as parameter, it returns all files.
    for file in p:lines() do                         --Loop through all files
        table.insert(wallpapers, file)
    end
    p:close()
    return wallpapers
end

-- This function allow to select a random item from a list
function selectRandomItem(table)
    -- Initialize the pseudo random number generator
    math.randomseed( os.time() )
    math.random(); math.random(); math.random()
    -- done. :-)
    return table[math.random(#table)]
end

-- define theme
local theme = {}
--custom theme var
theme.gray   = "#94928F"

-- beautiful theme variables
-- https://awesomewm.org/apidoc/libraries/beautiful.html
theme.font          = "Deja Vu Sans Mono 9" -- default font
theme.useless_gap   = 3 -- gap between clients
theme.border_width  = 1 -- client border width
theme.border_normal = "#3F3F3F" -- default client's border color
theme.border_focus  = "#6F6F6F" -- focused client's border color
theme.border_marked = "#CC9393" -- marked client's border color
theme.wallpaper = selectRandomItem(listPngFiles(wallpaper_dir)) -- wallpaper path
-- TODO: fallback to a default wallpaper if no wallpaper is found in
-- ~/Pictures/wallpaper

theme.fg_normal     = "#FEFEFE"
theme.fg_focus      = "#32D6FF"
theme.fg_urgent     = "#EB606B"
theme.bg_normal     = "#222222"
theme.bg_focus      = "#222222"
theme.bg_urgent     = "#65737E"

theme.bg_systray    = theme.bg_normal

-- theme.fg_normal     = "#aaaaaa"
-- theme.fg_focus      = "#ffffff"
-- theme.fg_urgent     = "#ffffff"
-- theme.fg_minimize   = "#ffffff"

-- theme.border_normal = "#000000"
-- theme.border_focus  = "#535d6c"
-- theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.taglist_fg_focus                          = "#00CCFF"
theme.tasklist_bg_focus                         = "#222222"
theme.tasklist_fg_focus                         = "#00CCFF"

theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
-- Display the taglist squares
-- theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
-- theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

-- theme.tasklist_plain_task_name                  = true
-- theme.tasklist_disable_icon                     = true

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
-- theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
-- theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

-- theme.titlebar_minimize_button_normal = "/usr/share/awesome/themes/default/titlebar/minimize_normal.png"
-- theme.titlebar_minimize_button_focus  = "/usr/share/awesome/themes/default/titlebar/minimize_focus.png"

-- theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
-- theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

-- theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
-- theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

-- theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
-- theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
-- theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
-- theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

-- theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
-- theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"


-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating  = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle = "/usr/share/awesome/themes/default/layouts/dwindlew.png"
theme.layout_cornernw = "/usr/share/awesome/themes/default/layouts/cornernww.png"
theme.layout_cornerne = "/usr/share/awesome/themes/default/layouts/cornernew.png"
theme.layout_cornersw = "/usr/share/awesome/themes/default/layouts/cornersww.png"
theme.layout_cornerse = "/usr/share/awesome/themes/default/layouts/cornersew.png"

-- theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

theme.menu_submenu_icon                         = conf_dir .. "/icons/submenu.png"
theme.awesome_icon                              = conf_dir .. "/icons/awesome.png"
theme.taglist_squares_sel                       = conf_dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = conf_dir .. "/icons/square_unsel.png"
-- theme.layout_tile                               = conf_dir .. "/icons/tile.png"
-- theme.layout_tileleft                           = conf_dir .. "/icons/tileleft.png"
-- theme.layout_tilebottom                         = conf_dir .. "/icons/tilebottom.png"
-- theme.layout_tiletop                            = conf_dir .. "/icons/tiletop.png"
-- theme.layout_fairv                              = conf_dir .. "/icons/fairv.png"
-- theme.layout_fairh                              = conf_dir .. "/icons/fairh.png"
-- theme.layout_spiral                             = conf_dir .. "/icons/spiral.png"
-- theme.layout_dwindle                            = conf_dir .. "/icons/dwindle.png"
-- theme.layout_max                                = conf_dir .. "/icons/max.png"
-- theme.layout_fullscreen                         = conf_dir .. "/icons/fullscreen.png"
-- theme.layout_magnifier                          = conf_dir .. "/icons/magnifier.png"
-- theme.layout_floating                           = conf_dir .. "/icons/floating.png"
theme.widget_ac                                 = conf_dir .. "/icons/ac.png"
theme.widget_battery                            = conf_dir .. "/icons/battery.png"
theme.widget_battery_low                        = conf_dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = conf_dir .. "/icons/battery_empty.png"
theme.widget_mem                                = conf_dir .. "/icons/mem.png"
theme.widget_cpu                                = conf_dir .. "/icons/cpu.png"
theme.widget_temp                               = conf_dir .. "/icons/temp.png"
theme.widget_net                                = conf_dir .. "/icons/net.png"
theme.widget_hdd                                = conf_dir .. "/icons/hdd.png"
theme.widget_music                              = conf_dir .. "/icons/note.png"
theme.widget_music_on                           = conf_dir .. "/icons/note_on.png"
theme.widget_music_pause                        = conf_dir .. "/icons/pause.png"
theme.widget_music_stop                         = conf_dir .. "/icons/stop.png"
theme.widget_vol                                = conf_dir .. "/icons/vol.png"
theme.widget_vol_low                            = conf_dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = conf_dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = conf_dir .. "/icons/vol_mute.png"
theme.widget_mail                               = conf_dir .. "/icons/mail.png"
theme.widget_mail_on                            = conf_dir .. "/icons/mail_on.png"
theme.widget_task                               = conf_dir .. "/icons/task.png"
theme.widget_scissors                           = conf_dir .. "/icons/scissors.png"
theme.titlebar_close_button_focus               = conf_dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = conf_dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = conf_dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = conf_dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = conf_dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = conf_dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = conf_dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = conf_dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = conf_dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = conf_dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = conf_dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = conf_dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = conf_dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = conf_dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = conf_dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = conf_dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = conf_dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = conf_dir .. "/icons/titlebar/maximized_normal_inactive.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
