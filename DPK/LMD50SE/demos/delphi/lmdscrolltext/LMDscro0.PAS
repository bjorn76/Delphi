{
 Demo-Program which demonstrates some features the TLMDScrollText
 component.

 -------------------------------------------------------------

 © 95 - 97 by LMD Innovative
}

unit LMDscro0;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Tabs, lmdclass, lmdformA, lmdctrl, lmdstdcS,
  lmdextcA, StdCtrls, lmdextcS,Menus,lmdcont, lmdctrlA, lmdbtn, lmdstdcA,
  TabNotBk, ComCtrls, lmdcompo, lmdcctrl, LMDCustomComponent,
  LMDWndProcComponent, LMDFormStyler, LMDCustomButton, LMDButton,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, LMDBaseGraphicButton,
  LMDCustomSpeedButton, LMDSpeedButton, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDControl, LMDBaseControl, LMDBaseGraphicControl,
  LMDGraphicControl, LMDScrollText;

type
  Tfrmscrolltext = class(TForm)
    LMDFormStyler1: TLMDFormStyler;
    note: TPageControl;
    LMDBitmapList1: TLMDBitmapList;
    scroll: TLMDScrollText;
    LMDSimpleLabel1: TLMDSimpleLabel;
    f0: TLMDSpeedButton;
    f1: TLMDSpeedButton;
    ck: TCheckBox;
    LMDSimpleLabel2: TLMDSimpleLabel;
    scroll1: TLMDScrollText;
    f3: TLMDSpeedButton;
    f4: TLMDSpeedButton;
    LMDBackPanel1: TLMDBackPanel;
    scroll2: TLMDScrollText;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSpeedButton1: TLMDSpeedButton;
    exitbtn: TLMDButton;
    page1: TTabSheet;
    page2: TTabSheet;
    ck2: TCheckBox;
    procedure f0Click(Sender: TObject);
    procedure f4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LMDSpeedButton1Click(Sender: TObject);
    procedure scroll2Stop(Sender: TObject);
    procedure exitbtnClick(Sender: TObject);
    procedure ck2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmscrolltext: Tfrmscrolltext;

implementation

{$R *.DFM}

procedure Tfrmscrolltext.f0Click(Sender: TObject);
begin
  Scroll.Stop;
  if ck.Checked then
    Scroll.ScrollStyle:=ssLoopReverse
  else
    Scroll.ScrollStyle:=ssLoop;
  if sender=f0 then scroll.Direction:=sdBottomToTop
  else if sender=f1 then scroll.Direction:=sdTopToBottom;
  Scroll.Scroll:=True;
end;

procedure Tfrmscrolltext.f4Click(Sender: TObject);
begin
  Scroll1.Stop;
  if ck.Checked then
    Scroll1.ScrollStyle:=ssLoopReverse
  else
    Scroll1.ScrollStyle:=ssLoop;
  if sender=f3 then scroll1.Direction:=sdRightToLeft
  else if sender=f4 then scroll1.Direction:=sdLeftToRight;
  Scroll1.Scroll:=True;
end;

procedure Tfrmscrolltext.FormCreate(Sender: TObject);
begin
  scroll2.Lines:=scroll.Lines;
end;

procedure Tfrmscrolltext.LMDSpeedButton1Click(Sender: TObject);
begin
  scroll2.Scroll:=True;
end;

procedure Tfrmscrolltext.scroll2Stop(Sender: TObject);
begin
  scroll2.Visible:=False;
end;

procedure Tfrmscrolltext.exitbtnClick(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                            mb_DefButton1 + MB_ICONQUESTION)=IDOK then
   Close;
end;


procedure Tfrmscrolltext.ck2Click(Sender: TObject);
begin
  if ck2.Checked then
    begin
      scroll.TimerMode:=tmThreaded;
      scroll1.TimerMode:=tmThreaded;
    end
  else
    begin
      scroll.TimerMode:=tmGlobalTimer;
      scroll1.TimerMode:=tmGlobalTimer;
    end;
end;

end.
