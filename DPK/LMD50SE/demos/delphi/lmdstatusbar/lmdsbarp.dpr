program lmdsbarp;

uses
  Forms,
  lmdsbar1 in 'lmdsbar1.pas' {frmLMDStatusBarDemo},
  lmdsbar2 in 'lmdsbar2.pas' {frmDemo};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'StatusBar';
  Application.CreateForm(TfrmLMDStatusBarDemo, frmLMDStatusBarDemo);
  Application.CreateForm(TfrmDemo, frmDemo);
  Application.Run;
end.
