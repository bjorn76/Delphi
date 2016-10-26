{
 Demo-Program for TLMDProgress and TLMDProgressFill
 --------------------------------------------------

 © 95 - 97 by LMD Innovative
}

unit Lmddepr0;

interface

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Tabs, lmdclass, lmdformA,
  LMDCustomButton, LMDButton, LMDCustomProgressFill,
  LMDProgressFill, LMDDrawEdge, LMDGraphicControl, LMDBaseMeter,
  LMDCustomProgress, LMDProgress, LMDCustomLabel, LMDLabel,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDCustomGroupBox, LMDGroupBox, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel, StdCtrls;

type
  Tfrmprg = class(TForm)
    note: TPageControl;
    LMDSimpleLabel10: TLMDSimpleLabel;
    ScrollBar2: TScrollBar;
    LMDSimpleLabel1: TLMDSimpleLabel;
    ScrollBar1: TScrollBar;
    exitbtn: TLMDButton;
    LMDGroupBox1: TLMDGroupBox;
    LMDLabel1: TLMDLabel;
    p2: TLMDProgress;
    LMDSimpleLabel2: TLMDSimpleLabel;
    p3: TLMDProgress;
    p4: TLMDProgress;
    p5: TLMDProgress;
    p1: TLMDProgress;
    LMDSimpleLabel4: TLMDSimpleLabel;
    p6: TLMDProgress;
    p7: TLMDProgress;
    LMDSimpleLabel5: TLMDSimpleLabel;
    Memo1: TMemo;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDDrawEdge2: TLMDDrawEdge;
    LMDGroupBox2: TLMDGroupBox;
    p10: TLMDProgressFill;
    p11: TLMDProgressFill;
    p12: TLMDProgressFill;
    LMDSimpleLabel6: TLMDSimpleLabel;
    LMDSimpleLabel7: TLMDSimpleLabel;
    p13: TLMDProgressFill;
    p14: TLMDProgressFill;
    p15: TLMDProgressFill;
    p17: TLMDProgressFill;
    LMDSimpleLabel8: TLMDSimpleLabel;
    p16: TLMDProgressFill;
    LMDLabel2: TLMDLabel;
    page1: TTabSheet;
    page2: TTabSheet;
    procedure ScrollBar1Change(Sender: TObject);
    procedure p7GetColor(Sender: TObject; nr: Byte; var aColor: TColor);
    procedure p4GetColor(Sender: TObject; nr: Byte; var aColor: TColor);
    procedure exitbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmprg: Tfrmprg;

implementation

{$R *.DFM}

procedure Tfrmprg.ScrollBar1Change(Sender: TObject);
begin
  with TScrollBar(sender) do
    if sender=scrollbar1 then
      begin
        p1.position:=position;
        p2.position:=position;
        p3.position:=position;
        p4.position:=position;
        p5.position:=position;
        p6.position:=position;
        p7.position:=position;
      end
    else
      begin
        p10.position:=position;
        p11.position:=position;
        p12.position:=position;
        p13.position:=position;
        p14.position:=position;
        p15.position:=position;
        p16.position:=position;
        p17.position:=position;
      end
end;

procedure Tfrmprg.p7GetColor(Sender: TObject; nr: Byte;
  var aColor: TColor);
begin
  case nr of
    0..4:  aColor:=clMaroon;
    5..14: aColor:=clRed;
    15..35: aColor:=clYellow;
    36..45: aColor:=clLime;
    46..49: aColor:=clGreen;
  end;
end;

procedure Tfrmprg.p4GetColor(Sender: TObject; nr: Byte;
  var aColor: TColor);
begin
  case nr of
    0..9:  aColor:=clBlack;
    10..19: aColor:=clNavy;
    20..29: aColor:=clBlue;
    30..39: aColor:=clWhite;
  end;

end;

procedure Tfrmprg.exitbtnClick(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                             mb_DefButton1 + MB_ICONQUESTION)=IDOK then
   Close;
end;

end.
