unit Lmdctg2;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdbtn, lmdctrl, lmdctrlA, lmdformA, lmdclass, lmdstdcS,
  LMDCustomFormFill, LMDBack, LMDCustomComponent, LMDWndProcComponent,
  LMDFormStyler, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel,
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDSpeedButton, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDGraphicControl, LMDBaseImage,
  LMDCustomLImage, LMDAniCtrl;

type
  TCont2 = class(TForm)
    LMDFormStyler1: TLMDFormStyler;
    LMDBack1: TLMDBack;
    ani1: TLMDAniCtrl;
    spb1: TLMDSpeedButton;
    spb2: TLMDSpeedButton;
    LMDExplorerButton4: TLMDSpeedButton;
    ani2: TLMDAniCtrl;
    LMDSimpleLabel2: TLMDSimpleLabel;
    procedure spb1Click(Sender: TObject);
    procedure LMDExplorerButton4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Cont2: TCont2;

implementation

uses lmdctg4;

{$R *.DFM}

procedure TCont2.spb1Click(Sender: TObject);
begin
   if sender=spb1 then
     begin
       ani1.Animate:=not ani1.Animate;
       if ani1.Animate then spb1.ImageIndex:=3 else spb1.ImageIndex:=4;
     end
   else
     begin
       ani2.Animate:=not ani2.Animate;
       if ani2.Animate then spb2.ImageIndex:=3 else spb2.ImageIndex:=4
     end

end;

procedure TCont2.LMDExplorerButton4Click(Sender: TObject);
begin
  Close
end;

end.
