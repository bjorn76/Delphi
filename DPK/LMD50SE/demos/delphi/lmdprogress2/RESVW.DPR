program Resvw;

uses
  Forms,
  Lmdderv0 in 'LMDDERV0.PAS' {frmresviewer};

{$R *.RES}

begin
  Application.Title := 'Res-Viewer';
  Application.CreateForm(Tfrmresviewer, frmresviewer);
  Application.Run;
end.
