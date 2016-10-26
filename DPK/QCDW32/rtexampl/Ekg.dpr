program Ekg;

uses
  Forms,
  Ekgx in 'EKGX.PAS',
  Ekgu in 'EKGU.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
