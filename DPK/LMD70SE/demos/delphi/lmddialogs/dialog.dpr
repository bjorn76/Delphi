program dialog;

uses
  Forms,
  Lmddedlg in 'LMDDEDLG.PAS' {frmdlg},
  Lmddedl1 in 'LMDDEDL1.PAS' {test2},
  Lmddedl0 in 'LMDDEDL0.PAS' {test1};

{$R *.RES}

begin
  Application.Title := 'Important App';
  Application.CreateForm(Tfrmdlg, frmdlg);
  Application.Run;
end.
