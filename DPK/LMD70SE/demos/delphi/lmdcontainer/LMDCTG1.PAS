unit Lmdctg1;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,
  LMDClass, LMDFormA, StdCtrls,
  lmdcont, LMDFormStyler, LMDCustomComponent,
  LMDWndProcComponent, LMDCustomFormFill, LMDBack, LMDGraphicControl,
  LMDBaseImage, LMDCustomLImage, LMDLImage, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel, LMDControl,
  LMDBaseControl, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDSpeedButton, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtSpinEdit,
  LMDSpinEdit, LMDCustomParentPanel, LMDCustomGroupBox, LMDGroupBox,
  LMDFormFill;

type
  TCont1 = class(TForm)
    LMDBack1: TLMDBack;
    LMDSpinEdit1: TLMDSpinEdit;
    spb: TLMDSpeedButton;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDLImage1: TLMDLImage;
    LMDExplorerButton4: TLMDSpeedButton;
    LMDFormStyler1: TLMDFormStyler;
    procedure LMDSpinEdit1Change(Sender: TObject);
    procedure LMDExplorerButton4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Cont1: TCont1;

implementation

uses lmdctg4;

{$R *.DFM}

procedure TCont1.LMDSpinEdit1Change(Sender: TObject);
begin
  spb.ImageIndex:=LMDSpinEdit1.Value;
  LMDLImage1.ImageIndex:=LMDSpinEdit1.Value;
end;

procedure TCont1.LMDExplorerButton4Click(Sender: TObject);
begin
  Close;
end;

procedure TCont1.FormActivate(Sender: TObject);
begin
  LMDSpinEdit1.MaxValue:=Pred(data.iml.Items[0].Count);
  LMDSpinEdit1Change(nil);
end;

end.
