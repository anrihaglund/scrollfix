#Requires AutoHotkey v2.0

; Time (ms) with no scroll input before direction resets
suppressTimeout := 200

; 0 = no direction, 1 = up, 2 = down
currentDir := 0

ResetDirection()
{
    global currentDir
    currentDir := 0
}

WheelUp::
{
    global currentDir, suppressTimeout

    if (currentDir = 0 || currentDir = 1)
	{
        currentDir := 1
        Send "{WheelUp}"
        SetTimer ResetDirection, -suppressTimeout
    }
}

WheelDown::
{
    global currentDir, suppressTimeout

    if (currentDir = 0 || currentDir = 2)
	{
        currentDir := 2
        Send "{WheelDown}"
        SetTimer ResetDirection, -suppressTimeout
    }
}
