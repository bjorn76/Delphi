program lmdini32;

uses
  Forms,
  Lmdini2 in 'Lmdini2.pas' {frmIniCtrl},
  Lmdini3 in 'Lmdini3.pas' {frmini3};

{$R *.RES}

begin
  Application.CreateForm(TfrmIniCtrl, frmIniCtrl);
  Application.Run;
end.
