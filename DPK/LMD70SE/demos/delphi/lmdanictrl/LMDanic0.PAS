{
 Demo-Program which demonstrates some features of the new
 TLMDAniCtrl component.

 Note that these components (like e.g. TLMDLImage) can only be linked
 to a TLMDImageList or LMDBitmapList. They never hold data themselves.

 
 -------------------------------------------------------------

 © 95 - 98 by LMD Innovative
}

unit LMDanic0;

interface

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Tabs, lmdclass, lmdformA,
  LMDCustomComponent, LMDWndProcComponent, LMDFormStyler, LMDCustomButton,
  LMDButton, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, LMDLImage, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel, LMDBaseGraphicControl,
  LMDGraphicControl, LMDBaseImage, LMDCustomLImage, LMDAniCtrl, LMDControl,
  LMDBaseControl, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDSpeedButton, LMDBitmapList, LMDBaseController, LMDCustomContainer,
  LMDCustomImageList, LMDImageList, LMDBaseEdit, LMDCustomEdit,
  LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit, StdCtrls, LMDTimer;

type
  Tfrmanict = class(TForm)
    LMDFormStyler1: TLMDFormStyler;
    note: TPageControl;
    LMDImageList1: TLMDImageList;
    LMDBitmapList1: TLMDBitmapList;
    f0: TLMDSpeedButton;
    f1: TLMDSpeedButton;
    ani1: TLMDAniCtrl;
    LMDSimpleLabel1: TLMDSimpleLabel;
    f3: TLMDSpeedButton;
    f2: TLMDSpeedButton;
    nr: TLMDSimpleLabel;
    ani2: TLMDAniCtrl;
    LMDSimpleLabel2: TLMDSimpleLabel;
    nr1: TLMDSimpleLabel;
    LMDSpeedButton1: TLMDSpeedButton;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSpinEdit1: TLMDSpinEdit;
    LMDSimpleLabel4: TLMDSimpleLabel;
    ani3: TLMDAniCtrl;
    nr2: TLMDSimpleLabel;
    LMDSpeedButton2: TLMDSpeedButton;
    LMDSimpleLabel5: TLMDSimpleLabel;
    ani4: TLMDAniCtrl;
    LMDSpeedButton3: TLMDSpeedButton;
    LMDBackPanel1: TLMDBackPanel;
    ani5: TLMDAniCtrl;
    LMDSpeedButton4: TLMDSpeedButton;
    LMDSimpleLabel6: TLMDSimpleLabel;
    LMDLImage1: TLMDLImage;
    LMDSimpleLabel7: TLMDSimpleLabel;
    LMDLImage2: TLMDLImage;
    LMDLImage3: TLMDLImage;
    LMDLImage4: TLMDLImage;
    LMDLImage5: TLMDLImage;
    LMDLImage6: TLMDLImage;
    LMDLImage7: TLMDLImage;
    LMDLImage8: TLMDLImage;
    ani6: TLMDAniCtrl;
    LMDSimpleLabel8: TLMDSimpleLabel;
    papa: TLMDBackPanel;
    LMDButton1: TLMDButton;
    mani: TLMDAniCtrl;
    LMDSimpleLabel9: TLMDSimpleLabel;
    LMDSimpleLabel10: TLMDSimpleLabel;
    exitbtn: TLMDButton;
    mainL: TLMDLImage;
    tp: TLMDHiTimer;
    standard: TTabSheet;
    custom: TTabSheet;
    procedure f0Click(Sender: TObject);
    procedure LMDSpeedButton1Click(Sender: TObject);
    procedure ani2Animate(Sender: TObject);
    procedure ani3Animate(Sender: TObject);
    procedure LMDSpeedButton2Click(Sender: TObject);
    procedure LMDSpeedButton3Click(Sender: TObject);
    procedure LMDSpeedButton4Click(Sender: TObject);
    procedure LMDButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure exitbtnClick(Sender: TObject);
    procedure tpTimer(Sender: TObject);
  private
    FRight:Boolean;
  public
    { Public-Deklarationen }
  end;

var
  frmanict: Tfrmanict;

implementation

{$R *.DFM}

procedure Tfrmanict.f0Click(Sender: TObject);
begin
  if sender=f0 then ani1.First
  else if sender=f1 then ani1.Prev
  else if sender=f2 then ani1.Next
  else if sender=f3 then ani1.Last;
  nr.Caption:=Inttostr(ani1.Current);
end;

procedure Tfrmanict.LMDSpeedButton1Click(Sender: TObject);
begin
  if ani2.Animate then ani2.Animate:=false;
  ani2.First;
  ani2.Repetitions:=LMDSpinEdit1.Value;
  ani2.Animate:=True;
end;

procedure Tfrmanict.ani2Animate(Sender: TObject);
begin
  nr1.Caption:=inttostr(ani2.Current);
end;

procedure Tfrmanict.ani3Animate(Sender: TObject);
begin
  nr2.Caption:=inttostr(ani3.Current);
end;

procedure Tfrmanict.LMDSpeedButton2Click(Sender: TObject);
begin
  ani3.Animate:=not ani3.Animate;
end;

procedure Tfrmanict.LMDSpeedButton3Click(Sender: TObject);
begin
  ani4.Play;
end;

procedure Tfrmanict.LMDSpeedButton4Click(Sender: TObject);
begin
  ani5.Animate:=not Ani5.Animate;
  ani6.Animate:=not Ani6.Animate;
end;

procedure Tfrmanict.LMDButton1Click(Sender: TObject);
begin
  tp.Enabled:=not tp.Enabled;
  mani.Animate:=tp.Enabled;
end;

procedure Tfrmanict.FormCreate(Sender: TObject);
begin
  FRight:=True;
  tp.Enabled:=False;
  {check size for Delphi 1...}
  {$IFNDEF WIN32}
  exitbtn.Width:=58;
  exitbtn.Height:=23;
  {$ENDIF}
end;

procedure Tfrmanict.exitbtnClick(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                            mb_DefButton1 + MB_ICONQUESTION)=IDOK then
  Close;

end;

procedure Tfrmanict.tpTimer(Sender: TObject);
begin
 if FRight then
    begin
      if mani.BoundsRect.Right<papa.Width then
        begin
          mani.Left:=mani.Left+2;
          mainL.Left:=mani.Left;
        end
      else
        FRight:=False;
    end
  else
    begin
      if mani.Left>0 then
        begin
          mani.Left:=mani.Left-2;
          mainL.Left:=mani.Left;
        end
      else
        FRight:=True;
    end;
end;

end.
