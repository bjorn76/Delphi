program Timepool;

uses
  Forms,
  Lmddetp0 in 'LMDDETP0.PAS' {frmtimerpool};

{$R *.RES}

begin
  Application.Title := 'TimerPool';
  Application.CreateForm(Tfrmtimerpool, frmtimerpool);
  Application.Run;
end.
