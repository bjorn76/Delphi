program Lmdtech;

uses
  Forms,
  Lmdtech0 in 'LMDTECH0.PAS' {frmtechline};

{$R *.RES}

begin
  Application.Title := 'LMD-Tools TechLine';
  Application.CreateForm(Tfrmtechline, frmtechline);
  Application.Run;
end.
