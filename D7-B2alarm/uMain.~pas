unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, Menus, ActnList, ComCtrls, ExtCtrls,
  btOdeum, LMDCustomComponent, LMDIniCtrl, uMobileListFrame, uOptionsFrame,
  ImgList, Buttons;

type
  TfrmMain = class(TForm)
    ActionList1: TActionList;
    actSendAlarm: TAction;
    tmrAlarm: TTimer;
    btBeeper1: TbtBeeper;
    actAbout: TAction;
    actReset: TAction;
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    ReadIni: TButton;
    WriteIni: TButton;
    ActViewBrowser: TAction;
    BitBtn1: TBitBtn;
    ImageList1: TImageList;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    sbtnBrowser: TSpeedButton;
    gbBrowser: TGroupBox;
    WebBrowser1: TWebBrowser;
    gbLog: TGroupBox;
    Memo1: TMemo;
    procedure actSendAlarmExecute(Sender: TObject);
    procedure tmrAlarmTimer(Sender: TObject);
    procedure SlimClick(Sender: TObject);
    procedure Normal1Click(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actResetExecute(Sender: TObject);
    procedure WriteIniClick(Sender: TObject);
    procedure ReadIniClick(Sender: TObject);
    procedure ActViewBrowserExecute(Sender: TObject);


  private
    { Private declarations }
    function ReadAlarmlog(filename : string):string ;
    procedure SendSMS(mobnbr : string; SMSmessage : string);


  public
    { Public declarations }
    FOptionsFrame : TOptionsFrame;


  end;

var
  frmMain: TfrmMain;

implementation

uses uAbout, Math, uMobileList, uDummyFrame;

{$R *.dfm}
Const
  ConstUsr : string = 'svenska';
  ConstPwd : string = 'dre2CXFL';

//var
  //mobNumber : string;
  //smsText : string;
  //mp3player : TcmxMP3;

//var
  //frameInPanel : TFrame;



function TfrmMain.ReadAlarmlog(filename : string):string ;
  procedure writeln (s : string);
  begin
    memo1.Lines.Add(s);
  end;

const
  nbroflines = 5;

var
   f : System.TextFile;
   i:   Integer;
   s,msg: string;

   strlst: TStringlist;


begin
  if not FileExists( filename) then
  begin
    writeln('File is missing! ' +filename );
    exit;
  end;
  i := -1;
  strlst := TStringlist.Create;
  try
    try
      AssignFile(f,filename);
      Reset(f);
      while not Eof(f) do
      begin
        inc(i); //line counter
        Readln(f,s);
        strlst.add(s + ';');
      end;
      Writeln(DateTimeToStr(Now) + ' - Reading "' + filename + '.('
         + IntToStr(i+1) + ' lines.)'  );
    finally
      CloseFile(f);
    end;

    //for j:=(nbroflines-1) downto 0 do
    i := 0;
    while (strlst.Count > i) and (length(msg) < 490) do
    begin
      msg := strlst[strlst.Count - 1  - i ] + msg;
      inc(i);
    end;

    //Filter repeated spaces
    for i:= 1  to length(msg) do
      begin
        // if (msg[i] = #13) or (msg[i] = #10) then ShowMessage('CR or LF');
        if not ((msg[i] = ' ') and (msg[i-1] = ' ')) then
        begin
          Result := Result + msg[i]  ;
        end;
    end;
   finally
    strlst.Destroy;
    Writeln (DateTimeToStr(Now) +' - Last lines of Alarmlog: "' + Result + '"');
  end;
end;



procedure TfrmMain.SendSMS(mobnbr: string; SMSmessage: string);
var
  urlstr : string;

begin
urlstr := 'http://sms.pswin.com/http4sms/send.asp?' +
  'USER=' + ConstUsr +
  '&PW=' + ConstPwd +
  '&RCV=' +  mobnbr +
  //'&TXT=' + 'Alarm from ' + FOptionsFrame.LblAlarm_ID.Caption + ': '+ SMSmessage;
  '&TXT=' + SMSmessage;

//Memo1.Lines.Add('(DebugMessage) URL call: ' + urlstr);
WebBrowser1.Navigate(urlstr);
Memo1.Lines.Add(DateTimeToStr(Now) + ' - SMS sent to: ' + mobnbr );

end;

procedure TfrmMain.actSendAlarmExecute(Sender: TObject);

var
  smsMessage,mobnbr : string;
  i : integer;
begin
  // Start the blinking and (optional) beeping
  tmrAlarm.Enabled := True;

  Memo1.Lines.Add(DateTimeToStr(Now)+ ' - Start of SendAlarmExecute');
  //FormatDateTime is maybe a better choice...

  if FOptionsFrame.cbEnableSound.Checked then
  begin
    Memo1.Lines.Add(DateTimeToStr(Now)+ ' - Sound Alarm Activated');
  end;

   //Read and Extract the last lines from the alarm log!
  //smsMessage := ReadAlarmlog('C:\stet\logfiles\alarmlog.txt');
  smsMessage := 'B2 Alarm SMS Test';

  //If enabled: Send SMS to all recipients
  if FOptionsFrame.cbEnableSMS.Checked and(FOptionsFrame.LMDListBox1.Count >= 1) then
  begin
    for i := 1 to FOptionsFrame.LMDListBox1.Count do
    begin
      mobnbr := FOptionsFrame.LMDListBox1.ItemPart(i-1,1);
      SendSMS(mobnbr,smsMessage);
    end;
  end;
  Memo1.Lines.Add(DateTimeToStr(Now)+ ' - End of SendAlarmExecute');
  Memo1.Lines.Add('');

end;


procedure TfrmMain.tmrAlarmTimer(Sender: TObject);
begin

  // Note:
  // Beep;  will only use windows "Default Beep" (often ding.wav) via soundcard.
  // Thus is the btBeeper compont used.

  if FOptionsFrame.cbEnableSound.Checked then
  begin
    if Memo1.Color = clwhite then btBeeper1.BeepFor(550,300)
    else btBeeper1.BeepFor(250,300);
  end;

  if Memo1.Color = clwhite then
  begin
    Memo1.Color := clred;
  end else
  begin
    Memo1.Color := clwhite;
  end;

end;



procedure TfrmMain.SlimClick(Sender: TObject);
begin
  Height := 46;
  Width := 234;

end;

procedure TfrmMain.Normal1Click(Sender: TObject);
begin
  Height := 275;
  Width := 420;
end;

procedure TfrmMain.actAboutExecute(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.actResetExecute(Sender: TObject);
begin
    tmrAlarm.Enabled := False;
    Memo1.Color := clWhite;
    //if mp3player <> nil then mp3player.Stop;
end;

procedure TfrmMain.WriteIniClick(Sender: TObject);
begin
  FOptionsFrame.WriteInifile;
  frmMobileList.MobileListFrame1.WriteInifile;
end;

procedure TfrmMain.ReadIniClick(Sender: TObject);
begin
  FOptionsFrame.ReadIniFile;
  frmMobileList.MobileListFrame1.ReadInifile;
end;

procedure TfrmMain.ActViewBrowserExecute(Sender: TObject);
begin
  if not frmMain.ActViewBrowser.Checked then
  begin
    panel2.Show;
    frmMain.ActViewBrowser.Checked := True;
  end else
  begin
    frmMain.ActViewBrowser.Checked := False;
    panel2.Hide;
  end;

  //frmMain.sbtnBrowser.Down := frmMain.ActViewBrowser.Checked;

end;



initialization
  //mp3player := TcmxMP3.Create(ExtractFilePath(Application.ExeName) + '1.mp3');


finalization
//  if mp3player <> nil then FreeAndNil(mp3player);

end.
