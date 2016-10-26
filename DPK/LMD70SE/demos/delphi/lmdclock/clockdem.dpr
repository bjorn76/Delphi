program Clockdem;

uses
  Forms,
  Lmddecl0 in 'LMDDECL0.PAS' {frmclock};

{$R *.RES}

begin
  Application.Title := 'Clock Demo';
  Application.CreateForm(Tfrmclock, frmclock);
  Application.Run;
end.
 