{
 Demo-Program for Label components
 ---------------------------------


 © 95 - 97 by LMD Innovative
}

unit Lmddelb0;

interface

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,
  LMDWndProcComponent, LMDFormStyler, LMDFill, LMDLEDCustomLabel,
  LMDLEDLabel, LMDGraphicControl, LMDTechnicalLine, LMDCustomLabel,
  LMDLabel, LMDDrawEdge, LMDControl, LMDBaseControl, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel,
  LMDCustomGroupBox, LMDGroupBox, LMDCustomButton, LMDButton,
  LMDCustomComponent, StdCtrls;

type
  Tfrmlabel = class(TForm)
    LMDFormStyler1: TLMDFormStyler;
    LMDButton1: TLMDButton;
    note: TPageControl;
    LMDLabel1: TLMDLabel;
    LMDLabel2: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDLabel4: TLMDLabel;
    LMDLabel5: TLMDLabel;
    LMDLabel6: TLMDLabel;
    LMDLabel7: TLMDLabel;
    LMDLabel8: TLMDLabel;
    LMDLabel9: TLMDLabel;
    LMDTechnicalLine1: TLMDTechnicalLine;
    LMDLEDLabel1: TLMDLEDLabel;
    LMDLabel10: TLMDLabel;
    LMDLEDLabel2: TLMDLEDLabel;
    LMDLEDLabel4: TLMDLEDLabel;
    LMDSimpleLabel26: TLMDSimpleLabel;
    LMDLEDLabel5: TLMDLEDLabel;
    LMDLEDLabel7: TLMDLEDLabel;
    LMDLEDLabel8: TLMDLEDLabel;
    LMDLEDLabel9: TLMDLEDLabel;
    LMDLEDLabel10: TLMDLEDLabel;
    LMDFill1: TLMDFill;
    LMDLEDLabel6: TLMDLEDLabel;
    Label1: TLabel;
    Label2: TLabel;
    LMDSimpleLabel37: TLMDSimpleLabel;
    LMDGroupBox1: TLMDGroupBox;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDSimpleLabel6: TLMDSimpleLabel;
    LMDSimpleLabel7: TLMDSimpleLabel;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDSimpleLabel9: TLMDSimpleLabel;
    LMDSimpleLabel10: TLMDSimpleLabel;
    LMDSimpleLabel11: TLMDSimpleLabel;
    LMDSimpleLabel12: TLMDSimpleLabel;
    LMDSimpleLabel36: TLMDSimpleLabel;
    LMDSimpleLabel35: TLMDSimpleLabel;
    LMDSimpleLabel34: TLMDSimpleLabel;
    LMDSimpleLabel33: TLMDSimpleLabel;
    LMDGroupBox2: TLMDGroupBox;
    LMDGroupBox3: TLMDGroupBox;
    LMDSimpleLabel14: TLMDSimpleLabel;
    LMDSimpleLabel15: TLMDSimpleLabel;
    LMDSimpleLabel16: TLMDSimpleLabel;
    LMDSimpleLabel19: TLMDSimpleLabel;
    LMDSimpleLabel20: TLMDSimpleLabel;
    LMDSimpleLabel21: TLMDSimpleLabel;
    LMDSimpleLabel22: TLMDSimpleLabel;
    LMDSimpleLabel23: TLMDSimpleLabel;
    LMDSimpleLabel24: TLMDSimpleLabel;
    LMDSimpleLabel25: TLMDSimpleLabel;
    LMDTechnicalLine2: TLMDTechnicalLine;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDSimpleLabel13: TLMDSimpleLabel;
    LMDDrawEdge2: TLMDDrawEdge;
    LMDSimpleLabel17: TLMDSimpleLabel;
    LMDDrawEdge3: TLMDDrawEdge;
    exitbtn: TLMDButton;
    page1: TTabSheet;
    page2: TTabSheet;
    page3: TTabSheet;
    procedure exitbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmlabel: Tfrmlabel;

implementation

{$R *.DFM}

procedure Tfrmlabel.exitbtnClick(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                             mb_DefButton1 + MB_ICONQUESTION)=IDOK then
   Close;
end;

end.
