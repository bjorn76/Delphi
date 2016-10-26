unit PanGraphU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses PanGraphX;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  MB_CreateGraph(Form1.handle, hinstance);
  ScrollBar2.Position := 50;
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  UpdateVertPos(ScrollBar2.Position);

end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
 UpdateHorzPos(ScrollBar1.Position);

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     WM_DestroyGraph;
end;

end.
