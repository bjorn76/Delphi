program Autobar;

uses
  Forms,
  Autobarx in 'AUTOBARX.PAS',
  Autobaru in 'AUTOBARU.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
