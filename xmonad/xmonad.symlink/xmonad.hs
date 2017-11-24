import qualified Data.Map as M
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Accordion
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.SpawnOnce
import XMonad.StackSet(greedyView)

  
myKeys x = [ ((modMask x,               xK_Left),  prevWS)
           , ((modMask x,               xK_Left),  nextWS)
           , ((modMask x .|. shiftMask, xK_Right), shiftToNext)
           , ((modMask x .|. shiftMask, xK_Left),  shiftToPrev)
           , ((modMask x,               xK_t),     toggleWS)
           , ((modMask x,               xK_s),     spawn "dmenu_run -b -fn 'Droid Sans Mono-14'")
           , ((mod1Mask .|. controlMask, xK_l),    spawn "xtrlock -b")
           , ((0                , 0x1008ff11),     spawn "amixer -c 1 sset Master 4-")
           , ((0                , 0x1008ff13),     spawn "amixer -c 1 sset Master 4+")
           , ((0                , 0x1008ff03),     spawn "xbacklight -inc -10%")
           , ((0                , 0x1008ff02),     spawn "xbacklight -inc +10%")

           , ((0                , 0x1008ff12),     spawn "amixer sset Master toggle")
           ]

newKeys x  = M.union (keys defaultConfig x) (M.fromList (myKeys x))

myManageHook = composeAll (
    [ manageHook gnomeConfig
    , resource  =? "stalonetray" --> doIgnore
    , manageDocks
    ])

myStartupHook = do
  spawnOnce "xmodmap ~/.Xmodmap"
  spawnOnce "stalonetray --dockapp-mode simple"
  spawnOnce "unity-settings-daemon"
  spawnOnce "gnome-settings-daemon"
  spawnOnce "nm-applet"
  spawnOnce "pasystray"
  spawnOnce "fdpowermon"

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/justin/.xmobarrc"
    xmonad $ gnomeConfig {
         manageHook = myManageHook
       , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
       , logHook = dynamicLogWithPP xmobarPP
                   { ppOutput = hPutStrLn xmproc
                   , ppTitle = xmobarColor "green" "" . shorten 50
                   }
       , startupHook = myStartupHook
       , modMask = mod4Mask
       , keys = newKeys
       , terminal = "gnome-terminal"
       , handleEventHook =
         mconcat [ docksEventHook
                 , handleEventHook defaultConfig ]
       }
