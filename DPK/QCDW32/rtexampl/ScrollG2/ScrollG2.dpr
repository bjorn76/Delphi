program ScrollG2;

uses
  Forms,
  ScrollG2U in 'ScrollG2U.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
