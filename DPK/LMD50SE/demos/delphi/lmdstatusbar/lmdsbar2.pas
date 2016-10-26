unit lmdsbar2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  lmdextcA, lmdctrl, lmdextcS, StdCtrls, lmdstdcS, LMDCustomTrackBar,
  LMDTrackBar, LMDInformationLabel, LMDBaseMeter, LMDCustomProgressFill,
  LMDProgressFill, LMDStatusBar, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomStatusBar, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDGraphicControl, LMDTechnicalLine;

type
  TfrmDemo = class(TForm)
    Memo1: TMemo;
    LMDStatusBar1: TLMDStatusBar;
    LMDProgressFill1: TLMDProgressFill;
    LMDTrackBar1: TLMDTrackBar;
    LMDInformationLabel3: TLMDInformationLabel;
    LMDInformationLabel1: TLMDInformationLabel;
    LMDInformationLabel2: TLMDInformationLabel;
    LMDTechnicalLine1: TLMDTechnicalLine;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDTechnicalLine2: TLMDTechnicalLine;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDTechnicalLine3: TLMDTechnicalLine;
    LMDSimpleLabel3: TLMDSimpleLabel;
    procedure LMDTrackBar1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmDemo: TfrmDemo;

implementation

{$R *.DFM}

procedure TfrmDemo.LMDTrackBar1Change(Sender: TObject);
begin
  LMDProgressFill1.Position := LMDTrackBar1.Position*10;
  LMDStatusBar1.Panels[1].Text := IntToStr (LMDTrackBar1.Position);
end;

end.
