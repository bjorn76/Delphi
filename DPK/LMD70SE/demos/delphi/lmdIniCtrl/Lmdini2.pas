unit Lmdini2;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdclass, lmdformA, ExtCtrls, StdCtrls,
  ComCtrls, Spin,
  LMDIniCtrl, LMDCustomComponent, LMDWndProcComponent, LMDFormStyler,
  LMDCustomButton, LMDButton, LMDBaseGraphicControl, LMDGraphicControl,
  LMDBaseImage, LMDCustomLImage, LMDLImage, LMDFontComboBox,
  LMDCustomComboBox, LMDCustomColorComboBox, LMDColorComboBox, LMDDrawEdge,
  LMDControl, LMDBaseControl, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDSpeedButton, LMDBaseController, LMDCustomContainer,
  LMDCustomImageList, LMDBitmapList, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
  LMDCustomExtSpinEdit, LMDSpinEdit, LMDApplicationCtrl;

type
  TfrmIniCtrl = class(TForm)
    LMDFormStyler1: TLMDFormStyler;
    inictrl: TLMDIniCtrl;
    savedlg: TSaveDialog;
    LMDApplicationCtrl1: TLMDApplicationCtrl;
    LMDBitmapList1: TLMDBitmapList;
    tabs: TPageControl;
    TabSheet1: TTabSheet;
    Label5: TLabel;
    LMDOfficeButton5: TLMDSpeedButton;
    Memo1: TMemo;
    page2: TTabSheet;
    Label1: TLabel;
    LMDOfficeButton1: TLMDSpeedButton;
    LMDOfficeButton2: TLMDSpeedButton;
    LMDOfficeButton3: TLMDSpeedButton;
    LMDDrawEdge1: TLMDDrawEdge;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LMDOfficeButton4: TLMDSpeedButton;
    radio1: TRadioButton;
    radio2: TRadioButton;
    radio3: TRadioButton;
    memo: TMemo;
    cmbcolor: TLMDColorComboBox;
    cmbfont: TLMDFontComboBox;
    chk: TCheckBox;
    edit: TEdit;
    MemoIni: TMemo;
    page3: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LMDLImage1: TLMDLImage;
    Button1: TButton;
    spin: TLMDSpinEdit;
    exitbtn: TLMDButton;
    procedure FormActivate(Sender: TObject);
    procedure LMDOfficeButton2Click(Sender: TObject);
    procedure LMDDockSpeedButton1Click(Sender: TObject);
    procedure LMDOfficeButton1Click(Sender: TObject);
    procedure LMDOfficeButton3Click(Sender: TObject);
    procedure LMDOfficeButton4Click(Sender: TObject);
    procedure radio1Click(Sender: TObject);
    procedure radio2Click(Sender: TObject);
    procedure radio3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LMDOfficeButton5Click(Sender: TObject);
    procedure exitbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmIniCtrl: TfrmIniCtrl;

implementation

uses lmdini3;

{$R *.DFM}

procedure TfrmIniCtrl.FormActivate(Sender: TObject);
begin
  cmbcolor.SelectedColor:=clYellow;
  cmbfont.SelectedFont:='MS Sans Serif';
  edit.Text:=DateToStr(Date);
end;

procedure TfrmIniCtrl.LMDOfficeButton2Click(Sender: TObject);
var
  l : longint;
  d : double;
  r,g,b, i, max: integer;
  str: string;
begin
  max:=100;
  memo.lines.clear;
  Randomize;
  r:=Random(255);
  g:=Random(255);
  b:=Random(255);
  cmbcolor.SelectedColor:=RGB(r,g,b);
  str:='';
  for i:=0 to max-1 do
    begin        {97-122: kleine 65-90: große}
       l:=Random(100-65)+65;
       if l>90 then
         if l>95 then
           str:=str+' '
         else
           begin
             memo.lines.add(str);
             str:='';
           end
       else
         str:=str+chr(l);
    end;
  memo.lines.add(str);
  cmbfont.SelectedFont:=Screen.Fonts[Random(Screen.Fonts.Count)];
  spin.value:=Random(100);
  {d:=double(Random(High(LongWird)));}
  d := EncodeDate (Random(1990)+1, Random(12)+1, Random(27)+1);
  edit.Text:=DateToStr(d);
  chk.checked:=Boolean(Random(2)-1);
end;

procedure TfrmIniCtrl.LMDDockSpeedButton1Click(Sender: TObject);
begin
  savedlg.execute
end;

procedure TfrmIniCtrl.LMDOfficeButton1Click(Sender: TObject);
begin
  with inictrl do
    begin
      WriteStrings('MySection','MyMemo',memo.Lines);
      WriteInteger('MySection','MyColorCombo',cmbcolor.SelectedColor);
      WriteString('MySection','MyFontCombo',cmbfont.SelectedFont);
      WriteBool('MySection','MyBool', chk.Checked);
      WriteDate('MySection','MyDate', StrToDate(edit.text));
      WriteInteger('MySection','MySpinEdit',spin.value);
      if inictrl.Target=itIniFile then memoini.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+IniFile);
    end;

end;

procedure TfrmIniCtrl.LMDOfficeButton3Click(Sender: TObject);
var
  l: LongInt;
begin
  with inictrl do
    begin
      ReadStrings('MySection','MyMemo',memo.lines);
      l:=ReadInteger('MySection','MyColorCombo',0);
      cmbfont.SelectedFont:=ReadString('MySection','MyFontCombo','');
      chk.Checked:=ReadBool('MySection','MyBool', True);
      edit.text:=DateToStr(ReadDate('MySection','MyDate', 0));
      spin.value:=ReadInteger('MySection','MySpinEdit',0);
    end;
  cmbcolor.selectedcolor:=l;
end;

procedure TfrmIniCtrl.LMDOfficeButton4Click(Sender: TObject);
begin
  tabs.ActivePage:=page3;
end;

procedure TfrmIniCtrl.radio1Click(Sender: TObject);
begin
  inictrl.Target:=itIniFile;
end;

procedure TfrmIniCtrl.radio2Click(Sender: TObject);
begin
  inictrl.Target:=itRegistry;
end;

procedure TfrmIniCtrl.radio3Click(Sender: TObject);
begin
  inictrl.Target:=itAuto;
end;

procedure TfrmIniCtrl.Button1Click(Sender: TObject);
begin
  with Tfrmini3.Create(nil) do
    try
      showmodal;
    finally
      Free
    end;
end;

procedure TfrmIniCtrl.LMDOfficeButton5Click(Sender: TObject);
begin
  tabs.ActivePage:=page2;
end;

procedure TfrmIniCtrl.exitbtnClick(Sender: TObject);
begin
  Close;
end;

end.
