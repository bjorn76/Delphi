program Labels;

uses
  Forms,
  Lmddelb0 in 'LMDDELB0.PAS' {frmlabel};

{$R *.RES}

begin
  Application.CreateForm(Tfrmlabel, frmlabel);
  Application.Run;
end.
