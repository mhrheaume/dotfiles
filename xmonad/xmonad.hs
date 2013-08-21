import XMonad
import XMonad.Actions.FloatKeys
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.BoringWindows
import XMonad.Layout.LayoutHints
import XMonad.Layout.Minimize
import XMonad.Layout.Maximize
import XMonad.Layout.Named
import XMonad.Layout.ResizableTile
import XMonad.Util.EZConfig
import XMonad.Util.Run

import Graphics.X11.ExtraTypes.XF86
import System.Exit;

import qualified XMonad.StackSet as W
import qualified Data.Map as M

main = do
	myWorkspaceBar <- spawnPipe myWorkspaceBarCmd
	myTopBar <- spawnPipe myTopBarCmd
	-- myBottomBar <- spawnPipe myBottomBarCmd
	xmonad $ myUrgencyHook $ defaultConfig
		{ terminal            = myTerminal
		, workspaces          = myWorkspaces
		, manageHook          = myManageHook
		, layoutHook          = myLayoutHook
		, logHook             = myLogHook myWorkspaceBar
		, normalBorderColor   = myColorNormalBorder
		, focusedBorderColor  = myColorFocusedBorder
		, modMask             = mod4Mask
		, keys                = myKeys
		, borderWidth         = 1
		}

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

myWhite, mySlate, myGray, myDarkGray, myRed, myBlue :: String
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

myIconDir :: String
myIconDir = myConfigRoot ++ "/icons"

myWorkspaces :: [WorkspaceId]
myWorkspaces  =
	[ "^i(" ++ myIconDir ++ "/term.xbm) code[0]"
	, "^i(" ++ myIconDir ++ "/term.xbm) code[1]"
	, "^i(" ++ myIconDir ++ "/google-chrome.xbm) web"
	, "^i(" ++ myIconDir ++ "/misc.xbm) chat"
	, "^i(" ++ myIconDir ++ "/cpu.xbm) virt"
	, "^i(" ++ myIconDir ++ "/docs.xbm) pdf"
	, "^i(" ++ myIconDir ++ "/phones.xbm) music"
	]

myUrgencyHook = withUrgencyHook NoUrgencyHook

myWorkspaceBarCmd, myTopBarCmd, myBottomBarCmd :: String
myWorkspaceBarCmd  = myConfigRoot ++ "/bars/sb_top_l.sh"
myTopBarCmd        = myConfigRoot ++ "/bars/sb_top_r.sh"
myBottomBarCmd     = myConfigRoot ++ "/bars/sb_bottom.sh" 

myLogHook h = dynamicLogWithPP $ defaultPP
	{ ppCurrent         = dzenColor myWhite  "" . pad
	, ppHidden          = dzenColor myBlue "" . pad
	, ppHiddenNoWindows = dzenColor myGray  "" . pad
	, ppUrgent          = dzenColor myRed   "" . pad . dzenStrip
	, ppTitle           = shorten 100
	, ppWsSep           = ""
	, ppSep             = dzenColor myBlue "" " | "
	, ppOutput          = hPutStrLn h
	, ppLayout          = dzenColor myWhite "" .
		(\l -> case (rmWord $ rmWord l) of
			"ResizableTall"   -> "^i(" ++ tallIcon ++ ")"
			"ResizableMirror" -> "^i(" ++ mirrorIcon ++ ")"
		)
	}
	where
		rmWord = tail . dropWhile (/= ' ')
		tallIcon = myIconDir ++ "/layout_tall.xbm"
		mirrorIcon = myIconDir ++ "/layout_mirror_tall.xbm"

-----------------------------------------------------------
-- ManageHook
-----------------------------------------------------------

myWebManageHook :: ManageHook
myWebManageHook = doShift (myWorkspaces !! 2)

myChatManageHook :: ManageHook
myChatManageHook = doShift (myWorkspaces !! 3)

myVirtManageHook :: ManageHook
myVirtManageHook = doShift (myWorkspaces !! 4) <+> doCenterFloat

