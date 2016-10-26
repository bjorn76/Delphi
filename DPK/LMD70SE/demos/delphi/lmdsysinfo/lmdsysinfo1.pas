{New demonstration app for TLMDSysInfo}
unit lmdsysinfo1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, lmdclass,
  LMDFormStyler, LMDContainerComponent, LMDBaseDialog, LMDAboutDlg,
  LMDCustomComponent, LMDCustomControl, LMDCustomPanel,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, LMDBaseGraphicButton,
  LMDCustomSpeedButton, LMDSpeedButton, LMDGraphicControl, LMDBaseMeter,
  LMDCustomProgressFill, LMDProgressFill, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDControl, LMDDrawEdge, LMDSysInfo, LMDWndProcComponent,
  ExtDlgs, Menus, ExtCtrls, StdCtrls;

type
  TfrmLMDSysInfoDemo = class(TForm)
    PageControl1: TPageControl;
    TabFonts: TTabSheet;
    TabPrinters: TTabSheet;
    MemoFonts: TMemo;
    MemoPrinters: TMemo;
    TabMemory: TTabSheet;
    TabSettings: TTabSheet;
    TabSystem: TTabSheet;
    LMDSysInfo: TLMDSysInfo;
    MainMenu1: TMainMenu;
    mnuFile: TMenuItem;
    fileQuit: TMenuItem;
    Panel1: TPanel;
    TabKeyboard: TTabSheet;
    NumLock: TLMDSimpleLabel;
    CapsLock: TLMDSimpleLabel;
    ScrollLock: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    TrackSpeed: TTrackBar;
    TrackDelay: TTrackBar;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDSimpleLabel6: TLMDSimpleLabel;
    LMDSimpleLabel7: TLMDSimpleLabel;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDDrawEdge2: TLMDDrawEdge;
    LMDDrawEdge3: TLMDDrawEdge;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDDrawEdge4: TLMDDrawEdge;
    LMDProgressFill1: TLMDProgressFill;
    memLabel1: TLMDSimpleLabel;
    LMDSimpleLabel9: TLMDSimpleLabel;
    LMDProgressFill2: TLMDProgressFill;
    memLabel2: TLMDSimpleLabel;
    LMDProgressFill3: TLMDProgressFill;
    memLabel3: TLMDSimpleLabel;
    LMDDrawEdge5: TLMDDrawEdge;
    LMDSimpleLabel10: TLMDSimpleLabel;
    LMDSimpleLabel11: TLMDSimpleLabel;
    LMDDrawEdge6: TLMDDrawEdge;
    LabelBuild: TLMDSimpleLabel;
    LabelExtension: TLMDSimpleLabel;
    LabelComputerName: TLMDSimpleLabel;
    LabelCurrentUser: TLMDSimpleLabel;
    LabelPlatform: TLMDSimpleLabel;
    LabelProcessorNumber: TLMDSimpleLabel;
    LabelProcessorType: TLMDSimpleLabel;
    LabelRegisteredCompany: TLMDSimpleLabel;
    LabelRegisteredOwner: TLMDSimpleLabel;
    LabelVersion: TLMDSimpleLabel;
    TabSystem2: TTabSheet;
    LabelColorDepth: TLMDSimpleLabel;
    LabelDefaultLanguage: TLMDSimpleLabel;
    LabelScreenHeight: TLMDSimpleLabel;
    LabelScreenWidth: TLMDSimpleLabel;
    LabelTempPath: TLMDSimpleLabel;
    LabelTimeZone: TLMDSimpleLabel;
    LabelTimeDiff: TLMDSimpleLabel;
    LabelWinPath: TLMDSimpleLabel;
    LabelSysPath: TLMDSimpleLabel;
    LMDSimpleLabel12: TLMDSimpleLabel;
    LMDSimpleLabel13: TLMDSimpleLabel;
    LMDSimpleLabel14: TLMDSimpleLabel;
    LMDSimpleLabel15: TLMDSimpleLabel;
    LMDSimpleLabel16: TLMDSimpleLabel;
    LMDSimpleLabel17: TLMDSimpleLabel;
    LMDSimpleLabel18: TLMDSimpleLabel;
    LMDSimpleLabel19: TLMDSimpleLabel;
    LMDSimpleLabel20: TLMDSimpleLabel;
    LMDSimpleLabel21: TLMDSimpleLabel;
    LMDDrawEdge7: TLMDDrawEdge;
    LMDSimpleLabel22: TLMDSimpleLabel;
    LMDSimpleLabel23: TLMDSimpleLabel;
    LMDSimpleLabel24: TLMDSimpleLabel;
    LMDSimpleLabel25: TLMDSimpleLabel;
    LMDSimpleLabel26: TLMDSimpleLabel;
    LMDSimpleLabel27: TLMDSimpleLabel;
    LMDSimpleLabel28: TLMDSimpleLabel;
    LMDSimpleLabel29: TLMDSimpleLabel;
    LMDSimpleLabel30: TLMDSimpleLabel;
    LMDSimpleLabel31: TLMDSimpleLabel;
    LMDDrawEdge8: TLMDDrawEdge;
    LMDSimpleLabel32: TLMDSimpleLabel;
    chkAnimate: TLMDCheckBox;
    chkSmoothing: TLMDCheckBox;
    chkScreen: TLMDCheckBox;
    chkSnap: TLMDCheckBox;
    chkBeep: TLMDCheckBox;
    LMDSimpleLabel34: TLMDSimpleLabel;
    LMDDrawEdge9: TLMDDrawEdge;
    LMDSimpleLabel33: TLMDSimpleLabel;
    LMDDrawEdge10: TLMDDrawEdge;
    LabelTimeOut: TLMDSimpleLabel;
    LMDDrawEdge11: TLMDDrawEdge;
    LMDSimpleLabel35: TLMDSimpleLabel;
    LMDDrawEdge12: TLMDDrawEdge;
    LMDSimpleLabel36: TLMDSimpleLabel;
    mnuHelp: TMenuItem;
    helpAbout: TMenuItem;
    LMDAboutDlg: TLMDAboutDlg;
    LMDSpeedSet: TLMDSpeedButton;
    OpenPicture: TOpenPictureDialog;
    LMDSpeedClear: TLMDSpeedButton;
    LMDDrawEdge13: TLMDDrawEdge;
    TabEnvironment: TTabSheet;
    MemoEnvironment: TMemo;
    LMDDrawEdge14: TLMDDrawEdge;
    LMDSimpleLabel37: TLMDSimpleLabel;
    LMDSimpleLabel38: TLMDSimpleLabel;
    LMDFormStyler1: TLMDFormStyler;
    procedure FormCreate(Sender: TObject);
    procedure fileQuitClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure TrackDelayChange(Sender: TObject);
    procedure TrackSpeedChange(Sender: TObject);
    procedure chkAnimateChange(Sender: TObject);
    procedure chkSmoothingChange(Sender: TObject);
    procedure chkSnapChange(Sender: TObject);
    procedure chkBeepChange(Sender: TObject);
    procedure chkScreenChange(Sender: TObject);
    procedure helpAboutClick(Sender: TObject);
    procedure LMDSpeedSetClick(Sender: TObject);
    procedure LMDSpeedClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure IdleHandler(Sender: TObject; var Done: Boolean);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmLMDSysInfoDemo: TfrmLMDSysInfoDemo;

