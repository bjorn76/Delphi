unit uMobileListFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, LMDCustomScrollBox, LMDListBox, ActnList,
  LMDCustomComponent, LMDIniCtrl, Buttons, ImgList;

type
  TMobileListFrame = class(TFrame)
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    Del2: TMenuItem;
    ActionList1: TActionList;
    Add: TAction;
    Del: TAction;
    LMDListBox2: TLMDListBox;
    IniCtrl: TLMDIniCtrl;
    ImageList1: TImageList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure AddSMSreceiverExecute(Sender: TObject);
    procedure AddExecute(Sender: TObject);
    procedure DelExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

    { Private declarations }
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure ReadInifile;
    procedure WriteInifile;


    { Public declarations }
  end;

//var
  //fraMobileList: TfraMobileList;


implementation

uses u2lines, uMain;

{$R *.dfm}

constructor TMobileListFrame.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TMobileListFrame.Destroy;
begin

  inherited Destroy;
end;

procedure TMobileListFrame.AddSMSreceiverExecute(Sender: TObject);
var
  i : integer;
begin
  with LMDListBox2 do
  begin
    for i := 0 to Count -1 do
    begin
      if Selected[i] then
      begin
        frmMain.FOptionsFrame.LMDListBox1.items.Add( LMDListBox2.ItemPart(i,0) +';' + LMDListBox2.ItemPart(i,1));
      end;
    end;
  end;
end;

procedure TMobileListFrame.AddExecute(Sender: TObject);
begin
  if frm2lines = nil then  frm2lines := Tfrm2lines.Create(Self);
  frm2lines.ShowModal;
  if  frm2lines.ModalResult = mrOK then
  begin
    LMDListBox2.Items.add(frm2lines.edit1.text + ';' +frm2lines.edit2.text);
  end;
end;

procedure TMobileListFrame.DelExecute(Sender: TObject);
var
  i : integer;

begin
  i := 0;
  while LMDListBox2.Count > i do
  begin
    if LMDListBox2.Selected[i] then
    begin
      LMDListBox2.Items.Delete(i);
    end else
    begin
      inc(i);
    end;
  end;

end;

procedure TMobileListFrame.Button1Click(Sender: TObject);
begin
  LMDListBox2.Items.Add('pelle;M');
end;

procedure TMobileListFrame.Button2Click(Sender: TObject);
begin
  LMDListBox2.Items.Add('1;2');
  //AddExecute(sender);
end;

procedure TMobileListFrame.ReadInifile;
var
  strlst : TStringList;
  i : integer;
begin
  with IniCtrl do
  begin
    IniFile := Application.ExeName + '.ini';
    strlst := TStringList.Create;
    try
      ReadSection('Mobile_List',strlst);
      LMDListBox2.Items.Clear;
      for i:= 0 to strlst.Count -1 do
      begin
         LMDListBox2.Items.Add(ReadString('Mobile_List',strlst[i],''));
      end;
    finally
      FreeAndNil(strlst);
    end;

  end;

end;

procedure TMobileListFrame.WriteInifile;
var
  i : integer;
begin
  with inictrl do
  begin
     IniFile := Application.ExeName + '.ini';
     EraseSection('Mobile_List');
     for i:=0 to LMDListBox2.Items.Count -1 do
     begin
       WriteString('Mobile_List', IntToStr(i), LMDListBox2.Items[i] );
     end;
   end;  
end;

initialization
  //fraMobileList := TfraMobileList.Create(nil);


finalization

  //FreeAndNil(fraMobileList);


end.
