program Autotext;

uses
  Forms,
  Autotexu in 'AUTOTEXU.PAS' {Form1},
  Autotexx in 'AUTOTEXX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
