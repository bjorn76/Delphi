unit uMobileList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uMobileListFrame, StdCtrls, Menus;

type
  TfrmMobileList = class(TForm)
    MobileListFrame1: TMobileListFrame;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMobileList: TfrmMobileList;

implementation

uses umain, uOptionsFrame;

{$R *.dfm}



procedure TfrmMobileList.Button1Click(Sender: TObject);
var
  i : integer;
begin
  with MobileListFrame1.LMDListBox2 do
  begin
    for i := 0 to Count -1 do
    begin
      if Selected[i] then
      begin
        frmMain.FOptionsFrame.LMDListBox1.items.Add( ItemPart(i,0) +';' + ItemPart(i,1));
      end;
    end;

  end;
  close;
end;

end.
