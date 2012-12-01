import XMonad
import XMonad.Actions.FloatKeys
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.LayoutHints
import XMonad.Util.EZConfig
import XMonad.Util.Run

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
myWorkspaces  = ["1:dev","2:web","3:chat","4:virt"]

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

myDevManageHook :: ManageHook
myDevManageHook = doShift (myWorkspaces !! 0)

myWebManageHook :: ManageHook
myWebManageHook = doShift (myWorkspaces !! 1)

myChatManageHook :: ManageHook
myChatManageHook = doShift (myWorkspaces !! 2)

myVirtManageHook :: ManageHook
myVirtManageHook = doShift (myWorkspaces !! 3) <+> doCenterFloat

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
  [ [resource   =? r  --> doIgnore          | r <- myIgnores]
  , [className  =? c  --> myDevManageHook   | c <- myDevs   ]
  , [className  =? c  --> myWebManageHook   | c <- myWebs   ]
  , [title      =? t  --> myChatManageHook  | t <- myChats  ]
  , [className  =? c  --> myVirtManageHook  | c <- myVirts  ]
  , [className  =? c  --> doCenterFloat     | c <- myFloats ]
  ])
  where
    myFloats  = []
    myDevs    = []
    myWebs    = ["uzbl-core","Uzbl-core"]
    myChats   = ["irssi"]
    myVirts   = ["qemu-system-i386","qemu-system-x86_64","qemu-system-arm"]
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
         , ("M-b"                     , myUzblLaunch )
         , ("M-i"                     , myIrssiLaunch )
         , ("M-q"                     , myRestart )
         , ("M-r"                     , myCenterWindow )
         , ("<XF86MonBrightnessUp>"   , myBrightnessUp )
         , ("<XF86MonBrightnessDown>" , myBrightnessDown )
         ]

myDmenuLaunch :: MonadIO m => m()
myDmenuLaunch = spawn dmenuCmd
  where
    nc = "-nf '" ++ myGray ++ "' -nb '" ++ mySlate ++ "'"
    sc = "-sf '" ++ myBlue ++ "' -sb '" ++ mySlate ++ "'"
    fn = "-fn 'Monospace-8'"
    dmenuCmd = "dmenu_run -b -i " ++ nc ++ " " ++ sc ++ " " ++ fn

myUzblLaunch :: MonadIO m => m ()
myUzblLaunch = spawn "uzbl-browser"

myIrssiLaunch :: X()
myIrssiLaunch = runInTerm "-title irssi" "irssi"

myRestart :: MonadIO m => m()
myRestart = spawn $ killproc ++ " && " ++ xm_recomp ++ " && " ++ xm_reset
  where
    killproc  = "killall conky dzen2"
    xm_recomp = "xmonad --recompile"
    xm_reset  = "xmonad --restart"

myCenterWindow :: X()
myCenterWindow = withFocused $ keysMoveWindowTo (840,525) (1/2,1/2)

myBrScript :: String
myBrScript   = "/home/matt/.xmonad/misc/change_brightness.sh"

myBrightnessUp :: MonadIO m => m()
myBrightnessUp = spawn $ "sudo " ++ myBrScript ++ " up"

myBrightnessDown :: MonadIO m => m()
myBrightnessDown = spawn $ "sudo " ++ myBrScript ++ " down"
