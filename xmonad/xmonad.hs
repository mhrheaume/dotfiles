import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.LayoutHints

main = do
  myWorkspaceBar  <- spawnPipe myWorkspaceBarCmd
  myTopBar        <- spawnPipe myTopBarCmd
  myBottomBar     <- spawnPipe myBottomBarCmd
  xmonad $ myUrgencyHook $ defaultConfig
    { terminal            = myTerminal
    , workspaces          = myWorkspaces
    , manageHook          = myManageHook
    , layoutHook          = myLayoutHook
    , logHook             = myLogHook myWorkspaceBar
    , normalBorderColor   = myColorNormalBorder
    , focusedBorderColor  = myColorFocusedBorder
    , modMask             = mod4Mask
    , borderWidth         = 1
    } `additionalKeysP` myKeys

-----------------------------------------------------------
-- Misc
-----------------------------------------------------------

myConfigRoot = "/home/matt/.xmonad"

-----------------------------------------------------------
-- Applications
-----------------------------------------------------------

myTerminal    = "urxvt -b 0"

-----------------------------------------------------------
-- Appearance
-----------------------------------------------------------

myWhite, mySlate, myGray, myRed, myBlue :: String
myWhite     = "#ffffff"
mySlate     = "#1a1a1a"
myGray      = "#909090"
myDarkGray  = "#404040"
myRed       = "#d51805"
myBlue      = "#3475aa"

myColorNormalBorder, myColorFocusedBorder :: String
myColorNormalBorder   = myDarkGray
myColorFocusedBorder  = myBlue

-----------------------------------------------------------
-- Status Bars
-----------------------------------------------------------

myWorkspaces :: [WorkspaceId]
myWorkspaces  = ["1:dev","2:web","3:chat"]

myUrgencyHook = withUrgencyHook NoUrgencyHook

myWorkspaceBarCmd, myTopBarCmd :: String
myWorkspaceBarCmd  = myConfigRoot ++ "/bars/sb_top_l.sh"
myTopBarCmd        = myConfigRoot ++ "/bars/sb_top_r.sh"
myBottomBarCmd     = myConfigRoot ++ "/bars/sb_bottom.sh" 

myLogHook h = dynamicLogWithPP $ defaultPP
  { ppCurrent         = dzenColor myBlue  "" . pad
  , ppHidden          = dzenColor myWhite "" . pad
  , ppHiddenNoWindows = dzenColor myGray  "" . pad
  , ppLayout          = dzenColor myGray  "" . pad
  , ppUrgent          = dzenColor myRed   "" . pad . dzenStrip
  , ppTitle           = shorten 100
  , ppWsSep           = ""
  , ppSep             = " | "
  , ppOutput          = hPutStrLn h
  }

-----------------------------------------------------------
-- ManageHook
-----------------------------------------------------------

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
  [ [resource   =? r  --> doIgnore                    | r <- myIgnores]
  , [className  =? c  --> doShift (myWorkspaces !! 0) | c <- myDev    ]
  , [className  =? c  --> doShift (myWorkspaces !! 1) | c <- myWebs   ]
  , [className  =? c  --> doCenterFloat               | c <- myFloats ]
  ])
  where
    myFloats  = []
    myWebs    = []
    myDev     = []
    myIgnores = ["desktop","desktop_window","notify-osd","stalonetray","trayer"]

-----------------------------------------------------------
-- LayoutHook
-----------------------------------------------------------

myLayoutHook = avoidStruts . layoutHints $ layoutHook defaultConfig

-----------------------------------------------------------
-- KeyBindings
-----------------------------------------------------------

myKeys :: [(String, X())]
myKeys = [ ("M-p"                     , myDmenuLaunch )
         , ("M-q"                     , myRestart )
         , ("<XF86MonBrightnessUp>"   , myBrightnessUp )
         , ("<XF86MonBrightnessDown>" , myBrightnessDown )
         ]

myDmenuLaunch :: MonadIO m => m ()
myDmenuLaunch = spawn dmenuCmd
  where
    nc = "-nf '" ++ myGray ++ "' -nb '" ++ mySlate ++ "'"
    sc = "-sf '" ++ myBlue ++ "' -sb '" ++ mySlate ++ "'"
    fn = "-fn 'Monospace-8'"
    dmenuCmd = "dmenu_run -b -i " ++ nc ++ " " ++ sc ++ " " ++ fn

myRestart :: MonadIO m => m ()
myRestart = spawn $ killproc ++ " && " ++ xm_recomp ++ " && " ++ xm_reset
  where
    killproc  = "killall conky dzen2"
    xm_recomp = "xmonad --recompile"
    xm_reset  = "xmonad --restart"

myBrScript   = "/home/matt/.xmonad/misc/change_brightness.sh"

myBrightnessUp :: MonadIO m => m ()
myBrightnessUp = spawn $ "sudo " ++ myBrScript ++ " up"

myBrightnessDown :: MonadIO m => m ()
myBrightnessDown = spawn $ "sudo " ++ myBrScript ++ " down"
