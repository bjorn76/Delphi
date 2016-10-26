{
 Demo-Program for TLMDMessageHint.

 This small demo demonstrates some extended features of the TLMDMessageHint-
 property.
 Note the very strong LMDCP[..]-routines with which you can manipulate LMD-objects
 or standard-objects in the same way like the LMD-Tools package does internally.

 © 95 - 98 by LMD Innovative

 ------------------------------------------------------------------
}

unit lmddemhi;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdctrl, lmdshapA, lmdclass, lmdnonvA, lmdformA, StdCtrls,
  lmdgraph, lmdextcS, lmdnonvS, ExtCtrls, lmdbtn, lmdstdcS, ComCtrls,
  lmdcompo, lmdcombo, LMDCustomHint, LMDCustomShapeHint, LMDMessageHint,
  LMDCustomComponent, LMDWndProcComponent, LMDFormStyler,
  LMDCustomComboBox, LMDCustomColorComboBox, LMDColorComboBox,
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDSpeedButton, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel;

type
  TfrmsmsgHint = class(TForm)
    LMDFormStyler1: TLMDFormStyler;
    Button1: TButton;
    shint: TLMDMessageHint;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    memo: TMemo;
    cmb: TComboBox;
    ccmb: TLMDColorComboBox;
    bcmb: TLMDColorComboBox;
    cmbstyle: TComboBox;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDSimpleLabel9: TLMDSimpleLabel;
    LMDSimpleLabel10: TLMDSimpleLabel;
    LMDSpeedButton3: TLMDSpeedButton;
    LMDSpeedButton4: TLMDSpeedButton;
    Shape1: TShape;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure ccmbChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LMDSpeedButton4Click(Sender: TObject);
    procedure LMDSpeedButton3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmsmsgHint: TfrmsmsgHint;

implementation
{$R *.DFM}

procedure TfrmsmsgHint.FormCreate(Sender: TObject);
begin
  ccmb.SelectedColor:=shint.Color;
  bcmb.SelectedColor:=shint.BorderColor;
end;

procedure TfrmsmsgHint.cmbChange(Sender: TObject);
begin
  if sender=cmb then
    shint.position:=TLMDHintPosition(ord(cmb.itemindex))
  else if sender=cmbstyle then
    shint.style:=TLMDHintStyle(ord(cmbstyle.itemindex));
end;

procedure TfrmsmsgHint.ccmbChange(Sender: TObject);
begin
  if sender=ccmb then
    shint.color:=ccmb.selectedColor
  else if sender=bcmb then
    shint.bordercolor:=bcmb.selectedColor;
end;

procedure TfrmsmsgHint.Button1Click(Sender: TObject);
begin
  Close
end;

procedure TfrmsmsgHint.LMDSpeedButton4Click(Sender: TObject);
begin
  shint.ShowControlMessage(memo.text, memo1);
end;

procedure TfrmsmsgHint.LMDSpeedButton3Click(Sender: TObject);
begin
  shint.ShowControlMessage(memo.Text, shape1);
end;

procedure TfrmsmsgHint.FormKeyPress(Sender: TObject; var Key: Char);
begin
 // one line to get any key messages
 if shint.IsDisplaying then shint.HideMessage
end;

end.
