{
 Demo-Program for TLMDClock.

 This program demonstrates some features of the TLMDClock-Component.
 Notes:
 1.) If you set Alarm-Mode, the alarmtime is set 5 seconds later (see TForm1.Button3Click)
 2.) If you set StopWatch-Mode: Use Buttons Start & Stop to control the Stopwatch.


 © 1995 - 98 by LMD Innovative
 }

unit Lmddecl0;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls,
  Lmdclock, lmdclass, 
  LMDCustomComponent, LMDWaveComp, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDControl, LMDBaseControl, LMDBaseGraphicControl,
  LMDGraphicControl;

type
  Tfrmclock = class(TForm)
    Button2: TButton;
    LMDWaveComp1: TLMDWaveComp;
    GroupBox1: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    GroupBox2: TGroupBox;
    Button1: TButton;
    GroupBox3: TGroupBox;
    CheckBox3: TCheckBox;
    Bevel1: TBevel;
    CheckBox1: TCheckBox;
    LMDClock1: TLMDClock;
    LMDClock2: TLMDClock;
    LMDSimpleLabel1: TLMDSimpleLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure LMDClock1Alarm(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmclock: Tfrmclock;

implementation

{$R *.DFM}

procedure Tfrmclock.Button1Click(Sender: TObject);
begin
  LMDClock1.EndAlarm;
end;

procedure Tfrmclock.Button2Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmclock.Button3Click(Sender: TObject);
var
  hour, min, sec, ms:Word;
begin
  {we want to set the alarm 5 seconds later...}
  DecodeTime(Now, hour, min, sec, ms);
  if sec<55 then
    sec:=sec+5
  else
    begin
      min:=min+1;
      sec:=59-sec;
    end;
  LMDClock1.Alarmtime:=Date+EncodeTime(Hour, min, sec, ms);
  LMDClock1.Mode := cmAlarm;
end;

procedure Tfrmclock.Button4Click(Sender: TObject);
begin
  LMDClock1.Mode := cmDate;
end;

procedure Tfrmclock.Button5Click(Sender: TObject);
begin
    LMDClock1.Mode := cmNormal;
end;

procedure Tfrmclock.CheckBox1Click(Sender: TObject);
begin
  if Checkbox1.Checked then with LMDClock1 do
  begin
    Options := Options + [co24hour];
    Checkbox1.Font.Color := clNavy;
  end
  else with LMDClock1 do
  begin
    Options := Options - [co24hour];
    Checkbox1.Font.Color := clblack;
  end;
end;

procedure Tfrmclock.CheckBox2Click(Sender: TObject);
begin
  if Checkbox3.Checked then with LMDClock1 do
    Options := Options + [coEnableAlarm]
  else with LMDClock1 do
    Options := Options - [coEnableAlarm];
end;

procedure Tfrmclock.LMDClock1Alarm(Sender: TObject);
begin
   Button1.Enabled := true;
   LmdWaveComp1.Play;
end;

procedure Tfrmclock.Button6Click(Sender: TObject);
begin
  LMDClock1.StartCountdown;
end;

procedure Tfrmclock.Button7Click(Sender: TObject);
begin
  LMDClock1.StartStpWatch;
end;

procedure Tfrmclock.Button8Click(Sender: TObject);
begin
  LMDClock1.EndStpWatch;
end;

procedure Tfrmclock.Button9Click(Sender: TObject);
begin
  LMDClock1.Mode := cmStopwatch;
end;

procedure Tfrmclock.FormActivate(Sender: TObject);
begin
  Checkbox3.Checked := (co24Hour in LMDClock1.Options);
  {LMDClock1.Enabled:=True;}
end;

end.
