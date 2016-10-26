unit Msgdlg1;

interface

uses
  Windows, ComCtrls,
  SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdclass, lmdformA, ExtCtrls, Tabs, StdCtrls, lmdstdcA,
  lmdstdcS, lmdctrl, lmdextcS, lmdcont, lmdbtn, lmdgroup, lmdmsg, lmdctrlA,
  lmdprocs, lmdgraph, lmdcompo, lmdcctrl, LMDContainerComponent,
  LMDCustomComponent, LMDWndProcComponent, LMDFormStyler,
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDSpeedButton,
  LMDSimplePanel, LMDButtonControl, LMDCustomCheckBox, LMDCheckBox,
  LMDCustomImageListBox, LMDImageListBox, LMDCustomButton, LMDButton,
  LMDGroupBox, LMDCustomRadioGroup, LMDRadioGroup, LMDGraphicControl,
  LMDBaseImage, LMDCustomLImage, LMDLImage, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel,
  LMDCustomGroupBox, LMDCustomButtonGroup, LMDCustomCheckGroup,
  LMDCheckGroup, LMDControl, LMDBaseControl, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel;

type
  TfrmMsgDemo = class(TForm)
    note: TPageControl;
    LMDFormStyler1: TLMDFormStyler;
    lmdmsg: TLMDMessageBoxDlg;
    lmdchkg: TLMDCheckGroup;
    LMDBitmapList1: TLMDBitmapList;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    LMDLImage3: TLMDLImage;
    RadioButton2: TRadioButton;
    LMDLImage1: TLMDLImage;
    RadioButton3: TRadioButton;
    LMDLImage2: TLMDLImage;
    LMDLImage4: TLMDLImage;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    LMDLImage5: TLMDLImage;
    rbMA: TLMDRadioGroup;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSpeedButton1: TLMDSpeedButton;
    LMDSpeedButton2: TLMDSpeedButton;
    LMDBitmapList2: TLMDBitmapList;
    memo: TMemo;
    rbBA: TLMDRadioGroup;
    cbRP: TComboBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    rbGA: TLMDRadioGroup;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDGroupBox2: TLMDGroupBox;
    Label1: TLabel;
    LMDButton3: TLMDButton;
    LMDButton4: TLMDButton;
    cbCF: TCheckBox;
    edcaption: TEdit;
    LMDRadioGroup1: TLMDRadioGroup;
    cbWF: TLMDCheckBox;
    LMDWaveList1: TLMDWaveList;
    LMDSpinEdit1: TLMDSpinEdit;
    LMDSpinEdit2: TLMDSpinEdit;
    LMDSpinEdit3: TLMDSpinEdit;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    page1: TTabSheet;
    page2: TTabSheet;
    page3: TTabSheet;
    LMDImageListBox1: TLMDImageListBox;
    procedure LMDSpeedButton1Click(Sender: TObject);
    procedure LMDSpeedButton2Click(Sender: TObject);
    procedure lmdchkgClick(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure cbCFClick(Sender: TObject);
    procedure cbWFChange(Sender: TObject);
    procedure cbRPChange(Sender: TObject);
    procedure LMDSpinEdit1Change(Sender: TObject);
    procedure LMDSpinEdit2Change(Sender: TObject);
    procedure LMDSpinEdit3Change(Sender: TObject);
    procedure LMDRadioGroup1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMsgDemo: TfrmMsgDemo;

implementation


{$R *.DFM}

procedure TfrmMsgDemo.LMDSpeedButton1Click(Sender: TObject);
var
  a: string;
begin
  a:=memo.text;

  if LMDImageListBox1.ItemIndex=-1 then
   lmdmsg.ImageList:= nil
  else
    begin
     lmdmsg.ImageList:= LMDBitmapList2;
     lmdmsg.ListIndex :=  LMDImageListBox1.ItemIndex;
    end;
  lmdmsg.RelatePos:= TLMDDlgPosRel(cbRP.ItemIndex);
  lmdmsg.MessageAlignment.Alignment := TLMDAlignment (rbMA.ItemIndex);
  lmdmsg.MessageAlignment.AlignText2Glyph := TLMDTextArrange (rbGA.ItemIndex);
  lmdmsg.Position := TLMDBoxPosition (rbBA.ItemIndex+1);
  lmdmsg.Execute (edcaption.text,a,[0], [], -1, -1, -1, -1, 0);
end;

procedure TfrmMsgDemo.LMDSpeedButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMsgDemo.lmdchkgClick(Sender: TObject);
var
  x: TMsgDlgButtons;
  i: integer;
begin
  for i:=0 to 8 do
    begin
      Case i of
      0: x:=[mbYes];
      1: x:=[mbNo];
      2: x:=[mbOK];
      3: x:=[mbCancel];
      4: x:=[mbAbort];
      5: x:=[mbRetry];
      6: x:=[mbIgnore];
      7: x:=[mbAll];
      8: x:=[mbHelp];
      end;
      if (lmdchkg.value and LMDExp(2,i))=LMDExp(2,i) then
        lmdmsg.Buttons:=lmdmsg.Buttons+x
      else
        lmdmsg.Buttons:=lmdmsg.Buttons-x;
    end;
end;

procedure TfrmMsgDemo.RadioButton2Click(Sender: TObject);
begin
  lmdmsg.DlgType:=mtInformation;
end;

procedure TfrmMsgDemo.RadioButton1Click(Sender: TObject);
begin
  lmdmsg.DlgType:=mtConfirmation;
end;

procedure TfrmMsgDemo.RadioButton3Click(Sender: TObject);
begin
  lmdmsg.DlgType:=mtWarning;
end;

procedure TfrmMsgDemo.RadioButton4Click(Sender: TObject);
begin
  lmdmsg.DlgType:=mtError;
end;

procedure TfrmMsgDemo.RadioButton5Click(Sender: TObject);
begin
  lmdmsg.DlgType:=mtCustom;
end;

procedure TfrmMsgDemo.cbCFClick(Sender: TObject);
begin
  lmdmsg.CaptionFill :=cbCF.Checked;
end;

procedure TfrmMsgDemo.cbWFChange(Sender: TObject);
begin
  lmdmsg.PlayWave := cbWF.Checked;
end;

procedure TfrmMsgDemo.cbRPChange(Sender: TObject);
begin

  if cbRP.Text = 'Screen' then

  if cbRP.Text = 'MainForm' then
    lmdmsg.RelatePos := brMainForm;
  if cbRP.Text = 'ActiveForm' then
    lmdmsg.RelatePos := brActiveWindow;
  if cbRP.Text = 'ActiveForm' then

end;

procedure TfrmMsgDemo.LMDSpinEdit1Change(Sender: TObject);
begin
  lmdmsg.MessageAlignment.Spacing := LMDSpinEdit1.Value;
end;

procedure TfrmMsgDemo.LMDSpinEdit2Change(Sender: TObject);
begin
  lmdmsg.MessageAlignment.OffsetX := LMDSpinEdit2.Value;
end;

procedure TfrmMsgDemo.LMDSpinEdit3Change(Sender: TObject);
begin
  lmdmsg.MessageAlignment.OffsetY := LMDSpinEdit2.Value;
end;

procedure TfrmMsgDemo.LMDRadioGroup1Click(Sender: TObject);
begin
  lmdmsg.WaveIndex:=LMDRadioGroup1.ItemIndex;
end;


end.
