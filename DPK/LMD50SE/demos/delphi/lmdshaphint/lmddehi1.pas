{
 Demo-Program for TLMDShapeHint.

 This small demo demonstrates some extended features of the TLMDShapeHint-
 property.
 Note the very strong LMDCP[..]-routines with which you can manipulate LMD-objects
 or standard-objects in the same way like the LMD-Tools package does internally.

 © 95 - 97 by LMD Innovative

 ------------------------------------------------------------------
}

unit Lmddehi1;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdctrl, lmdshapA, lmdclass, lmdnonvA, lmdformA, StdCtrls,
  lmdgraph, lmdextcS, lmdnonvS, lmdcompo, lmdcombo, LMDCustomHint,
  LMDCustomShapeHint, LMDShapeHint, LMDCustomComponent,
  LMDWndProcComponent, LMDFormStyler, LMDCustomComboBox,
  LMDCustomColorComboBox, LMDColorComboBox, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseShape, LMDShapeControl;

type
  TfrmshapeHint = class(TForm)
    shape: TLMDShapeControl;
    memo: TMemo;
    Label1: TLabel;
    cmb: TComboBox;
    Label2: TLabel;
    ccmb: TLMDColorComboBox;
    bcmb: TLMDColorComboBox;
    Label3: TLabel;
    Label4: TLabel;
    cmbstyle: TComboBox;
    Label5: TLabel;
    LMDFormStyler1: TLMDFormStyler;
    shint: TLMDShapeHint;
    Button1: TButton;
    procedure memoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure ccmbChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmshapeHint: TfrmshapeHint;

implementation
{$R *.DFM}

procedure TfrmshapeHint.memoChange(Sender: TObject);
begin
  shape.Hint:=memo.Text;
end;

procedure TfrmshapeHint.FormCreate(Sender: TObject);
begin
  ccmb.SelectedColor:=shint.Color;
  bcmb.SelectedColor:=shint.BorderColor;
end;

procedure TfrmshapeHint.cmbChange(Sender: TObject);
begin
  if sender=cmb then
    shint.position:=TLMDHintPosition(ord(cmb.itemindex))
  else if sender=cmbstyle then
    shint.style:=TLMDHintStyle(ord(cmbstyle.itemindex));
end;

procedure TfrmshapeHint.ccmbChange(Sender: TObject);
begin
  if sender=ccmb then
    shint.color:=ccmb.selectedColor
  else if sender=bcmb then
    shint.bordercolor:=bcmb.selectedColor;
end;

procedure TfrmshapeHint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  sHint.Enabled:=False;
end;

procedure TfrmshapeHint.Button1Click(Sender: TObject);
begin
  Close
end;

end.
