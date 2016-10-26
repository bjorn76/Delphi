program lmdassis;

uses
  Forms,
  lmdassi1 in 'lmdassi1.pas' {frmassist};

{$R *.RES}

begin
  Application.Title := 'TLMDAssist Example';
  Application.CreateForm(Tfrmassist, frmassist);
  Application.Run;
end.
