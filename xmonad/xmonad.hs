import XMonad
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.LayoutHints
import XMonad.Util.EZConfig

main = do
  myWorkspaceBar  <- spawnPipe myWorkspaceBarCmd
  myTopBar        <- spawnPipe myTopBarCmd
  -- myBottomBar     <- spawnPipe myBottomBarCmd
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
-- Applications
-----------------------------------------------------------

myTerminal    = "urxvt -b 0"

-----------------------------------------------------------
-- Appearance
-----------------------------------------------------------

myWhite, mySlate, myGray, myRed, myBlue : String
myWhite   = "#ffffff"
mySlate   = "#1a1a1a"
myGray    = "#909090"
myRed     = "#d51805"
myBlue    = "#3475aa"

myColorNormalBorder, myColorFocusedBorder : String
myColorNormalBorder   = mySlate
myColorFocusedBorder  = myGray

-----------------------------------------------------------
-- Status Bars
-----------------------------------------------------------

myWorkspaces :: [WorkspaceId]
myWorkspaces  = ["1:dev","2:web","3:chat"]

myUrgencyHook = withUrgencyHook NoUrgencyHook

myWorkspaceBarCmd, myTopBarCmd :: String
myWorkspaceBarCmd  = "dzen2 -p -x 0 -y 0 -w 960 -h 24 -ta l -fg '" ++ myWhite ++ "' -bg '" ++ mySlate ++ "' -fn 'Monospace-8'"
myTopBarCmd        = "/home/matt/.xmonad/bars/sb_top.sh"
-- myBottomBarCmd     = "/home/matt/.xmonad/bars/sb_bottom.sh"

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
myKeys = [ ("M-p"     , myDmenuLaunch )
         , ("M-q"     , myRestart )
         ]

myDmenuLaunch :: MonadIO m => m ()
myDmenuLaunch = spawn dmenuCmd
  where
    nc = "-nf '" ++ myGray ++ "' -nb '" ++ mySlate
    sc = "-sf '" ++ myBlue ++ "' -sb '" ++ mySlate
    fn = "-fn 'Monospace-8'"
    dmenuCmd = "dmenu_run -b -i " ++ nc ++ " " ++ sc ++ " " ++ fn

myRestart :: MonadIO m => m ()
myRestart = spawn "killall conky dzen2 && xmonad --recompile && xmonad --restart"
