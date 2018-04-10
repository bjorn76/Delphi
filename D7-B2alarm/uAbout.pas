unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmAbout = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.FormShow(Sender: TObject);
const
  InfoNum = 10;
  InfoStr: array[1..InfoNum] of string = ('CompanyName', 'FileDescription', 'FileVersion', 'InternalName', 'LegalCopyright', 'LegalTradeMarks', 'OriginalFileName', 'ProductName', 'ProductVersion', 'Comments');

var
  S: string;
  n, Len, i: DWORD;
  Buf: PChar;
  Value: PChar;
begin
  Caption := 'About B2alarm';
  Memo1.Lines.Clear;

  S := Application.ExeName;
  n := GetFileVersionInfoSize(PChar(S), n);
  if n > 0 then
  begin
    Buf := AllocMem(n);
    // Memo1.Lines.Add('VersionInfoSize = ' + IntToStr(n));  //Debug only
    GetFileVersionInfo(PChar(S), 0, n, Buf);


    {
    // File Version
    if VerQueryValue(Buf, PChar('StringFileInfo\041D04E4\' + InfoStr[3]), Pointer(Value), Len) then
      Memo1.Lines.Add(InfoStr[3] + ' = ' + Value);
     }

    // File version
     if VerQueryValue(Buf, PChar('StringFileInfo\041D04E4\' + InfoStr[3]), Pointer(Value), Len) then
      Memo1.Lines.Add(Application.Title  + ' ' + Value);

    // Company Name
    if VerQueryValue(Buf, PChar('StringFileInfo\041D04E4\' + InfoStr[1]), Pointer(Value), Len) then
      Memo1.Lines.Add(Value);


    {
    for i := 1 to InfoNum do
    begin
      if VerQueryValue(Buf, PChar('StringFileInfo\041D04E4\' + InfoStr[i]), Pointer(Value), Len) then
      begin
        Memo1.Lines.Add(InfoStr[i] + ' = ' + Value);
      end;
    end;
    }
    FreeMem(Buf, n);
  end
  else
    Memo1.Lines.Add('No version information found');



end;

procedure TfrmAbout.Memo1Click(Sender: TObject);
begin
  close;
end;

end.
