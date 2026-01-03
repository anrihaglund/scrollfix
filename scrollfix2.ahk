#Requires AutoHotkey v2.0

scrollDir := 0            ; 1 = up, 2 = down
lastScroll := 0
scrollTimer := false

lockTime := 300           ; ms before direction can change
gapTimeout := 100         ; ms before scrolling stops

ScrollTick() {
    global scrollDir, lastScroll, scrollTimer

    if (A_TickCount - lastScroll > gapTimeout)
	{
        scrollDir := 0
        scrollTimer := false
        return
    }

    if (scrollDir = 1)
        Send "{WheelUp}"
    else if (scrollDir = 2)
        Send "{WheelDown}"
}

HandleScroll(dir)
{
    global scrollDir, lastScroll, scrollTimer

    now := A_TickCount

    if (scrollDir != 0 && dir != scrollDir)
	{
        if (now - lastScroll < lockTime)
            return
    }

    scrollDir := dir
    lastScroll := now

    if (dir = 1)
        Send "{WheelUp}"
    else
        Send "{WheelDown}"

    if (!scrollTimer)
	{
        scrollTimer := true
        SetTimer ScrollTick, 35
    }
}

WheelUp::HandleScroll(1)
WheelDown::HandleScroll(2)
