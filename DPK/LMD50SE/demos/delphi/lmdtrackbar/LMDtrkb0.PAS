{
 Demo-Program for some extended features of TLMDTrackBar


 -------------------------------------------------------------
 © 95 - 97 by LMD Innovative
}

unit LMDtrkb0;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Tabs, lmdclass, lmdformA, lmdctrl, lmdstdcS,
  lmdextcA, StdCtrls, lmdextcS,Menus,lmdcont, lmdctrlA, lmdbtn,
  ComCtrls, lmdcompo, lmdcctrl, LMDCustomComponent, LMDWndProcComponent,
  LMDFormStyler, LMDCustomButton, LMDButton, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, LMDCustomControl, LMDCustomPanel,
  LMDCustomTrackBar, LMDTrackBar, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel;

type
  Tfrmtrackbar = class(TForm)
    page2: TPageControl;
    LMDFormStyler1: TLMDFormStyler;
    LMDBitmapList1: TLMDBitmapList;
    exitbtn: TLMDButton;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDTrackBar8: TLMDTrackBar;
    LMDTrackBar9: TLMDTrackBar;
    LMDTrackBar10: TLMDTrackBar;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDTrackBar11: TLMDTrackBar;
    LMDTrackBar12: TLMDTrackBar;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDTrackBar1: TLMDTrackBar;
    sl: TLMDSimpleLabel;
    LMDTrackBar5: TLMDTrackBar;
    LMDTrackBar4: TLMDTrackBar;
    LMDTrackBar3: TLMDTrackBar;
    LMDTrackBar6: TLMDTrackBar;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDTrackBar2: TLMDTrackBar;
    LMDTrackBar7: TLMDTrackBar;
    page1: TTabSheet;
    TabSheet1: TTabSheet;
    LMDBackPanel1: TLMDBackPanel;
    LMDTrackBar13: TLMDTrackBar;
    LMDTrackBar14: TLMDTrackBar;
    LMDSimpleLabel6: TLMDSimpleLabel;
    procedure LMDTrackBar11DrawTick(Sender: TObject; aCanvas: TCanvas;
      aValue: Integer; pos: TPoint);
    procedure LMDTrackBar12DrawTick(Sender: TObject; aCanvas: TCanvas;
      aValue: Integer; pos: TPoint);
    procedure exitbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmtrackbar: Tfrmtrackbar;

implementation

{$R *.DFM}

procedure Tfrmtrackbar.LMDTrackBar11DrawTick(Sender: TObject;
  aCanvas: TCanvas; aValue: Integer; pos: TPoint);
begin
  aCanvas.Brush.Style:=bsSolid;
  aCanvas.Brush.Color:=clNavy;
  aCanvas.Ellipse(pos.X, pos.Y, pos.X+4,pos.Y+4);
end;

procedure Tfrmtrackbar.LMDTrackBar12DrawTick(Sender: TObject;
  aCanvas: TCanvas; aValue: Integer; pos: TPoint);
begin
  aCanvas.Brush.Style:=bsSolid;
  aCanvas.Brush.Color:=clMaroon;
  aCanvas.Rectangle(pos.X, pos.Y, pos.X+4,pos.Y+4);
end;

procedure Tfrmtrackbar.exitbtnClick(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                            mb_DefButton1 + MB_ICONQUESTION)=IDOK then
   Close;
end;

end.
