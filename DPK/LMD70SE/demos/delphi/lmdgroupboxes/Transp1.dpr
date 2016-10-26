program Transp1;

uses
  Forms,
  Frmtran1 in 'FRMTRAN1.PAS' {frmTransDemo};

{$R *.RES}

begin
  Application.CreateForm(TfrmTransDemo, frmTransDemo);
  Application.Run;
end.
