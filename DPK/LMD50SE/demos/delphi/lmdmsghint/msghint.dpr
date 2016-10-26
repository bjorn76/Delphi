program msghint;

uses
  Forms,
  lmddemhi in 'lmddemhi.pas' {frmsmsgHint};

{$R *.RES}

begin
  Application.CreateForm(TfrmsmsgHint, frmsmsgHint);
  Application.Run;
end.