implementation

{$R *.DFM}

// always called when system is idle
procedure TfrmLMDSysInfoDemo.IdleHandler(Sender: TObject; var Done: Boolean);
begin

  // KeyStates
    if LMDSysInfo.NumLockState then NumLock.Font.Color := clLime
    else NumLock.Font.Color := clBlack;

  if LMDSysInfo.CapsLockState then CapsLock.Font.Color := clLime
    else CapsLock.Font.Color := clBlack;

  if LMDSysInfo.ScrollLockState then ScrollLock.Font.Color := clLime
    else ScrollLock.Font.Color := clBlack;

  // Memory-Bars
  with LMDProgressFill1 do  // phys-mem
    begin
      MaxValue := LMDSysInfo.MemPhysTotal;
      UserValue := LMDSysInfo.MemPhysFree;
    end;
  with LMDProgressFill2 do  // virt-mem
    begin
      MaxValue := LMDSysInfo.MemVirtTotal;
      UserValue := LMDSysInfo.MemVirtFree;
    end;
  with LMDProgressFill3 do  // page-mem
    begin
      MaxValue := LMDSysInfo.MemPageTotal;
      UserValue := LMDSysInfo.MemPageFree;
    end;

  // memory in numbers
  memLabel1.Caption := IntToStr(LMDSysInfo.MemPhysFree) + '/ ' + IntToStr(LMDSysInfo.MemPhysTotal) + ' kBytes';
  memLabel2.Caption := IntToStr(LMDSysInfo.MemVirtFree) + '/ ' + IntToStr(LMDSysInfo.MemVirtTotal) + ' kBytes';
  memLabel3.Caption := IntToStr(LMDSysInfo.MemPageFree) + '/ ' + IntToStr(LMDSysInfo.MemPageTotal) + ' kBytes';
end;

procedure TfrmLMDSysInfoDemo.FormCreate(Sender: TObject);
begin
  Application.OnIdle := IdleHandler;
  frmLMDSysInfoDemo.Caption := 'LMD-Systeminformation - ' + LMDSysInfo.ComputerName;
  // initial setup
  PageControl1Change(self);
end;

procedure TfrmLMDSysInfoDemo.fileQuitClick(Sender: TObject);
begin
  Close
end;

