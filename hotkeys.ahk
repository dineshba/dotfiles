#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#NoEnv ; recommended for performance and compatibility with future autohotkey releases.
#UseHook
#InstallKeybdHook
#SingleInstance force

SendMode Input

;; deactivate capslock completely
SetCapslockState, AlwaysOff

;; remap capslock to hyper
;; if capslock is toggled, remap it to esc

;; note: must use tidle prefix to fire hotkey once it is pressed
;; not until the hotkey is released
; ~Capslock::
;     ;; must use downtemp to emulate hyper key, you cannot use down in this case
;     ;; according to https://autohotkey.com/docs/commands/Send.htm, downtemp is as same as down except for ctrl/alt/shift/win keys
;     ;; in those cases, downtemp tells subsequent sends that the key is not permanently down, and may be
;     ;; released whenever a keystroke calls for it.
;     ;; for example, Send {Ctrl Downtemp} followed later by Send {Left} would produce a normal {Left}
;     ;; keystroke, not a Ctrl{Left} keystroke
;     Send {Ctrl DownTemp}{Shift DownTemp}{Alt DownTemp}{LWin DownTemp}
;     KeyWait, Capslock
;     Send {Ctrl Up}{Shift Up}{Alt Up}{LWin Up}
;     if (A_PriorKey = "Capslock") {
;         Send {Esc}
;     }
; return

;; vim navigation with hyper
~Capslock & h:: Send {Left}
~Capslock & l:: Send {Right}
~Capslock & k:: Send {Up}
~Capslock & j:: Send {Down}

;; popular hotkeys with hyper
;; not needed for me
;; ~Capslock & c:: Send ^{c}
;; ~Capslock & v:: Send ^{v}

~Capslock & r::Reload

~CapsLock & b::
IfWinExist, ahk_exe msedge.exe
{
    ; F3::
    WinActivate, % ppt := "ahk_exe msedge.exe"
    WinMaximize, %ppt%
    return
}
else
{
    Run, "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    return
}

~CapsLock & c::
IfWinExist, ahk_exe Code.exe
{
    ; F3::
    WinActivate, % ppt := "ahk_exe Code.exe"
    WinMaximize, %ppt%
    return
}
else
{
    Run, "C:\Users\dineshba\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    return
}

~CapsLock & t::
IfWinExist, ahk_exe Teams.exe
{
    ; F3::
    WinActivate, % ppt := "ahk_exe Teams.exe"
    WinMaximize, %ppt%
    return
}
else
{
    Run, "C:\Users\dineshba\AppData\Local\Microsoft\Teams\current\Teams.exe"
    return
}


~CapsLock & o::
IfWinExist, ahk_exe OUTLOOK.EXE
{
    ; F3::
    WinActivate, % ppt := "ahk_exe OUTLOOK.EXE"
    WinMaximize, %ppt%
    return
}
else
{
    Run, "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
    return
}


~CapsLock & n::
IfWinExist, ahk_exe Notable.EXE
{
    ; F3::
    WinActivate, % ppt := "ahk_exe Notable.EXE"
    WinMaximize, %ppt%
    return
}
else
{
    Run, "C:\Users\dineshba\AppData\Local\Programs\notable\Notable.exe"
    return
}

~CapsLock & x::
IfWinExist, ahk_exe EXCEL.EXE
{
    ; F3::
    WinActivate, % ppt := "ahk_exe EXCEL.EXE"
    WinMaximize, %ppt%
    return
}
else
{
    Run, "C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
    return
}

~CapsLock & space::ToggleAlacrittyVisibility("ahk_exe Alacritty.exe")

ToggleAlacrittyVisibility(windowClass) {
  DetectHiddenWindows, on

	IfWinExist, %windowClass%
	{
		IfWinActive, %windowClass%
		{
			WinHide, %windowClass%
			WinActivate ahk_class Shell_TrayWnd
		}
		else
		{
			WinShow, %windowClass%
			WinActivate, %windowClass%
		}
	}
    else {
        Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Alacritty.exe"
        Sleep, 1000
        Send {t 2}
        Send {Enter}
        WinMaximize, A
    }
	DetectHiddenWindows, off
}

~CapsLock & a:: ToggleTerminal()

ShowAndPositionTerminal()
{
    WinShow ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    WinActivate ahk_class CASCADIA_HOSTING_WINDOW_CLASS

    ; SysGet, WorkArea ss CASCADIA_HOSTING_WINDOW_CLASS,, (A_ScreenWidth - TerminalWidth) / 2, WorkAreaTop - 2, TerminalWidth, A_ScreenHeight * 0.5,
}

ToggleTerminal()
{
    WinMatcher := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"

    DetectHiddenWindows, On

    if WinExist(WinMatcher)
    ; Window Exists
    {
        DetectHiddenWindows, Off

        ; Check if its hidden
        if !WinExist(WinMatcher) || !WinActive(WinMatcher)
        {
            ShowAndPositionTerminal()
        }
        else if WinExist(WinMatcher)
        {
            ; Script sees it without detecting hidden windows, so..
            WinHide ahk_class CASCADIA_HOSTING_WINDOW_CLASS
            Send !{Esc}
        }
    }
    else
    {
        Run "C:\Users\dineshba\AppData\Local\Microsoft\WindowsApps\wt.exe"
        Sleep, 1000
        ShowAndPositionTerminal()
        Sleep, 2000
        Send {t 2}
        Send {Enter}
    }
}

~CapsLock & Left::Home
~CapsLock & Right::End


;Moves the active window from one monitor to the other. Similar to JumpWin.exe, but that stopped working for me for some reason.
;Based on Thalon's code at http://www.autohotkey.com/forum/topic19440.html  [Jon Aquino 2008-09-17]

leftMonitorWidth = 1400
leftMonitorHeight = 1050
rightMonitorWidth = 1920
rightMonitorHeight = 1200

~CapsLock & m::    ;Default hotkey is Ctrl+Alt+Q
activeWindow := WinActive("A")
if activeWindow = 0
{
    return
}
WinGet, minMax, MinMax, ahk_id %activeWindow%
if minMax = 1
{
    WinRestore, ahk_id %activeWindow%
}
WinGetPos, x, y, width, height, ahk_id %activeWindow%
if x < 0
{
    xScale := rightMonitorWidth / leftMonitorWidth
    yScale := rightMonitorHeight / leftMonitorHeight
    x := leftMonitorWidth + x
    newX := x * xScale
    newY := y * yScale
    newWidth := width * xScale
    newHeight := height * yScale
}
else
{
    xScale := leftMonitorWidth / rightMonitorWidth
    yScale := leftMonitorHeight / rightMonitorHeight
    newX := x * xScale
    newY := y * yScale
    newWidth := width * xScale
    newHeight := height * yScale
    newX := newX - leftMonitorWidth
}
WinMove, ahk_id %activeWindow%, , %newX%, %newY%, %newWidth%, %newHeight%
if minMax = 1
{
    WinMaximize, ahk_id %activeWindow%
}
WinActivate ahk_id %activeWindow%   ;Needed - otherwise another window may overlap it
return
