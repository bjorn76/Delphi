program lmdtrck;

uses
  Forms,
  LMDtrkb0 in 'LMDtrkb0.PAS' {frmtrackbar};

{$R *.RES}

begin
  Application.Title := 'TrackBar';
  Application.CreateForm(Tfrmtrackbar, frmtrackbar);
  Application.Run;
end.
