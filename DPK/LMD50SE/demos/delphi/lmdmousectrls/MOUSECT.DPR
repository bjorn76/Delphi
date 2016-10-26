program Mousect;

uses
  Forms,
  Lmddemo0 in 'LMDDEMO0.PAS' {frmmousectrl1},
  Lmddemo1 in 'LMDDEMO1.PAS' {frmmousectrl2};

{$R *.RES}

begin
  Application.CreateForm(Tfrmmousectrl1, frmmousectrl1);
  Application.CreateForm(Tfrmmousectrl2, frmmousectrl2);
  Application.Run;
end.
