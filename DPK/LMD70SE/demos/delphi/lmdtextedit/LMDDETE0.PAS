{
TLMDMRUList:
This project demonstrates sharing of one MRUList among MDI form and childs
Saving if MRUList is done automatically by link to a TLMDIniCtrl.

TLMDHideNonVC: Try it! Hide all non visual components. Double click on the
               component for display of the editor.

© 95 - 98 LMD Innovative

New from LMDTools 4.0
TLMDFontComboBox, TLMDFontSizeComboBox
-> FocusCtrl
-> Flat

TLMDMemo instead of TMemo
-> Transparent
-> Lined, WordWrap
-> customized Scrollbars

TLMDSpeedButtons instead of TLMDOfficeButtons

TLMDBackPanel
-> contains backimage for TLMDMemo}

unit Lmddete0;

interface

uses
  Windows,
  Classes, Graphics, Controls, Printers,
  Menus, lmddete1, Dialogs, Forms, ExtCtrls, lmdclass, lmdformA,
  LMDApplicationCtrl, LMDCustomFormFill, LMDBack,
  LMDCustomIniComponent, LMDMRUList, LMDIniCtrl, LMDCustomHint,
  LMDCustomShapeHint, LMDShapeHint, LMDTipDlg, LMDContainerComponent,
  LMDBaseDialog, LMDAboutDlg, LMDOneInstance, LMDCustomComponent,
  LMDWndProcComponent, LMDFormStyler, LMDInformationLabel, LMDStatusBar,
  LMDCustomStatusBar, LMDFontSizeComboBox, LMDCustomComboBox,
  LMDFontComboBox, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDSpeedButton, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDSimplePanel, LMDGraphicControl, LMDTechnicalLine, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel, LMDImageList, LMDBaseController,
  LMDCustomContainer, LMDCustomImageList, LMDBitmapList, LMDHideNonVC,
  StdCtrls;

