unit Starter0;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdclass, lmdformA, ExtCtrls, Tabs, StdCtrls,
  LMDStarter, LMDCustomComponent, LMDWndProcComponent,
  LMDFormStyler, LMDCustomButton, LMDButton, LMDGraphicControl,
  LMDBaseMeter, LMDCustomProgress, LMDProgress, LMDBaseGraphicButton,
  LMDCustomSpeedButton, LMDSpeedButton, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel,
  ComCtrls;

type
  Tfrmjumpdemo = class(TForm)
    note: TPageControl;
    LMDFormStyler1: TLMDFormStyler;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lmdstarter: TLMDStarter;
    lmdexe: TLMDSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    Memo: TMemo;
    progress: TLMDProgress;
    timer: TTimer;
    Label12: TLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    Label13: TLabel;
    Label14: TLabel;
    LMDButton1: TLMDButton;
    page2: TTabSheet;
    page1: TTabSheet;
    procedure LMDSimpleLabel4Click(Sender: TObject);
    procedure lmdexeClick(Sender: TObject);
    procedure timerTimer(Sender: TObject);
    procedure LMDButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmjumpdemo: Tfrmjumpdemo;
  xtimer: integer;

const
  LblFarben: array[0..9] of TColor = (clBlack, clGreen, clBlue, clNavy, clYellow, clPurple,
    clOlive, clRed, clMaroon, clWhite);

implementation

{$R *.DFM}

procedure Tfrmjumpdemo.LMDSimpleLabel4Click(Sender: TObject);
begin
  if LMDSimpleLabel4.Counter>10 then
    LMDSimpleLabel4.ResetCounter;
  LMDSimpleLabel4.Font.Color:=LblFarben[LMDSimpleLabel4.Counter mod 10];
end;

procedure Tfrmjumpdemo.lmdexeClick(Sender: TObject);
var
  IsNow: TDateTime;
  StartD, StartM, StartY, StartMin, StartSec, StartHr, dummy: Word;
begin
  memo.lines.SaveToFile(ExtractFilePath(Application.ExeName)+'test.txt');
  IsNow:=Now+(5*0.0000115);
  progress.uservalue:=5;

  DecodeTime(IsNow, StartHr, StartMin, StartSec, dummy);
  DecodeDate(IsNow, StartY, StartM, StartD);

  lmdstarter.StartTime.Day:=StartD;
  lmdstarter.StartTime.Month:=StartM;
  lmdstarter.StartTime.Year:=StartY;
  lmdstarter.StartTime.Second:=StartSec;
  lmdstarter.StartTime.Minute:=StartMin;
  lmdstarter.StartTime.Hour:=StartHr;

  lmdstarter.parameters:=ExtractFilePath(Application.ExeName)+'test.txt';
  lmdstarter.AutoStart:=True;
  xtimer:=5;
  timer.enabled:=True;
end;

procedure Tfrmjumpdemo.timerTimer(Sender: TObject);
begin
  xtimer:=xtimer-1;
  if xtimer<0 then
    timer.Enabled:=False
  else
    progress.uservalue:=xtimer;
end;

procedure Tfrmjumpdemo.LMDButton1Click(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                            mb_DefButton1 + MB_ICONQUESTION)=IDOK then
   Close
end;

end.
