program Lmddeccb;

uses
  Forms,
  Lmddecb0 in 'LMDDECB0.PAS' {frmcolorbox};

{$R *.RES}

begin
  Application.Title := 'TLMDColorComboBox example';
  Application.CreateForm(Tfrmcolorbox, frmcolorbox);
  Application.Run;
end.
