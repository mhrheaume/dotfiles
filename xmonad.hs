import XMonad
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.LayoutHints
import XMonad.Util.EZConfig

main = do
  d <- spawnPipe "dzen2 -p -x 0 -y 0 -w 960 -h 24 -ta l -fn 'Monospace-9'" 
  spawn $ "conky -c ~/.xmonad/dzen_conky | " ++
            "dzen2 -p -x 960 -y 0 -w 960 -h 24 -ta r -fn 'Monospace-9'"
  xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
    { terminal            = myTerminal
    , workspaces          = myWorkspaces
    , manageHook          = myManageHook
    , layoutHook          = myLayoutHook
    , logHook             = myLogHook d
    , normalBorderColor   = myNormalBorderColor
    , focusedBorderColor  = myFocusedBorderColor
    , modMask             = mod4Mask
    , borderWidth         = 1
    } `additionalKeysP` myKeys

myTerminal = "urxvt"

myWorkspaces = ["1:dev","2:web","3:chat","4:virt"]

myNormalBorderColor  = "#1c1c1c"
myFocusedBorderColor = "#555555"

myLogHook h = dynamicLogWithPP $ defaultPP
  { ppCurrent         = dzenColor "#1c1c1c" "#555555" . pad
  , ppHidden          = dzenColor "#909090" "" . pad
  , ppHiddenNoWindows = dzenColor "#606060" "" . pad
  , ppLayout          = dzenColor "#909090" "" . pad
  , ppUrgent          = dzenColor "#ff0000" "" . pad . dzenStrip
  , ppTitle           = shorten 100
  , ppWsSep           = ""
  , ppSep             = " | "
  , ppOutput          = hPutStrLn h
  }

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
  [ [resource   =? r  --> doIgnore          | r <- myIgnores  ]
  , [className  =? c  --> doShift "1:dev"   | c <- myDev      ]
  , [className  =? c  --> doShift "2:web"   | c <- myWebs     ]
  , [className  =? c  --> doCenterFloat     | c <- myFloats   ]
  ])
  where
    myFloats  = ["Downloads"]
    myDev     = ["URxvt"]
    myWebs    = ["Chromium-browser"]
    myIgnores = ["desktop","desktop_window","notify-osd","stalonetray","trayer"]

myLayoutHook = avoidStruts . layoutHints $ layoutHook defaultConfig

myKeys :: [(String, X())]
myKeys = [ ("M-p"     , dmenu_launch )
         , ("M-b"     , spawn "chromium" )
         ]

dmenu_launch :: MonadIO m => m ()
dmenu_launch = spawn "dmenu_run -b -i -fn 'Monospace-9'"
