;��Ҫע��ΪĬ��Ӣ�����뷨�ķ���
GroupAdd,en,ahk_exe Xshell.exe
GroupAdd,en,ahk_exe cmd.exe
GroupAdd,en,ahk_exe sh.exe

;��Ҫע��ΪĬ���������뷨�ķ���
;GroupAdd,cn,ahk_exe Notepad++.exe
GroupAdd,cn,ahk_exe RTX.exe
GroupAdd,cn,ahk_exe Wechat.exe
GroupAdd,cn,ahk_exe chrome.exe
GroupAdd,cn,ahk_exe QQ.exe
GroupAdd,cn,ahk_exe Wiz.exe

;ȫ�ֶ��嵱ǰ�����뷨���������ٶ����send�Բ�����Ӱ��
isCurrentEnglish = 0

;����괦����ʾС��ʾ
showTips(var_string)
{
	;��ʽһ��֪ͨ������
	;TrayTip,AHK, %var_string%
	
	;��ʽ��, ���������ʾ
; 	ToolTip, Tips, 10, 10
; 	#Persistent
; 	ToolTip, %var_string%
; 	SetTimer, RemoveTip, 1000
; 	return
; RemoveTip:
; 	SetTimer, RemoveTip, Off
; 	ToolTip
; 	return
	
	;��ʽ������Ļ�м���ʾ
	;SplashTextOn, , , %var_string%
	;Sleep, 1000
	;SplashTextOff
}

;��ȡ��ǰ���뷨״̬
IMEStatusGet() {
	global isCurrentEnglish
	CoordMode Pixel  ; ��������������Ϊ�������Ļ�����ǻ����.
	ImageSearch, FoundX, FoundY, 1400, 800, A_ScreenWidth, A_ScreenHeight, D:\Program Files\AutoHotkey\Chinese.bmp
	if (ErrorLevel = 0) {
		;MsgBox ,"��ǰ���뷨Ϊ����"
		isCurrentEnglish = 0
	} else if (ErrorLevel = 1) {
		isCurrentEnglish = 1
		;MsgBox ,"��ǰ���뷨ΪӢ��"
	} else {
		;isCurrentEnglish = 1
		;MsgBox ,"��ȡ����״̬ʧ��"
		return
	}
}

setChineseLayout(){
	global isCurrentEnglish
	if (isCurrentEnglish == 1) {
		;�����������뷨�л���ݼ��������ʵ��������á�
		SetKeyDelay, 10
		send {Ctrl Down}{Space}
		send {Ctrl Up}
		;CoordMode Mouse, Screen 
		;Send {Click 1504, 881}  
		isCurrentEnglish = 0
		showTips("�Ѿ��Զ��л����������뷨")
	}
}
setEnglishLayout(){
	global isCurrentEnglish
	if (isCurrentEnglish == 0) {
		;����Ӣ�����뷨�л���ݼ��������ʵ��������á�
		SetKeyDelay, 10
		send {Ctrl Down}{Space}
		send {Ctrl Up}
		isCurrentEnglish = 1
		showTips("�Ѿ��Զ��л���Ӣ�����뷨")
	}
}

sendbyclip(var_string) {
	ClipboardOld = %ClipboardAll%
	Clipboard =%var_string%
	sleep 100
	send ^v
	sleep 100
	Clipboard = %ClipboardOld%	; Restore previous contents of clipboard.
}

;�����Ϣ�ص�ShellMessage�����Զ��������뷨
;Gui +LastFound
;hWnd := WinExist()
;DllCall( "RegisterShellHookWindow", UInt,hWnd )
;MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
;OnMessage( MsgNum, "ShellMessage")

ShellMessage( wParam,lParam ) {
	;if (wParam = 1) {
		;WinGetclass, WinClass, ahk_id %lParam%
		;Sleep, 1000
		;MsgBox,%Winclass%
		;WinActivate,ahk_class %Winclass%
		;WinGetActiveTitle, Title
		;MsgBox, The active window is "%Title%".
		
		IfWinActive,ahk_group en
		{
			IMEStatusGet()
			setEnglishLayout()
			return
		}
		
		IfWinActive,ahk_group cn
		{
			IMEStatusGet()
			setChineseLayout()
			return
		}
	;}
}

#h::FileRecycleEmpty

#x::
send,#xa
return

; ����Foxmail������Ѿ������������
#f::
IfWinNotExist  ahk_exe Foxmail.exe
	Run "D:\Program Files\Foxmail 7.2\Foxmail.exe", , Max
Else 
IfWinNotActive  ahk_exe Foxmail.exe
	WinActivate 
Else 
	WinClose ; ʹ��ǰ���ҵ��Ĵ��� 
Return 

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

;����gitBash

#g::
IfWinNotExist  ahk_exe sh.exe
	;Run "D:\Program Files (x86)\Git\bin\sh.exe" --login -i, F:/projects/, Max
	Run "D:\Program Files (x86)\Git\git-bash.exe", F:/projects/, Max
Else 
IfWinNotActive ahk_exe sh.exe
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
		current_path = %clipboard%
		;isDirSvnOrGit(current_path)
		Run "D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:commit /path:"%current_path%" /closeonend:3
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
