unit LMDConst;
{$I lmdcmps.inc}
{
  ##############################################################################
  # Author: LMD Innovative (--)
  # Created: 1996
  # Description: Unit containing resource strings used by the components
  # State: release
  # Comments: already available in several other languages!
  #---------------------------------- CHANGES ----------------------------------
  # Author:		RM
  # Date:		23-Jan-2003
  # Description:	+ IDS_SELECTOPTIONS
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}
interface

resourcestring
 IDS_PATH='Path:';
 IDS_ON='On';
 IDS_OFF='Off';

 // TLMDCheckListBoxDlg
 IDS_SELECT='Select...';
 IDS_SELECTOPTIONS='Select desired option(s)...';

 //ButtonBar
 IDS_ADDSECTION='Add Sect&ion';
 IDS_DELSECTION='D&elete Section';
 IDS_RENSECTION='Re&name Section';
 IDS_ADDITEM='&Add Item';
 IDS_DELITEM='&Delete Item';
 IDS_RENITEM='&Rename Item';
 IDS_SMALLICONS='&Small icons';
 IDS_LARGEICONS='&Large icons';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Calendar...';
 IDS_ACTUALDATE='Today';

 //EditControls
 IDS_INSERT='&Paste';
 IDS_COPY='&Copy';
 IDS_CUT='&Cut';
 IDS_UNDO='&Undo';
 IDS_SELECTALL='Select all';
 IDS_DELETE='&Delete';
 IDS_SEARCH='Search';
 IDS_SEARCHMSG1='At top ... restart from bottom?';
 IDS_SEARCHMSG2='At bottom ... restart from top?';
 IDS_REPLACE='Replace';
 IDS_WORDWRAP='Wordwrap';
 IDS_LINED='Lined';
 IDS_REDO='Redo';
 IDS_FONT='Font';
 IDS_CLEAR='Clear';
 IDS_ALIGNLEFT='Align left';
 IDS_ALIGNRIGHT='Align right';
 IDS_ALIGNCENTER='Center';
 IDS_STATISTICS='Text statistics';
 IDS_OPEN='Open';
 IDS_SAVE='Save';
 IDS_PRINT='Print';
 IDS_PAGE='Page';
 IDS_EDIT='Edit';

 // Component Messages
 IDS_MUSTSHOWONE='One clock style must be active!';
 IDS_INVALIDOWNER='Invalid owner (<>TForm) or second instance on a form';
 IDS_INTERVALNOTFIT='Interval not compatible with MinInterval property!';

 // TLMDAssist
 IDS_NEXT='Ne&xt >';
 IDS_BACK='< &Back';
 IDS_FINISH='&Finish';
 IDS_HELP='&Help';
 IDS_CLOSE='&Close';
 IDS_CANCEL='Cancel';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'This property is no longer used in LMD-Tools!';

 // TLMDMRUList
 IDS_CLEARLIST = 'Clear List...';
 IDS_CLEARLISTHINT = 'Clear recent files list';
 IDS_CLEARLISTREQUEST = 'Really clear recent files list?';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='was already started...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Info ';
 IDS_AboutAvailMemory='Available Memory:';
 IDS_AboutSysRes='System Resources:';
 IDS_AboutCompatible='or compatible';
 IDS_AboutPlatform='Platform, CPU:';
 IDS_FREE='free';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Select Path...';
 IDS_DIRDRIVE='&Drive:';
 IDS_DIRPATH='&Path:';
 IDS_NEWPATH='&New Folder';

 {TLMDTipDlg}
 IDS_TIPERROR='No Items available - Dialog will not be displayed...';
 IDS_SHOWATSTART='Show tips at every start';
 IDS_TIPNEXT='&Next Tip';
 IDS_TIPPREV='&Previous Tip';

 {TLMDWindowList}
 IDS_WLCAPTION='Windowlist...';
 IDS_WLDESC='Available &Windows:';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Don''t show again';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Input...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Text Editor';

 // LMDSYSIN
 // ****************************************************************************
 IDS_FILE='Files';
 IDS_NOROOTDIR='no root directory';
 IDS_REMOVABLE='removable';
 IDS_FIXEDDRIVE='fixed drive';
 IDS_REMOTE='remote (network) drive';
 IDS_CDROM='CD-ROM';
 IDS_RAMDISK='ramdisk';
 IDS_USERNAME='Username';
 IDS_WINDOWSDIR='Windows directory';
 IDS_CURRDIR='Current directory';
 IDS_FREESPACE='Free space on current disk';
 IDS_DISKSIZE='Disk size of current Disk';
 IDS_SYSTEMDIR='System directory';
 IDS_REGISTEREDOWNER='Registered owner';
 IDS_REGISTEREDCOMPANY='Registered company';
 IDS_VERSION='Version';
 IDS_COLORDEPTH='Colordepth (in bits)';
 IDS_SCREENSAVERDELAY='Screensaver delay';
 IDS_MEMORYSIZE='Memory size';
 IDS_FREESYSTEMRESOURCES='Free system resources';
 IDS_FREEGDIRES='Free GDI resources';
 IDS_FREEUSERRES='Free user resources';
 IDS_COMPUTERNAME='Computername';
 IDS_MAJORVERSION='Major version';
 IDS_BUILD='Build';
 IDS_MEMORYLOADED='Memory loaded';
 IDS_MEMORYFREE='Memory free';
 IDS_MEMORYFREEPAGES='Free memory pages';
 IDS_MEMORYTOTALPAGES='Total memory pages';
 IDS_MEMORYVIRTUALFREE='Free virtual memory';
 IDS_MEMORYVIRTUALTOTAL='Total virtual memory';
 IDS_PLATFORMID='Platform ID';
 IDS_PLATFORM='Platform';
 IDS_PROCESSORNUMBER='Number of processors';
 IDS_PROCESSOR='Processor';
 IDS_TEMPPATH='Temp path';
 IDS_DOSVERSION='DOS version';
 IDS_NUMLOCK='NumLock';
 IDS_CAPSLOCK='CapsLock';
 IDS_SCROLL='ScrollLock';
 IDS_DATETIME='Date and time';
 IDS_COMPANYNAME='CompanyName';
 IDS_PRODUCTNAME='ProductName';
 IDS_PRODUCTVERSION='Version';
 IDS_LEGALCOPYRIGHT='Copyright';
 IDS_TRADEMARK='LegalTrademark';
 IDS_FILEDESCRIPTION='FileDescription';
 IDS_COMMENTS='Comments';
 IDS_CPUSPEED='CPU Speed';


implementation

end.
