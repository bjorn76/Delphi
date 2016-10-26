program Ddedemo;

uses
  Forms,
  Ddedemou in 'DDEDEMOU.PAS' {Form1},
  ddedemox in 'DDEDEMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
