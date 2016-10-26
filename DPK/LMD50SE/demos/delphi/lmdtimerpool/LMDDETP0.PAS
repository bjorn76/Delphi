{
Demo-Program for TLMDTimerPool
******************************

TLMDTimerpool is a small component with the purpose to share one timer for
multiple Tasks. You add new timer items at runtime by using the AddTimer or
AddTimerExt method. Please check the helpfile for all features of this
versatile control.

© 95 - 97 by LMD Innovative
}


unit Lmddetp0;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdctrl, lmdstdcS, lmdnonvS, lmdclass, lmdgraph,
  StdCtrls, Lmdled, lmdextcS, lmdmmS, lmdcont, lmdcompo, LMDWaveComp,
  LMDCustomComponent, LMDDrawEdge, LMDCustomSimpleLabel, LMDSimpleLabel,
  LMDGraphicControl, LMDLEDCustomLabel, LMDLEDLabel, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDLabel;

type
  Tfrmtimerpool = class(TForm)
    tp: TLMDTimerPool;
    rl: TLMDLabel;
    Bounce: TLMDLabel;
    lel: TLMDLEDLabel;
    LMDSimpleLabel1: TLMDSimpleLabel;
    bstart: TButton;
    bStop: TButton;
    LMDDrawEdge1: TLMDDrawEdge;
    lmdwave: TLMDWaveComp;
    LMDSimpleLabel2: TLMDSimpleLabel;
    rlb: TLMDSimpleLabel;
    Button1: TButton;
    LMDDrawEdge2: TLMDDrawEdge;
    Button4: TButton;
    procedure tpTimer(Sender: TObject; Ident: Word; Counter: Longint);
    procedure FormCreate(Sender: TObject);
    procedure bstartClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure FireMe(Sender:TObject);
  public
  end;

var
  frmtimerpool: Tfrmtimerpool;
  myCounter:Byte;

const
  myTimer1=10;
  myTimer2=11;
  myTimer3=12;
  myTimer4=13;
  myTimer5=14;

implementation

{$R *.DFM}

procedure Tfrmtimerpool.tpTimer(Sender: TObject; Ident: Word; Counter: Longint);
begin
  case Ident of
    {Standard using of event}
    myTimer1:if rl.FontFx.Angle<360 then rl.FontFx.Angle:=rl.FontFx.Angle+10 else rl.FontFx.Angle:=0;
    myTimer2:
      begin
        bounce.Alignment:=TLMDAlignment(MyCounter);
        if myCounter<8 then inc(MyCounter) else myCounter:=0;
      end;
    {using the Counter}
    myTimer3:lel.Value:=Counter;
    myTimer5:if rlb.Left+rlb.Width<ClientWidth then rlb.Left:=rlb.Left+10 else rlb.Left:=-rlb.Width;
  end;
end;

procedure Tfrmtimerpool.FormCreate(Sender: TObject);
begin
  myCounter:=0;
  tp.AddTimer(myTimer1, 100, nil);
  tp.AddTimer(myTimer2, 500, nil);  {if parameter for procedure is nil, standard timer event
                                     of the TLMDTimerPoolComponent is used}
  tp.AddTimerExt(myTimer3, 100, -1, false, nil);  {this timer is not enabled at once}

  tp.AddTimerExt(myTimer4, 3000, 1, false, FireMe); {demonstration for method pointer}
  tp.AddTimer(myTimer5, 200, nil);
end;

procedure Tfrmtimerpool.bstartClick(Sender: TObject);
begin
  tp.Timer[myTimer3].Enabled:=(Sender=bStart);     {Runtime enabling/disabling of single timer}
end;

procedure Tfrmtimerpool.FireMe(Sender:TObject);
begin
  lmdwave.Play;
  button1.Enabled:=True;
end;

procedure Tfrmtimerpool.Button1Click(Sender: TObject);
begin
  tp.Timer[myTimer4].Enabled:=True;
  button1.Enabled:=False;
end;

procedure Tfrmtimerpool.Button4Click(Sender: TObject);
begin
  Close;
end;

end.