myPdfManageHook :: ManageHook
myPdfManageHook = doShift (myWorkspaces !! 5)

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
	[ [resource   =? r  --> doIgnore          | r <- myIgnores]
	, [className  =? c  --> myWebManageHook   | c <- myWebs   ]
	, [title      =? t  --> myChatManageHook  | t <- myChats  ]
	, [className  =? c  --> myVirtManageHook  | c <- myVirts  ]
	, [className  =? c  --> myPdfManageHook   | c <- myPdfs   ]
	, [className  =? c  --> doCenterFloat     | c <- myFloats ]
	])
	where
		myFloats  = ["feh"]
		myWebs    = ["luakit"]
		myChats   = ["irssi"]
		myVirts   = ["qemu-system-x86_64","qemu-system-arm"]
		myPdfs    = ["apvlv"]
		myIgnores = ["desktop","desktop_window"]

-----------------------------------------------------------
-- LayoutHook
-----------------------------------------------------------

myTile = named "ResizableTall" $ ResizableTall 1 0.03 0.5 []
myMirror = named "ResizableMirror" $ Mirror myTile

myLayoutHook = avoidStruts
	$ minimize
	$ maximize
	$ boringWindows
	$ allLayouts
	where
		allLayouts = myTile ||| myMirror

-----------------------------------------------------------
-- KeyBindings
-----------------------------------------------------------

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
	-- XMonad
	[ ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess))
	, ((modMask, xK_q), myRestart)
	, ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
	-- Window Management
	, ((modMask .|. shiftMask, xK_c), kill)
	, ((modMask, xK_j), focusDown)
	, ((modMask, xK_k), focusUp)
	, ((modMask, xK_a), focusMaster)
	, ((modMask .|. shiftMask, xK_j), windows W.swapDown)
	, ((modMask .|. shiftMask, xK_k), windows W.swapUp)
	, ((modMask .|. shiftMask, xK_a), windows W.swapMaster)
	, ((modMask, xK_Return), windows W.swapMaster)
	, ((modMask, xK_comma), sendMessage (IncMasterN 1))
	, ((modMask, xK_period), sendMessage (IncMasterN (-1)))
	, ((modMask, xK_h), sendMessage Shrink)
	, ((modMask, xK_l), sendMessage Expand)
	, ((modMask .|. shiftMask, xK_h), sendMessage MirrorShrink)
	, ((modMask .|. shiftMask, xK_l), sendMessage MirrorExpand)
	, ((modMask, xK_m), withFocused minimizeWindow)
	, ((modMask .|. shiftMask, xK_m), sendMessage RestoreNextMinimizedWin)
	, ((modMask, xK_backslash), withFocused (sendMessage . maximizeRestore))
	, ((modMask, xK_t), withFocused $ windows . W.sink)
	-- Layout
	, ((modMask, xK_space), sendMessage NextLayout)
	-- Scripts / Launchers
	, ((modMask, xK_p), myDmenuLaunch)
	, ((modMask, xK_i), runInTerm "-title irssi" "irssi")
	, ((modMask, xK_b), spawn "luakit")
	, ((modMask .|. shiftMask, xK_equal), spawn "amixer set Master 2+")
	, ((modMask, xK_equal), spawn "amixer set Master 2-")
	, ((modMask, xK_minus), spawn "mpc toggle")
	, ((modMask .|. shiftMask, xK_comma), spawn "mpc prev")
	, ((modMask .|. shiftMask, xK_period), spawn "mpc next")
	, ((0, xF86XK_MonBrightnessUp), spawn "sudo /usr/local/bin/xbbar")
	, ((0, xF86XK_MonBrightnessDown), spawn "sudo /usr/local/bin/xbbar")
	]
	++
	-- mod-[1..9] Switch to workspace N
	-- mod-shift-[1..9] Move client to workspace N
	[((m .|. modMask, k), windows $ f i)
		| (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9])
		, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
	++
	-- mod-[w,e,r] Switch screens
	-- mod-shift-[w,e,r] Move client to screen
	[((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
		| (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
		, (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myDmenuLaunch :: MonadIO m => m()
myDmenuLaunch = spawn dmenuCmd
	where
		nc = "-nf '" ++ myGray ++ "' -nb '" ++ mySlate ++ "'"
		sc = "-sf '" ++ myBlue ++ "' -sb '" ++ mySlate ++ "'"
		fn = "-fn 'Monospace-8'"
		dmenuCmd = "dmenu_run -b -i " ++ nc ++ " " ++ sc ++ " " ++ fn

myRestart :: MonadIO m => m()
myRestart = spawn $ killproc ++ "; " ++ xm_recomp ++ " && " ++ xm_reset
	where
		killproc  = "killall conky dzen2"
		xm_recomp = "xmonad --recompile"
		xm_reset  = "xmonad --restart"
