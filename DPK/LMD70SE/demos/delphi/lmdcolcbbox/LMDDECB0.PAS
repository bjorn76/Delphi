{
Demo-Program for TLMDColorComboBox
**********************************

Note: Some functions are not possible if certain options are not set.

2 important methods are not shown here: LoadCustomColors and SaveCustomColors.
If you've purchased a sourcecode version you may look at the code for the use of
this methods in the sources of the property editors which use TLMDColorComboBox-
Components.

© 95 - 97 by LMD Innovative
}


unit Lmddecb0;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,
  LMDCustomButton, LMDDockButton, LMDCustomComboBox,
  LMDCustomColorComboBox, LMDColorComboBox, LMDDrawEdge, LMDCustomLabel,
  LMDLabel, LMDControl, LMDBaseControl, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel, StdCtrls, ExtCtrls;

type
  Tfrmcolorbox = class(TForm)
    cb1: TLMDColorComboBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    GroupBox1: TGroupBox;
    ck1: TCheckBox;
    ck2: TCheckBox;
    ck3: TCheckBox;
    ck4: TCheckBox;
    ck5: TCheckBox;
    rg5: TRadioGroup;
    lb: TLMDLabel;
    cb2: TLMDColorComboBox;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDLabel1: TLMDLabel;
    Button4: TButton;
    LMDDockButton1: TLMDDockButton;
    procedure cb1Change(Sender: TObject);
    procedure ck1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rg5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure SetOptions;
  public

  end;

var
  frmcolorbox: Tfrmcolorbox;

const
  fmessage='Background of this'#13'Label displays'#13'selected Color';

implementation

{$R *.DFM}

procedure Tfrmcolorbox.SetOptions;
var
  opt:TLMDColorCBOptions;
begin
  opt:=[];
  if ck1.Checked then opt:=[coDefaultColors];
  if ck2.Checked then opt:=opt+[coSystemColors];
  if ck3.Checked then opt:=opt+[coCustomColors];
  if ck4.Checked then opt:=opt+[coAllowAnyColor];
  if ck5.Checked then opt:=opt+[coAllowDialog];
  cb1.Options:=opt;
end;

procedure Tfrmcolorbox.cb1Change(Sender: TObject);
begin
  if cb1.SelectedColor<>-1 then
    begin
      lb.Color:=cb1.SelectedColor;
      lb.Caption:=fMessage;
    end
  else
    begin
      lb.Color:=clBtnFace;
      lb.Caption:='No Color selected';
    end
end;

procedure Tfrmcolorbox.ck1Click(Sender: TObject);
begin
  SetOptions;
end;

procedure Tfrmcolorbox.FormCreate(Sender: TObject);
begin
  cb1.SelectedColor:=clWhite;
end;

procedure Tfrmcolorbox.rg5Click(Sender: TObject);
begin
  cb1.DisplayStyle:=TLMDColorCBStyle(rg5.ItemIndex);
  if cb1.DisplayStyle=csColor3DText then
    cb1.Color:=clBtnFace
  else
    cb1.Color:=clWindow;
end;

procedure Tfrmcolorbox.Button1Click(Sender: TObject);
begin
  {Share the CustomColors-List with the dirst ColorComboBox}
  cb2.ExecuteEnh(cb1.CustomColors);
end;

procedure Tfrmcolorbox.Button4Click(Sender: TObject);
begin
  Close;
end;

end.
