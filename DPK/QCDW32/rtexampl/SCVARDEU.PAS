unit Scvardeu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses scvardex;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
   MM_CreateGraph(Form1.Handle, hinstance );
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

end.
