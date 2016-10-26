program Arcmeter;

uses
  Forms,
  Arcmeteu in 'ARCMETEU.PAS' {Form1},
  Arcmetex in 'ARCMETEX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
