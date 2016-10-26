{
 Demo-Program which demonstrates some features of the
 global TLMDApplication component.

 -------------------------------------------------------------
 © 95 - 97 by LMD Innovative
}

unit Lmdappl0;

interface

uses
  Windows, ComCtrls,   Forms, Dialogs, StdCtrls,
  SysUtils, Messages, Classes, Graphics, Controls,
  LMDWndProcComponent, LMDFormStyler, LMDCustomComponent, LMDWaveComp, LMDProcs,
  LMDClass, LMDCustomButton, LMDButton, LMDDrawEdge, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel,
  LMDIniCtrl, ExtCtrls, LMDApplicationCtrl;

type
  TLMDApplForm = class(TForm)
    ButtonBook: TPageControl;
    LMDSimpleLabel4: TLMDSimpleLabel;
    Image2: TImage;
    LMDSimpleLabel7: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDDrawEdge12: TLMDDrawEdge;
    LMDDrawEdge3: TLMDDrawEdge;
    LMDSimpleLabel1: TLMDSimpleLabel;
    Image3: TImage;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    lmdwave: TLMDWaveComp;
    PlayBtn: TLMDButton;
    LMDSimpleLabel6: TLMDSimpleLabel;
    LMDSimpleLabel11: TLMDSimpleLabel;
    LMDSimpleLabel13: TLMDSimpleLabel;
    LMDSimpleLabel14: TLMDSimpleLabel;
    Memo1: TMemo;
    btnCreate: TLMDButton;
    btnLoad: TLMDButton;
    LMDSimpleLabel15: TLMDSimpleLabel;
    LMDFormStyler1: TLMDFormStyler;
    LMDSimpleLabel12: TLMDSimpleLabel;
    log2: TLMDButton;
    LMDButton3: TLMDButton;
    log: TMemo;
    ed: TEdit;
    LMDApplicationCtrl1: TLMDApplicationCtrl;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDSimpleLabel9: TLMDSimpleLabel;
    LMDSimpleLabel10: TLMDSimpleLabel;
    r1: TRadioButton;
    r2: TRadioButton;
    LMDButton2: TLMDButton;
    LMDSimpleLabel16: TLMDSimpleLabel;
    exitbtn: TLMDButton;
    page1: TTabSheet;
    page2: TTabSheet;
    page3: TTabSheet;
    page4: TTabSheet;
    page5: TTabSheet;
    procedure LMD3DCaptionButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PlayBtnClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure LMDButton1Click(Sender: TObject);
    procedure log2Click(Sender: TObject);
    procedure LMDButton3Click(Sender: TObject);
    procedure LMDApplicationCtrl1Exception(Sender: TObject; E: Exception;
      var Cancel: Boolean);
    procedure LMDButton2Click(Sender: TObject);
    procedure exitbtnClick(Sender: TObject);
  private
    {the handler for a TNotifyEvent}
    procedure TimerExpired(Sender:TObject);
  public

  end;

var
  LMDApplForm: TLMDApplForm;

  {required for global timerpool}
  FTimerID:Word;

implementation

{$R *.DFM}

procedure TLMDApplForm.LMD3DCaptionButton3Click(Sender: TObject);
begin
 Close;
end;

procedure TLMDApplForm.TimerExpired(Sender: TObject);
begin
  LMDApplication.Timer[FTimerID].Enabled:=False; {only one call here}
  lmdwave.Play; {play the wave}
  PlayBtn.Enabled:=True; {enable the button}
end;

procedure TLMDApplForm.FormCreate(Sender: TObject);
begin
  {Global Timer
  **************
   we create a timerid.
   TimerExpired is defined in the Provate section of this form and
   will be called from the timer. Interval is two seconds}
  FTimerID:=LMDApplication.AddTimer(2000, TimerExpired);
  LMDApplication.LogWrite('TimerID was added');
  LMDApplication.Timer[FTimerID].Enabled:=False;
  {check FormClose also for removing the timer!}

end;

procedure TLMDApplForm.PlayBtnClick(Sender: TObject);
begin
  {enable the timer}
  LMDApplication.Timer[FTimerID].Enabled:=True;
  PlayBtn.Enabled:=False; {disable button}
end;

procedure TLMDApplForm.btnCreateClick(Sender: TObject);
begin
  {access the global TLMDIniCtrl via the Ini Property. This property
   has complete functionality of a TLMDIniCtrl}
  with LMDApplication.Ini do
    begin
      Target:=itIniFile;
      IniPrefix:=ppProgram;        {constant defined in lmdprocs}
      IniFile:='Hello';
      WriteInteger('Entry 1', 'Key 1', 5);
      {if we let Section empty, the last one will be used}
      WriteInteger('', 'Key 2', 20);
      WriteString('Test', 'Demo', 'This is a demo string');
      btnCreate.Enabled:=False;
      btnLoad.Enabled:=True;
    end;
end;

procedure TLMDApplForm.btnLoadClick(Sender: TObject);
begin
  memo1.Lines.LoadFromFile(LMDApplication.Ini.GetIniName);
end;

procedure TLMDApplForm.LMDButton1Click(Sender: TObject);
begin
  {check options settings in LMDApplicationCtrl1}
  log2.Enabled:=True;
  with LMDApplication do
    begin
      LogWrite('Test Entry 1');
      LogWrite('Test Entry 2');
    end;
end;

procedure TLMDApplForm.log2Click(Sender: TObject);
begin

  log.Lines.LoadFromFile(LMDApplication.LogName);
end;

procedure TLMDApplForm.LMDButton3Click(Sender: TObject);
begin
  log2.Enabled:=True;
  LMDApplication.LogWrite(ed.Text);
end;

procedure TLMDApplForm.LMDApplicationCtrl1Exception(Sender: TObject;
  E: Exception; var Cancel: Boolean);
var
  tmp:String;
begin
  if r2.Checked then
    begin
      Cancel:=True;
      with Exception(E) do
        tmp:=Format('%s, Address: %p', [Message, ExceptAddr]);
      MessageBeep(0);
      Showmessage('Our Exception handler!'#13'Message: '+tmp);
      LMDApplication.LogException(Sender);
    end;
end;

procedure TLMDApplForm.LMDButton2Click(Sender: TObject);
var
  test:Integer;
begin
  test:=StrToInt('gg');
end;

procedure TLMDApplForm.exitbtnClick(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                            mb_DefButton1 + MB_ICONQUESTION)=IDOK then
  Close;
end;

end.
