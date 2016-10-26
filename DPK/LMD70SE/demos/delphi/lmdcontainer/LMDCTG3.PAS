unit Lmdctg3;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,
  LMDCustomFormFill, LMDBack, LMDCustomComponent,
  LMDWndProcComponent, LMDFormStyler, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDBaseGraphicControl, LMDGraphicControl, LMDScrollText,
  LMDControl, LMDBaseControl, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDSpeedButton;

type
  TCont3 = class(TForm)
    LMDFormStyler1: TLMDFormStyler;
    LMDBack1: TLMDBack;
    LMDExplorerButton4: TLMDSpeedButton;
    spb1: TLMDSpeedButton;
    spb2: TLMDSpeedButton;
    Scrolltext: TLMDScrollText;
    spb3: TLMDSpeedButton;
    spb4: TLMDSpeedButton;
    LMDSimpleLabel2: TLMDSimpleLabel;
    procedure spb2Click(Sender: TObject);
    procedure LMDExplorerButton4Click(Sender: TObject);
    procedure spb3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Cont3: TCont3;

implementation

uses lmdctg4;

{$R *.DFM}

procedure TCont3.spb2Click(Sender: TObject);
begin
   if sender=spb1 then
     data.wvl[0].Wave.Play
   else
     data.wvl[1].Wave.Play
end;

procedure TCont3.LMDExplorerButton4Click(Sender: TObject);
begin
  Close
end;

procedure TCont3.spb3Click(Sender: TObject);
begin
  if sender=spb3 then
     ScrollText.Lines.Assign(data.sll[0].Items)
  else
     ScrollText.Lines.Assign(data.sll[1].Items);
  ScrollText.Scroll:=True;
end;

end.