type
  TfrmFrame = class(TForm)
    OpenFileDialog: TOpenDialog;
    MainMenu1: TMainMenu;
    Open1: TMenuItem;
    Window1: TMenuItem;
    Tile1: TMenuItem;
    Cascade1: TMenuItem;
    ArrangeIcons1: TMenuItem;
    Separator3: TMenuItem;
    LMDFormStyler1: TLMDFormStyler;
    Help1: TMenuItem;
    Tips1: TMenuItem;
    N1: TMenuItem;
    About1: TMenuItem;
    LMDOneInstance1: TLMDOneInstance;
    about: TLMDAboutDlg;
    tips: TLMDTipDlg;
    LMDForm1: TLMDForm;
    LMDShapeHint1: TLMDShapeHint;
    LMDHideNonVC1: TLMDHideNonVC;
    ini: TLMDIniCtrl;
    mru: TLMDMRUList;
    LMDBack1: TLMDBack;
    LMDBitmapList1: TLMDBitmapList;
    LMDSimplePanel1: TLMDSimplePanel;
    fc: TLMDFontComboBox;
    fcs: TLMDFontSizeComboBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDTechnicalLine2: TLMDTechnicalLine;
    LMDSpeedButton1: TLMDSpeedButton;
    LMDSpeedButton2: TLMDSpeedButton;
    LMDSpeedButton3: TLMDSpeedButton;
    LMDSpeedButton6: TLMDSpeedButton;
    LMDSpeedButton5: TLMDSpeedButton;
    open: TLMDSpeedButton;
    LMDImageList1: TLMDImageList;
    LMDStatusBar1: TLMDStatusBar;
    ReOpen1: TMenuItem;
    LMDInformationLabel1: TLMDInformationLabel;
    LMDInformationLabel2: TLMDInformationLabel;
    LMDInformationLabel3: TLMDInformationLabel;
    LMDApplicationCtrl1: TLMDApplicationCtrl;
    Minimize1: TMenuItem;
    procedure NewChild(Sender: TObject);
    procedure OpenChild(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure Tile1Click(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
    procedure ArrangeIcons1Click(Sender: TObject);
    procedure Tips1Click(Sender: TObject);
    procedure LMDSysMenu1Click(Sender: TObject; Index: Integer;
      aCaption: String);
    procedure About1Click(Sender: TObject);
    procedure LMDForm1FMDragDrop(Sender: TObject; fcount, x, y: Integer;
      FileList: TStrings);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure MRUClick(Sender: TObject; const aValue: String;
      var Remove: Boolean);
    procedure fcChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mruChange(Sender: TObject);
    procedure fcsChange(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure LMDApplicationCtrl1EditModeChange(Sender: TObject);
    procedure Minimize1Click(Sender: TObject);
  end;

var
  frmFrame: TfrmFrame;
  Flag:Boolean;

implementation

uses
  SysUtils;

{$R *.DFM}

procedure TfrmFrame.NewChild(Sender: TObject);
var
  EditForm: TFrmEdit;
begin
  EditForm := TFrmEdit.Create(self);
  EditForm.Show;
  EditForm.LMDMemo1.Font.Name:=fc.SelectedFont;
  EditForm.LMDMemo1.Font.Size:=fcs.FontSize;
  mruChange(nil);
end;

procedure TfrmFrame.OpenChild(Sender: TObject);
var
  EditForm: TFrmEdit;
begin
  OpenFileDialog.Filename:='*.txt';
  if OpenFileDialog.Execute then
  begin
    EditForm := TFrmEdit.Create(Self);
    EditForm.Open(OpenFileDialog.Filename);
    EditForm.Show;
    EditForm.LMDMemo1.Font.Name:=fc.SelectedFont;
    {--> Add filename here to MRU-List}
    MRU.Add(OpenFileDialog.Filename);
  end;
end;

procedure TfrmFrame.ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFrame.Tile1Click(Sender: TObject);
begin
  Tile;
end;

procedure TfrmFrame.Cascade1Click(Sender: TObject);
begin
  Cascade;
end;

procedure TfrmFrame.ArrangeIcons1Click(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TfrmFrame.Tips1Click(Sender: TObject);
begin
  tips.Execute;
end;

procedure TfrmFrame.LMDSysMenu1Click(Sender: TObject; Index: Integer;
  aCaption: String);
begin
  case Index of
    1:Tips1Click(Sender);
    2:About1Click(Sender);
  end;
end;

procedure TfrmFrame.About1Click(Sender: TObject);
begin
 about.execute;
end;

{demo for Drag&Drop Event}
procedure TfrmFrame.LMDForm1FMDragDrop(Sender: TObject; fcount, x,
  y: Integer; FileList: TStrings);
var
  EditForm: TFrmEdit;
  i:Integer;
begin
  screen.Cursor:=crHourglass;
  try
    for i:=0 to fcount-1 do
      begin
         EditForm := TFrmEdit.Create(Self);
         EditForm.Open(FileList[i]);
         EditForm.Show;

      end;
  finally
    screen.Cursor:=crDefault;
  end;

end;

{sharing bitmaps/icons among controls}
procedure TfrmFrame.FormCreate(Sender: TObject);
begin
  about.Icon:=Icon;
  fc.SelectedFont:=ini.ReadString('General', 'Font', 'Arial');
  Flag:=False;
end;

procedure TfrmFrame.Button1Click(Sender: TObject);
begin
  Close;
end;


procedure TfrmFrame.MRUClick(Sender: TObject; const aValue: String;
  var Remove: Boolean);
var
  EditForm: TFrmEdit;
begin
  if FileExists(aValue) then
    begin
      EditForm := TFrmEdit.Create(Self);
      EditForm.Open(aValue);
      EditForm.Show;
      MRU.Add(aValue);
    end
  else
    Remove:=True;    {file doesn't exist, therefore remove from MRU-List}
  mruchange(self);
end;

procedure TfrmFrame.fcChange(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Pred(MDIChildCount) do
    TFrmEdit(MDIChildren[i]).LMDMemo1.Font.Name:=fc.SelectedFont;
{  If ActiveMDIChild<>nil then
    TfrmEdit(ActiveMDIChild).LMDMemo1.SetFocus;}
end;

procedure TfrmFrame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ini.WriteString('General', 'Font', fc.SelectedFont);
end;

{not very smart, but possibe: If Master MRU changes, change
 MRULists of all Childs}
procedure TfrmFrame.mruChange(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Pred(MDIChildCount) do
    with TFrmEdit(MDIChildren[i]).MRUChild do ShareList(MRU.Items);
end;

procedure TfrmFrame.fcsChange(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Pred(MDIChildCount) do
    TFrmEdit(MDIChildren[i]).LMDMemo1.Font.Size:=fcs.FontSize;
end;

procedure TfrmFrame.SaveClick(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    TFrmEdit(ActiveMDIChild).Save1Click (Sender);
end;

procedure TfrmFrame.LMDApplicationCtrl1EditModeChange(Sender: TObject);
begin
  if emInsert in LMDApplication.EditMode then
    frmFrame.LMDStatusBar1.Panels[6].Text := 'Ins'
  else
    frmFrame.LMDStatusBar1.Panels[6].Text := 'Ovr'
end;

procedure TfrmFrame.Minimize1Click(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to MDIChildCount - 1 do
    MDIChildren[i].WindowState := wsMinimized;
  ActiveMDIChild.WindowState := wsMinimized;
end;

end.




