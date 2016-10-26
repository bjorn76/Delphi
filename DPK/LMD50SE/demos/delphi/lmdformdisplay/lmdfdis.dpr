program lmdfdis;

uses
  Forms,
  lmdfd1 in 'lmdfd1.pas' {fdisplay0},
  lmdfd2 in 'lmdfd2.pas' {t1},
  lmdfd3 in 'lmdfd3.pas' {t2},
  lmdfd4 in 'lmdfd4.pas' {t3};

{$R *.RES}

begin
  Application.Title := 'TLMDFormDisplay Demo';
  Application.CreateForm(Tfdisplay0, fdisplay0);
  Application.CreateForm(Tfdisplay0, fdisplay0);
  Application.Run;
end.
