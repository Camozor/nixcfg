
------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "wofi --show drun"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("$HOME/.config/hypr/start.sh")
    hl.exec_cmd("hyprctl setcursor Adwaita 16")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("nm-applet")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "48")
hl.env("HYPRCURSOR_SIZE", "48")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding = 10,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle",enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = false })

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "fr",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        repeat_delay = 200,
        repeat_rate  = 20,

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "ALT"

-- Applications
hl.bind(mainMod .. " + return",    hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C",         hl.dsp.window.close())
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + N",         hl.dsp.exec_cmd(terminal .. " nvim"))
hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd("brave --remote-debugging-port=9222 --user-data-dir=/tmp/chrome-impersonation"))
hl.bind("CTRL_L + ALT_L + L",      hl.dsp.exec_cmd("hyprlock"))

-- Move focus (vim-style on AZERTY: h/j/k/l map to h/j/k/l keys)
hl.bind(mainMod .. " + H",         hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",         hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",         hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",         hl.dsp.focus({ direction = "down" }))

-- Switch workspaces (French AZERTY layout)
hl.bind(mainMod .. " + ampersand",  hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + eacute",     hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + quotedbl",   hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + apostrophe", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + parenleft",  hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + minus",      hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + Egrave",     hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + underscore", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + Ccedilla",   hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + Agrave",     hl.dsp.focus({ workspace = 10 }))

-- Move window to workspace (French AZERTY layout)
hl.bind("ALT_L + SHIFT_L + ampersand",  hl.dsp.window.move({ workspace = 1 }))
hl.bind("ALT_L + SHIFT_L + eacute",     hl.dsp.window.move({ workspace = 2 }))
hl.bind("ALT_L + SHIFT_L + quotedbl",   hl.dsp.window.move({ workspace = 3 }))
hl.bind("ALT_L + SHIFT_L + apostrophe", hl.dsp.window.move({ workspace = 4 }))
hl.bind("ALT_L + SHIFT_L + parenleft",  hl.dsp.window.move({ workspace = 5 }))
hl.bind("ALT_L + SHIFT_L + minus",      hl.dsp.window.move({ workspace = 6 }))
hl.bind("ALT_L + SHIFT_L + Egrave",     hl.dsp.window.move({ workspace = 7 }))
hl.bind("ALT_L + SHIFT_L + underscore", hl.dsp.window.move({ workspace = 8 }))
hl.bind("ALT_L + SHIFT_L + Ccedilla",   hl.dsp.window.move({ workspace = 9 }))
hl.bind("ALT_L + SHIFT_L + Agrave",     hl.dsp.window.move({ workspace = 10 }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",             hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S",     hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down",    hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",      hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272",     hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",     hl.dsp.window.resize(), { mouse = true })

-- Custom scripts
hl.bind(mainMod .. " + F10",    hl.dsp.exec_cmd("$HOME/.config/hypr/toggle_screen_mode.sh"))
hl.bind(mainMod .. " + F8",     hl.dsp.exec_cmd("$HOME/.config/hypr/toggle_speaker.sh"))
hl.bind(mainMod .. " + F7",     hl.dsp.exec_cmd("$HOME/.config/hypr/toggle_micro.sh"))
hl.bind(mainMod .. " + Print",  hl.dsp.exec_cmd("$HOME/.config/hypr/take_screenshot.sh"))
