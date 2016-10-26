unit BoxWhiskU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses BoxWhiskX;
{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  MB_CreateGraph(Form1.handle, hinstance);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     WM_DestroyGraph;
end;

end.
