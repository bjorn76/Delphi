program TextEdit;

uses
  Forms,
  Lmddete1 in 'LMDDETE1.PAS' {frmEdit},
  Lmddete0 in 'LMDDETE0.PAS' {frmFrame};

begin
  Application.Title := 'LMD Text Editor';
  Application.CreateForm(TfrmFrame, frmFrame);
  Application.Run;
end.
