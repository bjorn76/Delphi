program Graphlab;

uses
  Forms,
  Lmdgrlab in 'LMDGRLAB.PAS' {frmGrLabDemo};

{$R *.RES}

begin
  Application.CreateForm(TfrmGrLabDemo, frmGrLabDemo);
  Application.Run;
end.
