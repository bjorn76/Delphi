program Lmdilbxd;

uses
  Forms,
  Lmdilbx in 'LMDILBX.PAS' {frmLMDImageListBoxDemo};

{$R *.RES}

begin
  Application.CreateForm(TfrmLMDImageListBoxDemo, frmLMDImageListBoxDemo);
  Application.Run;
end.
