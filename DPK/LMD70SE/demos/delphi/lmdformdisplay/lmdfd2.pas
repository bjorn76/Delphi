unit lmdfd2;

interface

uses
  WinProcs, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons,
  LMDCustomGroupBox, LMDCustomButtonGroup, LMDCustomCheckGroup,
  LMDCheckGroup, LMDCustomSimpleLabel, LMDSimpleLabel,
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDSpeedButton, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDCustomLabelFill, LMDLabelFill, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  LMDCustomTrackBar, LMDTrackBar;

type
  Tt1 = class(TForm)
    LMDBackPanel1: TLMDBackPanel;
    LMDLabelFill1: TLMDLabelFill;
    LMDExplorerButton1: TLMDSpeedButton;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDCheckGroup1: TLMDCheckGroup;
    LMDTrackBar1: TLMDTrackBar;
    procedure LMDExplorerButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  t1: Tt1;

implementation

uses lmdfd4, lmdutils;

{$R *.DFM}

procedure Tt1.LMDExplorerButton1Click(Sender: TObject);
begin
  LMDShowModal(Tt3, Application);
end;

end.
