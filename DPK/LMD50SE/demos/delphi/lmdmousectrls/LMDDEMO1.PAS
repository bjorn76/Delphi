unit Lmddemo1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, lmdclass, lmdnonvA, StdCtrls, lmdctrl, lmdgraph,
  lmdstdcS, LMDCustomComponent, LMDWndProcComponent, LMDMouseBaseCtrl,
  LMDMousePositioner, LMDCustomSimpleLabel, LMDSimpleLabel, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDLabel;

type
  Tfrmmousectrl2 = class(TForm)
    Button2: TButton;
    BitBtn1: TBitBtn;
    mp: TLMDMousePositioner;
    RadioGroup1: TRadioGroup;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    LMDLabel1: TLMDLabel;
    Button1: TButton;
    LMDSimpleLabel1: TLMDSimpleLabel;
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmmousectrl2: Tfrmmousectrl2;

implementation

{$R *.DFM}

procedure Tfrmmousectrl2.RadioGroup1Click(Sender: TObject);
begin
  mp.Style:=TLMDMousePosStyle(RadioGroup1.ItemIndex);
end;

procedure Tfrmmousectrl2.Button2Click(Sender: TObject);
begin
   mp.Position:=TLMDAlignment(TButton(Sender).Tag);
   mp.Execute;
end;

procedure Tfrmmousectrl2.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
