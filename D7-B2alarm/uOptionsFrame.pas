unit uOptionsFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, LMDCustomScrollBox, LMDListBox, ActnList,
  LMDCustomComponent, LMDIniCtrl, ImgList, Buttons, ExtCtrls;

type
  TOptionsFrame = class(TFrame)
    GroupBox2: TGroupBox;
    LblAlarm_ID: TLabel;
    cbEnableSMS: TCheckBox;
    cbEnableSound: TCheckBox;
    GroupBox1: TGroupBox;
    LMDListBox1: TLMDListBox;
    BitBtn1: TBitBtn;
    alOptions: TActionList;
    DelSMSreceiver: TAction;
    PhoneBook: TAction;
    IniCtrl: TLMDIniCtrl;
    ImageList1: TImageList;
    Image1: TImage;
    Image2: TImage;
    Button1: TButton;
    BitBtn2: TBitBtn;
    procedure DelSMSreceiverExecute(Sender: TObject);
    procedure LblAlarm_IDClick(Sender: TObject);
    procedure PhoneBookExecute(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ReadIniFile;
    procedure WriteIniFile;

  end;

implementation

uses uMain, uMobileList;

{$R *.dfm}


procedure TOptionsFrame.WriteIniFile;
var
  i : integer;
begin

 with inictrl do
  begin
     IniFile := Application.ExeName + '.ini';
     WriteString('Common', 'Alarm_ID', LblAlarm_ID.Caption);
     WriteBool('Common','Enable_SMS',cbEnableSMS.Checked);
     WriteBool('Common','Enable_Sound',cbEnableSound.Checked);
     EraseSection('Receiver_List');
     for i:=0 to LMDListBox1.Items.Count -1 do
     begin
       WriteString('Receiver_List', IntToStr(i), LMDListBox1.Items[i] );
     end;

  end;


end;

procedure TOptionsFrame.ReadIniFile;
var
  strlst : TStringList;
  i : integer;
begin
  with inictrl do
  begin
    IniFile := Application.ExeName + '.ini';
    LblAlarm_ID.Caption := ReadString('Common','Alarm_ID','Alarm_ID');
    cbEnableSMS.Checked := ReadBool('Common','Enable_SMS',True);
    cbEnableSound.Checked := ReadBool('Common','Enable_Sound',True);

    strlst := TStringList.Create;
    try
      ReadSection('Receiver_List',strlst);
      LMDListBox1.Items.Clear;
      for i:= 0 to strlst.Count -1 do
      begin
         LMDListBox1.Items.Add(ReadString('Receiver_List',strlst[i],''));
      end;
    finally
      FreeAndNil(strlst);
    end;
  end;
end;


constructor TOptionsFrame.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TOptionsFrame.Destroy;
begin
  inherited Destroy;
end;

procedure TOptionsFrame.DelSMSreceiverExecute(Sender: TObject);
var
  i : integer;
begin
 i := 0;
  while LMDListBox1.Count > i do
  begin
    if LMDListBox1.Selected[i] then
    begin
      LMDListBox1.Items.Delete(i);
    end else
    begin
      inc(i);
    end;
  end;
end;



procedure TOptionsFrame.LblAlarm_IDClick(Sender: TObject);
var
  s : string;
begin
  if InputQuery('Enter','Alarm ID',s) then
    LblAlarm_ID.Caption := s;
end;

procedure TOptionsFrame.PhoneBookExecute(Sender: TObject);
begin
   frmMobileList.Showmodal;
end;

end.
