program Acqdemo;

uses
  Forms,
  Acqdemox in 'ACQDEMOX.PAS',
  Acqdemou in 'ACQDEMOU.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
