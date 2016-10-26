program Scvardem;

uses
  Forms,
  Scvardeu in 'SCVARDEU.PAS' {Form1},
  Scvardex in 'SCVARDEX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