procedure TfrmLMDSysInfoDemo.PageControl1Change(Sender: TObject);
begin
  // Fonts
  MemoFonts.ReadOnly := false;
  MemoFonts.Lines.Assign (LMDSysInfo.AllFonts);
  MemoFonts.ReadOnly := true;
  // Printers
  MemoPrinters.ReadOnly := false;
  MemoPrinters.Lines.Assign (LMDSysInfo.AllPrinters);
  MemoPrinters.ReadOnly := true;

  // Keyboard
  TrackDelay.Position := LMDSysInfo.KeyboardDelay;
  TrackSpeed.Position := LMDSysInfo.KeyboardSpeed;

  // !Plus
  if lmdsysinfo.PlusAvailable then labelextension.caption := 'Plus! installed'
    else labelextension.caption := 'Plus! not installed';

  // Build Number
  LabelBuild.Caption := IntToStr(LMDSysInfo.BuildNumber);

  // Language
  LabelDefaultLanguage.Caption := LMDSysInfo.DefaultLanguageString;

  // User
  LabelCurrentUser.Caption := LMDSysInfo.CurrentUser;

  // Computername
  LabelComputerName.Caption := LMDSysInfo.Computername;

  // ColorDepth
  LabelColorDepth.Caption := IntToStr(LMDSysInfo.ColorDepth)+ ' bit';

  // Platform
  LabelPlatform.Caption := LMDSysInfo.Platform;

  // ProcessorNumber
  LabelProcessorNumber.Caption := IntToStr(LMDSysInfo.ProcessorNumber);

  // ProcessorType
  LabelProcessorType.Caption := LMDSysInfo.ProcessorType;

  // Registered Company
  LabelRegisteredCompany.Caption := LMDSysInfo.RegisteredCompany;

  // Registered Owner
  LabelRegisteredOwner.Caption := LMDSysInfo.RegisteredOwner;

  // Screenheight
  LabelScreenHeight.Caption := IntToStr(LMDSysInfo.ScreenHeight) + ' Pixel';

  // Screenwidth
  LabelScreenWidth.Caption := IntToStr(LMDSysInfo.ScreenWidth) + ' Pixel';

  // TempPath
  LabelTempPath.Caption := LMDSysInfo.TempPath;

  // TimeZone
  LabelTimeZone.Caption := LMDSysInfo.TimeZone;

  // TimeDiff
  LabelTimeDiff.Caption := IntToStr(LMDSysInfo.TimeZoneDiff) + ' min';

  // Version
  LabelVersion.Caption := LMDSysInfo.VersionWIN;

  // Winpath
  LabelWinPath.Caption := LMDSysInfo.WinPath;

  // SysPath
  LabelSysPath.Caption := LMDSysInfo.WinSysPath;

  // Checkboxes
  with LMDSysInfo do
  begin
    chkAnimate.Checked := WindowAnimation;
    chkSmoothing.Checked := FontSmoothing;
    chkSnap.Checked := SnapToDefaultButton;
    chkBeep.Checked := WarningBeep;
    chkScreen.Checked := ScreenSaveActive;
  end;

  // TimeOut
  LabelTimeOut.Caption := IntToStr(LMDSysInfo.ScreenSaverDelay) + ' min';

  // Environment String
  MemoEnvironment.ReadOnly := false;
  MemoEnvironment.Lines := LMDSysInfo.Environment;
  MemoEnvironment.ReadOnly := true;  
end;

procedure TfrmLMDSysInfoDemo.TrackDelayChange(Sender: TObject);
begin
  // set keyboard delay
  LMDSysInfo.KeyboardDelay := TrackDelay.Position;
end;

procedure TfrmLMDSysInfoDemo.TrackSpeedChange(Sender: TObject);
begin
  // set keyboard speed
  LMDSysInfo.KeyboardSpeed := TrackSpeed.Position;
end;

procedure TfrmLMDSysInfoDemo.chkAnimateChange(Sender: TObject);
begin
  // set window animation
  LMDSysInfo.WindowAnimation := chkAnimate.Checked;
end;

procedure TfrmLMDSysInfoDemo.chkSmoothingChange(Sender: TObject);
begin
  // set fontsmoothing
  LMDSysInfo.FontSmoothing := chkSmoothing.Checked;
end;

procedure TfrmLMDSysInfoDemo.chkSnapChange(Sender: TObject);
begin
  // set snaptbutton (nt only)
  LMDSysInfo.SnapToDefaultButton := chkSnap.Checked;
end;

procedure TfrmLMDSysInfoDemo.chkBeepChange(Sender: TObject);
begin
  // set beep
  LMDSysInfo.WarningBeep := chkBeep.Checked;
end;

procedure TfrmLMDSysInfoDemo.chkScreenChange(Sender: TObject);
begin
  // set screensaver activity
  LMDSysInfo.ScreenSaveActive := chkScreen.Checked;
end;

procedure TfrmLMDSysInfoDemo.helpAboutClick(Sender: TObject);
begin
  // about dialog
  LMDAboutDlg.Execute;
end;

procedure TfrmLMDSysInfoDemo.LMDSpeedSetClick(Sender: TObject);
begin
  // set desktop wallpaper
  if OpenPicture.Execute then
    LMDSysInfo.SetDesktopWallpaper(OpenPicture.FileName);
end;

procedure TfrmLMDSysInfoDemo.LMDSpeedClearClick(Sender: TObject);
begin
  // clear wallpaper by ''-filename
  LMDSysInfo.SetDesktopWallpaper('');
end;

procedure TfrmLMDSysInfoDemo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.OnIdle := nil;
end;

end.
