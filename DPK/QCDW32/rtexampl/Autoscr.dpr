program Autoscr;

uses
  Forms,
  Autoscrx in 'AUTOSCRX.PAS',
  Autoscru in 'AUTOSCRU.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
