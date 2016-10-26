unit DynLineU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
 uses DynLineX;
{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  WM_CreateGraph(Form1.Handle, hinstance );
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    TimerRoutine;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WM_DestroyGraph;
end;

end.
