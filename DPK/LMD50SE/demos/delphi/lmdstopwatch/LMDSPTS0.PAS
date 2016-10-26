{
 Speed-Test Demo

 Compares speed of repaints from Standard- and LMD- components by using
 stopwatch methods of LMDApplication variable.
 ------------------------------------------------------------------------------

 © 95 - 97 by LMD Innovative
}

unit Lmdspts0;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, lmdclass, lmdmmS, lmdctrl, lmdstdcS, lmdextcA,
  Gauges, lmdstdcA, TabNotBk, lmdextcS, Spin, lmdbtn, lmdnonvS, ComCtrls,
  lmdcompo, LMDCustomComponent, LMDStopWatch, LMDCustomButton, LMDButton,
  LMDCustomProgressFill, LMDProgressFill, LMDGraphicControl, LMDBaseMeter,
  LMDCustomProgress, LMDProgress, LMDDrawEdge, LMDCustomLabelFill,
  LMDLabelFill, LMDCustomLabel, LMDLabel, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel;

type
  Tfrmsptst = class(TForm)
    TabbedNotebook1: TPageControl;
    Button1: TButton;
    lmdlabel1: TLMDSimpleLabel;
    Label1: TLabel;
    LMDLabel2: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDLabel4: TLMDLabel;
    LMDLabelFill1: TLMDLabelFill;
    tim1: TLabel;
    tim2: TLabel;
    tim3: TLabel;
    tim4: TLabel;
    tim5: TLabel;
    tim6: TLabel;
    Gauge1: TGauge;
    p1: TLMDProgress;
    p2: TLMDProgress;
    p3: TLMDProgressFill;
    p4: TLMDProgressFill;
    gtim1: TLabel;
    gtim2: TLabel;
    gtim3: TLabel;
    gtim4: TLabel;
    gtim5: TLabel;
    Button2: TButton;
    CheckBox1: TCheckBox;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDDrawEdge2: TLMDDrawEdge;
    LMDSimpleLabel1: TLMDSimpleLabel;
    t2: TLMDSimpleLabel;
    t1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    SpinEdit1: TLMDSpinEdit;
    exitbtn: TLMDButton;
    stpw: TLMDStopWatch;
    page2: TTabSheet;
    page3: TTabSheet;
    page1: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure exitbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmsptst: Tfrmsptst;

implementation
{$R *.DFM}

var
  target:Integer;

procedure Tfrmsptst.Button1Click(Sender: TObject);
var
  i:Integer;

begin

  screen.Cursor:=crHourGlass;
  button1.Enabled:=False;

  stpw.Control:=tim1;stpw.Suffix:=' s (Delphi Standard Label)';
  stpw.Start;
  for i:=0 to target do begin Label1.Caption:=Inttostr(i);Label1.Refresh; end;
  stpw.Stop;

  stpw.Control:=tim2;stpw.Suffix:=' s (LMD-Tools Simple Label)';
  stpw.Start;
  for i:=0 to target do begin lmdLabel1.Caption:=Inttostr(i);lmdLabel1.Refresh; end;
  stpw.Stop;

  stpw.Control:=tim3;stpw.Suffix:='s (LMD-Tools Label)';
  stpw.Start;
  for i:=0 to target do begin lmdLabel2.Caption:=Inttostr(i);lmdLabel2.Refresh; end;
  stpw.Stop;

  stpw.Control:=tim4;stpw.Suffix:='s (LMD-Tools Label 3D)';
  stpw.Start;
  for i:=0 to target do begin lmdLabel3.Caption:=Inttostr(i);lmdLabel3.Refresh; end;
  stpw.Stop;

  stpw.Control:=tim5;stpw.Suffix:='s (LMD-Tools Label 3D/rot)';
  stpw.Start;
  for i:=0 to target do begin lmdLabel4.Caption:=Inttostr(i);lmdLabel4.Refresh; end;
  stpw.Stop;

  stpw.Control:=tim6;stpw.Suffix:='s (LMD-Tools Fill-Label)';
  stpw.Start;
  for i:=0 to target do begin lmdLabelfill1.Caption:=Inttostr(i);lmdLabelfill1.Refresh; end;
  stpw.Stop;

  button1.Enabled:=True;
  screen.Cursor:=crDefault;
end;



procedure Tfrmsptst.Button2Click(Sender: TObject);
var
  i:Integer;

begin

  screen.Cursor:=crHourGlass;
  button2.Enabled:=False;
  gauge1.MaxValue:=Target;
  p1.MaxValue:=Target;
  p2.MaxValue:=Target;
  p3.MaxValue:=Target;
  p4.MaxValue:=Target;

  stpw.Control:=gtim1;stpw.Suffix:='s - TGauge (Delphi Samples)';
  stpw.Start;for i:=0 to target do gauge1.Progress:=i;stpw.Stop;

  stpw.Control:=gtim2;stpw.Suffix:='s - TLMDProgress (SmallBar)';
  stpw.Start;for i:=0 to target do p1.UserValue:=i;stpw.Stop;

  stpw.Control:=gtim3;stpw.Suffix:='s - TLMDProgress (Bar)';
  stpw.Start;for i:=0 to target do p2.UserValue:=i;stpw.Stop;

  stpw.Control:=gtim4;stpw.Suffix:='s - TLMDProgressFill (Gradient)';
  stpw.Start;for i:=0 to target do p3.UserValue:=i;stpw.Stop;

  stpw.Control:=gtim5;stpw.Suffix:='s - TLMDProgressFill (Bitmap)';
  stpw.Start;for i:=0 to target do p4.UserValue:=i;stpw.Stop;

  button2.Enabled:=True;
  screen.Cursor:=crDefault;

end;

procedure Tfrmsptst.CheckBox1Click(Sender: TObject);
begin
  Label1.AutoSize:=CheckBox1.Checked;
  LMDLabel1.AutoSize:=Label1.AutoSize;
  LMDLabel2.AutoSize:=Label1.AutoSize;
  LMDLabel3.AutoSize:=Label1.AutoSize;
  LMDLabel4.AutoSize:=Label1.AutoSize;
  lmdlabelFill1.AutoSize:=Label1.AutoSize;
end;

procedure Tfrmsptst.SpinEdit1Change(Sender: TObject);
begin
  target:=SpinEdit1.Value;
  t1.Caption:='['+Inttostr(target)+']';
  t2.Caption:=t1.Caption;
end;

procedure Tfrmsptst.FormCreate(Sender: TObject);
begin
  target:=100;
  {check size for Delphi 1...}
  {$IFNDEF WIN32}
  exitbtn.Width:=58;
  exitbtn.Height:=23;
  {$ENDIF}
end;

procedure Tfrmsptst.exitbtnClick(Sender: TObject);
begin
  Close;
end;

end.
