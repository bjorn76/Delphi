{
 Demo-Program for TLMDShape-Controls
 -----------------------------------

 © 95, 96 by LMD Innovative
}

unit lmddesp0;

interface

uses
  Windows, ComCtrls, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  lmdclass, lmdformA, ExtCtrls, lmdshapA, lmdgrapA, lmdctrl, StdCtrls,
  Spin,lmdextcS, lmdstdcS, lmdextcA, lmdstdcA, lmdbtn, lmdcompo,
  LMDCustomComponent, LMDWndProcComponent, LMDFormStyler, LMDCustomButton,
  LMDButton, LMDRepeatedShape, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseShape, LMDShapeControl, LMDShape;

type
  Tfrmshape = class(TForm)
    LMDFormStyler1: TLMDFormStyler;
    exitbtn: TLMDButton;
    note: TPageControl;
    page1: TTabSheet;
    LMDShapeLabel8: TLMDShapeControl;
    LMDShapeControl1: TLMDShapeControl;
    LMDShapeControl2: TLMDShapeControl;
    LMDShapeControl3: TLMDShapeControl;
    LMDShapeControl4: TLMDShapeControl;
    LMDShapeControl5: TLMDShapeControl;
    LMDShapeControl6: TLMDShapeControl;
    LMDShapeControl7: TLMDShapeControl;
    LMDShapeControl8: TLMDShapeControl;
    LMDShapeControl9: TLMDShapeControl;
    LMDShapeControl10: TLMDShapeControl;
    LMDShapeControl11: TLMDShapeControl;
    LMDShapeControl12: TLMDShapeControl;
    LMDShapeControl13: TLMDShapeControl;
    LMDShapeControl14: TLMDShapeControl;
    LMDShapeControl15: TLMDShapeControl;
    LMDShapeControl18: TLMDShapeControl;
    LMDShapeControl16: TLMDShapeControl;
    LMDShapeControl17: TLMDShapeControl;
    LMDShapeControl19: TLMDShapeControl;
    LMDShapeControl20: TLMDShapeControl;
    LMDShapeControl21: TLMDShapeControl;
    LMDShapeControl22: TLMDShapeControl;
    page2: TTabSheet;
    LMDTeethShapeLabel1: TLMDShapeControl;
    LMDShapeLabel1: TLMDShapeControl;
    LMDShapeLabel2: TLMDShapeControl;
    LMDShapeLabel5: TLMDShapeControl;
    LMDShapeLabel7: TLMDShapeControl;
    LMDShapeLabel10: TLMDShapeControl;
    page3: TTabSheet;
    LMDShapeLabel11: TLMDShapeControl;
    LMDTeethShapeLabel2: TLMDShapeControl;
    LMDShapeLabel12: TLMDShapeControl;
    LMDShapeLabel13: TLMDShapeControl;
    LMDShapeLabel14: TLMDShapeControl;
    LMDShapeLabel15: TLMDShapeControl;
    LMDShapeLabel16: TLMDShapeControl;
    page4: TTabSheet;
    LMDRepeatedShape1: TLMDRepeatedShape;
    procedure exitbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmshape: Tfrmshape;

implementation

const
   stylenames:array[TLMDShapeType] of string=
               ('stEllipse','stRectangle','stRoundRect','stDirectUp','stDirectRight',
                 'stDirectDown','stDirectLeft','stDiamond','stComb','stOctagon','stStar');
{$R *.DFM}

procedure Tfrmshape.exitbtnClick(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                             mb_DefButton1 + MB_ICONQUESTION)=IDOK then
    Close;
end;

end.
