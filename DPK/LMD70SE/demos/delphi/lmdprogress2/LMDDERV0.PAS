{LMD-Tools Version 2
 *******************

 Small demonstration for TLMDProgress and TLMDSysInfo.

 - on Windows 95/98 systems resource informations are displayed
 - resource informations are not available on Windows NT, display free memory values instead

 The progress-meters use the customizable color(small)bar - feature. Please
 check the procedure psGetColor-procedure to learn how to write them.

 The meters and labels are updated every second by using a LMDApplication-Timer.
 This feature is not document until yet, but will probably in one of the next
 interim versions.

 © 95 - 97 by LMD Innovative
 --------------------------------
}

unit Lmdderv0;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, LMDClass,
  LMDContainerComponent, LMDBaseDialog, LMDAboutDlg, LMDGraphicControl,
  LMDBaseMeter, LMDCustomProgress, LMDProgress, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel,
  Menus, LMDSysInfo, LMDCustomComponent;

type
  Tfrmresviewer = class(TForm)
    about: TLMDAboutDlg;
    s1: TLMDSimpleLabel;
    sysin: TLMDSysInfo;
    ps: TLMDProgress;
    s2: TLMDSimpleLabel;
    pu: TLMDProgress;
    s3: TLMDSimpleLabel;
    pg: TLMDProgress;
    ls: TLMDSimpleLabel;
    lu: TLMDSimpleLabel;
    lg: TLMDSimpleLabel;
    PopupMenu1: TPopupMenu;
    About1: TMenuItem;
    Exit1: TMenuItem;
    N2: TMenuItem;
    Button1: TButton;
    LMDSimpleLabel2: TLMDSimpleLabel;
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure psGetColor(Sender: TObject; nr: Byte; var aColor: TColor);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure UpdateDisplay(Sender:TObject);
  public
  end;

var
  frmresviewer: Tfrmresviewer;
  id:Word;

implementation
uses
  lmdsysin;

{$R *.DFM}

procedure Tfrmresviewer.UpdateDisplay(Sender: TObject);
var
  test:Integer;
begin
  with sysin do
    begin
      if LMDSIWindowsNT then
        begin
          If MemPhysTotal=0 then test:=0 else test:=Trunc(MemPhysFree / MemPhysTotal*100);
          ps.Position:=test;
          ls.Caption:=IntToStr(test)+'%';
          If MemPageTotal=0 then test:=0 else test:=Trunc(MemPageFree / MemPageTotal*100);
          pu.Position:=test;
          lu.Caption:=IntToStr(test)+'%';
          If MemVirtTotal=0 then test:=0 else test:=Trunc(MemVirtFree / MemVirtTotal*100);
          pg.Position:=test;
          lg.Caption:=IntToStr(test)+'%';
        end
      else
        begin
          ps.Position:=FreeSys;
          ls.Caption:=FreeSysRes;
          pu.Position:=FreeUSR;
          lu.Caption:=FreeUsrRes;
          pg.Position:=FreeGDI;
          lg.Caption:=FreeGDIRes;
        end;
    end;
end;

procedure Tfrmresviewer.Exit1Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmresviewer.About1Click(Sender: TObject);
begin
  about.Execute;
end;

procedure Tfrmresviewer.FormCreate(Sender: TObject);
begin

  if LMDSIWindowsNT then
    begin
       s1.Caption:='Free physical memory:';
       s2.Caption:='Free page memory:';
       s3.Caption:='Free virtual memory:';
       Caption:='Memory Viewer';
    end;

  {This is an undocumented feature: The TLMDApplication-object owns
   a TimerPool to control all timers need by LMD-components. We simply
   add an additional timer for our needs}
  UpdateDisplay(nil);
  id:=LMDApplication.AddTimer(1000, UpdateDisplay);


end;

procedure Tfrmresviewer.psGetColor(Sender: TObject; nr: Byte;
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

procedure Tfrmresviewer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // remove our timerid
  LMDApplication.RemoveTimer(ID);
end;

end.
