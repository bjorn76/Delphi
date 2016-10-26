program Bigdemo;

uses
  Forms,
  Bigdemou in 'BIGDEMOU.PAS' {Form1},
  Bigdemox in 'BIGDEMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
