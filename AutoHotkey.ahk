;��Ҫע��ΪĬ��Ӣ�����뷨�ķ���
GroupAdd,en,ahk_exe Xshell.exe

;��Ҫע��ΪĬ���������뷨�ķ���
GroupAdd,cn,ahk_exe Notepad++.exe
GroupAdd,cn,ahk_exe RTX.exe
GroupAdd,cn,ahk_exe Wechat.exe

setChineseLayout(){
	;�����������뷨�л���ݼ��������ʵ��������á�
	send {Ctrl Down}{Shift Down}{2}
	send {Ctrl Up}{Shift Up}
}
setEnglishLayout(){
	;����Ӣ�����뷨�л���ݼ��������ʵ��������á�
	send {Ctrl Down}{Shift Down}{3}
	send {Ctrl Up}{Shift Up}
}

sendbyclip(var_string)
{
	ClipboardOld = %ClipboardAll%
	Clipboard =%var_string%
	sleep 100
	send ^v
	sleep 100
	Clipboard = %ClipboardOld%	; Restore previous contents of clipboard.
}

;�����Ϣ�ص�ShellMessage�����Զ��������뷨
Gui +LastFound
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage")

ShellMessage( wParam,lParam ) {
	WinGetclass, WinClass, ahk_id %lParam%
	;Sleep, 500
	;MsgBox,%Winclass%
	WinActivate,ahk_class %Winclass%
	;WinGetActiveTitle, Title
	;MsgBox, The active window is "%Title%".
	IfWinActive,ahk_group en
	{
		setEnglishLayout()
		;TrayTip,AHK, ���Զ��л���Ӣ�����뷨
		return
	}
	
	IfWinActive,ahk_group cn
	{
		setChineseLayout()
		;TrayTip,AHK, ���Զ��л���Ӣ�����뷨
		return
	}
}

#h::FileRecycleEmpty

#x::
send,#xa
return

; ����tc������Ѿ������������
#t::
IfWinNotExist  ahk_class TTOTAL_CMD, 
	Run "D:\Program Files\TotalCMD64\Totalcmd64.exe", , Max
Else 
IfWinNotActive ahk_class TTOTAL_CMD, 
	WinActivate 
Else 
	WinMinimize 
Return 

; ����Ϊ֪�ʼǣ�����Ѿ������������
#w::
IfWinNotExist  ahk_class WizNoteMainFrame
	Run "D:\Program Files (x86)\WizNote\Wiz.exe", , Max
Else 
IfWinNotActive ahk_class WizNoteMainFrame
	WinActivate 
Else 
	WinMinimize 
Return 

; ���������������Ѿ������������
#b::
IfWinNotExist  ahk_class Chrome_WidgetWin_1
	Run "D:\Chrome\MyChrome.exe", , Max
Else 
IfWinNotActive ahk_class Chrome_WidgetWin_1
	WinActivate 
Else 
	WinMinimize 
Return 

; ����source insight������Ѿ������������
#s::
IfWinNotExist ahk_class si_Frame 
	Run "D:\Program Files (x86)\Source Insight 3\Insight3.Exe"
Else 
IfWinNotActive ahk_class si_Frame 
	WinActivate 
Else 
	WinMinimize 
Return 

; ����outlook������Ѿ������������
#o::
IfWinNotExist ahk_exe OUTLOOK.EXE
	Run "D:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE", , Max
Else 
IfWinNotActive ahk_exe OUTLOOK.EXE
	WinActivate 
Else 
	WinMinimize 
Return

#n::Run Notepad++
return 

:://g:: 
Run http://www.google.com 
return 

:://b:: 
Run http://www.baidu.com 
return 


; SVN�ύ
#c::
if WinActive("Total Commander")
{
	try {
		Send {F12}
		Run "D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:commit /path:"%clipboard%" /closeonend:3
	} catch {
		return
	}
	
	WinWait ,,Commit, 
	WinActivate 
}
Else
IfWinActive ahk_class CabinetWClass
{
   WinGetActiveTitle, pth
   cmd = D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe /command:commit /path:"%pth%" /logmsg:"Autoversioning commit" /notempfile /closeonend:3
   run, %cmd%, %pth%
}
Return

;ahk_class #32770
;ahk_exe TortoiseProc.exe
; SVN����
#u::
if WinActive("Total Commander")
{
	try {
		Send {F12}
		Run "D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:update /path:"%clipboard%" /closeonend:3
	} catch {
		return
	}
	;WinWaitActive	,,Update, 5
	;WinActivate 
}
Else
IfWinActive ahk_class CabinetWClass
{
   WinGetActiveTitle, pth
   cmd = D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe /command:update /path:"%pth%" /closeonend:3
   run, %cmd%, %pth%
}
Return

Shift::
return

+Space::
return

#m::
IfWinNotExist  ahk_class WinMergeWindowClassW
	Run "D:\Program Files (x86)\WinMerge\WinMergeU.exe"
Else 
IfWinNotActive ahk_class WinMergeWindowClassW
	WinActivate 
Else 
	WinMinimize 
Return 
