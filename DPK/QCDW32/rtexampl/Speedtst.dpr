program Speedtst;

uses
  Forms,
  Speedtsu in 'SPEEDTSU.PAS' {Form1},
  Speedtsx in 'SPEEDTSX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
