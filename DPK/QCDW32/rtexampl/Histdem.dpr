program Histdem;

uses
  Forms,
  Histdemu in 'HISTDEMU.PAS' {HistdemForm},
  Histdemx in 'HISTDEMX.PAS';

{$R *.RES}

begin
  Application.CreateForm(THistdemForm, HistdemForm);
  Application.Run;
end.
