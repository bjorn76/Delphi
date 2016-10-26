unit lmdconst;

interface

resourcestring
 IDS_PATH='����:';
 IDS_ON='���';
 IDS_OFF='����';

 //ButtonBar
 IDS_ADDSECTION='�&������� ������';
 IDS_DELSECTION='��&����� ������';
 IDS_RENSECTION='�&������������ ������';
 IDS_ADDITEM='&�������� �������';
 IDS_DELITEM='&������� �������';
 IDS_RENITEM='&������������� �������';
 IDS_SMALLICONS='&��������� ������';
 IDS_LARGEICONS='&������� ������';

 //EditControls
 IDS_INSERT='&��������';
 IDS_COPY='&����������';
 IDS_CUT='���&�����';
 IDS_UNDO='&��������';
 IDS_SELECTALL='�������� ���';
 IDS_DELETE='&�������';
 IDS_SEARCH='�����';
 IDS_SEARCHMSG1='������ ... ��������� � �����?';
 IDS_SEARCHMSG2='����� ... ��������� �������?';
 IDS_REPLACE='��������';
 IDS_WORDWRAP='������� ������';
 IDS_LINED='������������';
 IDS_REDO='�������';
 IDS_FONT='�����';
 IDS_CLEAR='��������';
 IDS_ALIGNLEFT='����� ������������';
 IDS_ALIGNRIGHT='������ ������������';
 IDS_ALIGNCENTER='�� ������';
 IDS_STATISTICS='���������� ������';
 IDS_OPEN='�������';
 IDS_SAVE='���������';
 IDS_PRINT='������';
 IDS_PAGE='��������';

 // Component Messages
 IDS_MUSTSHOWONE='������ ���� ������ ���� �� ���� �����!';
 IDS_INVALIDOWNER='�������� ������ (<>TForm) ��� �� ����� ������ ���������';
 IDS_INTERVALNOTFIT='������������ �������� � �������� MinInterval!';

 // TLMDAssist
 IDS_NEXT='&����� >';
 IDS_BACK='< &�����';
 IDS_FINISH='&������';
 IDS_HELP='&������';
 IDS_CLOSE='&�������';
 IDS_CANCEL='������';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = '��� �������� ������ �� �������� � LMD-Tools!';

 // TLMDMRUList
 IDS_CLEARLIST = '�������� ������...';
 IDS_CLEARLISTHINT = '�������� ������ ��������� ������';
 IDS_CLEARLISTREQUEST = '�� ������������� ������ �������� ������ ��������� ������?';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='���������� ��� ��������...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='���������� ';
 IDS_AboutAvailMemory='��������� ������:';
 IDS_AboutSysRes='��������� �������:';
 IDS_AboutCompatible='��� �����������';
 IDS_AboutPlatform='���������, ���������:';
 IDS_FREE='��������';

 {TLMDDirDlg}
 IDS_DIRCAPTION='����� ��������...';
 IDS_DIRDRIVE='&����:';
 IDS_DIRPATH='&����:';
 IDS_NEWPATH='&����� �������';

 {TLMDTipDlg}
 IDS_TIPERROR='������ �� �������� - �� ��������� �������� Tips...';
 IDS_SHOWATSTART='���������� ��� ������ ������� ���������';
 IDS_TIPNEXT='&�������� �����';
 IDS_TIPPREV='&���������� �����';

 {TLMDWindowList}
 IDS_WLCAPTION='������ ����...';
 IDS_WLDESC='��������� &����:';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='���������...';
 IDS_ACTUALDATE='�������� ����';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='������ �� ���������� ��� ���������';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='����...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='��������� ��������';

 // LMDSYSIN
 // ****************************************************************************
 IDS_FILE='�����';
 IDS_NOROOTDIR='��� �������� ����������';
 IDS_REMOVABLE='�������';
 IDS_FIXEDDRIVE='������� ����';
 IDS_REMOTE='��������� (�������) �����';
 IDS_CDROM='CD-ROM';
 IDS_RAMDISK='����������� ����';
 IDS_USERNAME='Username';
 IDS_WINDOWSDIR='������� Windows';
 IDS_CURRDIR='������� �������';
 IDS_FREESPACE='��������� ������������ �� ������� �����';
 IDS_DISKSIZE='����� �������� �����';
 IDS_SYSTEMDIR='��������� ����������';
 IDS_REGISTEREDOWNER='������������������ ������������';
 IDS_REGISTEREDCOMPANY='������������������ ��������';
 IDS_VERSION='������';
 IDS_COLORDEPTH='���������� (� �����)';
 IDS_SCREENSAVERDELAY='����� ������� ��� ������� ��������� ������';
 IDS_MEMORYSIZE='������ ������';
 IDS_FREESYSTEMRESOURCES='��������� ��������� �������';
 IDS_FREEGDIRES='��������� ������� GDI';
 IDS_FREEUSERRES='��������� ������� ������������';
 IDS_COMPUTERNAME='��� ����������';
 IDS_MAJORVERSION='�������� ������';
 IDS_BUILD='������';
 IDS_MEMORYLOADED='����������� ������';
 IDS_MEMORYFREE='��������� ������';
 IDS_MEMORYFREEPAGES='��������� ������� ������';
 IDS_MEMORYTOTALPAGES='����� ������� ������';
 IDS_MEMORYVIRTUALFREE='��������� ����������� ������';
 IDS_MEMORYVIRTUALTOTAL='����� ����������� ������';
 IDS_PLATFORMID='ID ���������';
 IDS_PLATFORM='���������';
 IDS_PROCESSORNUMBER='���������� �����������';
 IDS_PROCESSOR='���������';
 IDS_TEMPPATH='��������� ����������';
 IDS_DOSVERSION='������ DOS';
 IDS_NUMLOCK='NumLock';
 IDS_CAPSLOCK='CapsLock';
 IDS_SCROLL='ScrollLock';
 IDS_DATETIME='���� � �����';
 IDS_COMPANYNAME='��� ��������';
 IDS_PRODUCTNAME='�������� ��������';
 IDS_PRODUCTVERSION='������ ��������';
 IDS_LEGALCOPYRIGHT='�������������� ����';
 IDS_TRADEMARK='������������������ �������� �����';
 IDS_FILEDESCRIPTION='�������� �����';
 IDS_COMMENTS='�����������';
 IDS_CPUSPEED='�������� ����������';


implementation

end.
