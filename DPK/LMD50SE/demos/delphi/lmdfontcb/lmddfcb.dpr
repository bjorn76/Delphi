program lmddfcb;

uses
  Forms,
  LMDfcb0 in 'LMDfcb0.PAS' {frmfontbox};

{$R *.RES}

begin
  Application.CreateForm(Tfrmfontbox, frmfontbox);
  Application.Run;
end.
