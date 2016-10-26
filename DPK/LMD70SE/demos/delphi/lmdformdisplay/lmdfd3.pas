unit lmdfd3;

interface

uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons,
  LMDCustomButtonGroup, LMDCustomRadioGroup, LMDRadioGroup, LMDBaseMeter,
  LMDCustomProgress, LMDProgress, LMDGraphicControl, LMDBaseGraphicButton,
  LMDCustomShapeButton, LMDShapeButton, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDControl, LMDBaseControl, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomLabel, LMDCustomLabelFill, LMDLabelFill,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, LMDBaseEdit, LMDCustomEdit,
  LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit, LMDClock,
  LMDCustomGroupBox;

type
  Tt2 = class(TForm)
    LMDBackPanel1: TLMDBackPanel;
    LMDLabelFill1: TLMDLabelFill;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSpinEdit1: TLMDSpinEdit;
    LMDShapeLabelButton1: TLMDShapeButton;
    Label1: TLabel;
    LMDClock1: TLMDClock;
    LMDRadioGroup1: TLMDRadioGroup;
    LMDProgress1: TLMDProgress;
    procedure BitBtn1Click(Sender: TObject);
    procedure LMDShapeLabelButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  t2: Tt2;

implementation

uses lmdfd4, lmdutils;

{$R *.DFM}

procedure Tt2.BitBtn1Click(Sender: TObject);
begin
  LMDShowModal(Tt3, Application);
end;

procedure Tt2.LMDShapeLabelButton1Click(Sender: TObject);
begin
  LMDShowModal(Tt3, Application);
end;

end.
