program Lblfill;

uses
  Forms,
  Lmddelf1 in 'LMDDELF1.PAS' {frmlabelfill};

{$R *.RES}

begin
  Application.CreateForm(Tfrmlabelfill, frmlabelfill);
  Application.Run;
end.
