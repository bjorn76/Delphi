unit lmdsbar1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, lmdclass, lmdformA, LMDCustomComponent,
  LMDWndProcComponent, LMDFormStyler;

type
  TfrmLMDStatusBarDemo = class(TForm)
    MainMenu1: TMainMenu;
    Demo: TMenuItem;
    Close1: TMenuItem;
    LMDFormStyler1: TLMDFormStyler;
    procedure Close1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmLMDStatusBarDemo: TfrmLMDStatusBarDemo;

implementation

{$R *.DFM}

procedure TfrmLMDStatusBarDemo.Close1Click(Sender: TObject);
begin
  Close;
end;

end.
