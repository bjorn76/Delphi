program Ascdemo;

uses
  Forms,
  Ascdemou in 'ASCDEMOU.PAS' {Form1},
  Ascdemox in 'ASCDEMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
