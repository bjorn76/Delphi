{
Demo-Program for TLMDDrawEdge
*****************************

This small demo demonstrates the different styles of a TLMDDrawEdge component.

© 95 - 97 by LMD Innovative
}

unit Lmddede0;

interface

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Tabs, lmdclass, StdCtrls, lmdextcS, lmdstdcS,
  lmdctrl, lmdbtn, LMDCustomButton, LMDButton, LMDCustomLabel, LMDLabel,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel, LMDControl, LMDDrawEdge;

type
  Tfrmdrawedge = class(TForm)
    note: TPageControl;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDDrawEdge2: TLMDDrawEdge;
    LMDDrawEdge3: TLMDDrawEdge;
    LMDDrawEdge7: TLMDDrawEdge;
    LMDDrawEdge8: TLMDDrawEdge;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDDrawEdge10: TLMDDrawEdge;
    LMDDrawEdge11: TLMDDrawEdge;
    LMDDrawEdge12: TLMDDrawEdge;
    LMDDrawEdge13: TLMDDrawEdge;
    LMDDrawEdge14: TLMDDrawEdge;
    LMDDrawEdge15: TLMDDrawEdge;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDSimpleLabel6: TLMDSimpleLabel;
    LMDSimpleLabel7: TLMDSimpleLabel;
    LMDDrawEdge4: TLMDDrawEdge;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDSimpleLabel9: TLMDSimpleLabel;
    LMDSimpleLabel10: TLMDSimpleLabel;
    LMDSimpleLabel11: TLMDSimpleLabel;
    LMDSimpleLabel12: TLMDSimpleLabel;
    LMDSimpleLabel13: TLMDSimpleLabel;
    LMDSimpleLabel14: TLMDSimpleLabel;
    LMDSimpleLabel15: TLMDSimpleLabel;
    LMDDrawEdge5: TLMDDrawEdge;
    LMDSimpleLabel16: TLMDSimpleLabel;
    LMDDrawEdge6: TLMDDrawEdge;
    LMDSimpleLabel17: TLMDSimpleLabel;
    LMDDrawEdge9: TLMDDrawEdge;
    LMDSimpleLabel18: TLMDSimpleLabel;
    LMDDrawEdge16: TLMDDrawEdge;
    LMDSimpleLabel19: TLMDSimpleLabel;
    LMDDrawEdge17: TLMDDrawEdge;
    LMDSimpleLabel20: TLMDSimpleLabel;
    LMDDrawEdge18: TLMDDrawEdge;
    LMDSimpleLabel21: TLMDSimpleLabel;
    LMDDrawEdge19: TLMDDrawEdge;
    LMDSimpleLabel22: TLMDSimpleLabel;
    LMDDrawEdge20: TLMDDrawEdge;
    LMDSimpleLabel23: TLMDSimpleLabel;
    LMDDrawEdge21: TLMDDrawEdge;
    LMDDrawEdge22: TLMDDrawEdge;
    LMDSimpleLabel24: TLMDSimpleLabel;
    LMDSimpleLabel25: TLMDSimpleLabel;
    LMDSimpleLabel26: TLMDSimpleLabel;
    LMDLabel1: TLMDLabel;
    LMDDrawEdge23: TLMDDrawEdge;
    LMDSimpleLabel27: TLMDSimpleLabel;
    LMDDrawEdge24: TLMDDrawEdge;
    LMDSimpleLabel28: TLMDSimpleLabel;
    LMDDrawEdge25: TLMDDrawEdge;
    LMDSimpleLabel29: TLMDSimpleLabel;
    LMDDrawEdge26: TLMDDrawEdge;
    LMDSimpleLabel30: TLMDSimpleLabel;
    LMDSimpleLabel34: TLMDSimpleLabel;
    LMDDrawEdge30: TLMDDrawEdge;
    LMDSimpleLabel35: TLMDSimpleLabel;
    LMDDrawEdge27: TLMDDrawEdge;
    LMDSimpleLabel31: TLMDSimpleLabel;
    LMDDrawEdge28: TLMDDrawEdge;
    LMDSimpleLabel32: TLMDSimpleLabel;
    exitbtn: TLMDButton;
    page1: TTabSheet;
    pag2: TTabSheet;
    pag3: TTabSheet;
    procedure exitbtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmdrawedge: Tfrmdrawedge;

implementation

{$R *.DFM}

procedure Tfrmdrawedge.exitbtnClick(Sender: TObject);
begin
if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                                 mb_DefButton1 + MB_ICONQUESTION)=IDOK then
       Close;
end;

procedure Tfrmdrawedge.FormCreate(Sender: TObject);
begin
  {check size for Delphi 1...}
  {$IFNDEF WIN32}
  exitbtn.Width:=58;
  exitbtn.Height:=23;
  {$ENDIF}
end;

end.
