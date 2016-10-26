program Shaphint;

uses
  Forms,
  Lmddehi1 in 'lmddehi1.pas' {frmshapeHint};

{$R *.RES}

begin
  Application.Title := 'ShapeHint';
  Application.CreateForm(TfrmshapeHint, frmshapeHint);
  Application.Run;
end.
