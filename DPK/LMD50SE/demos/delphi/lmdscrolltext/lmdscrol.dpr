program lmdscrol;

uses
  Forms,
  LMDscro0 in 'LMDscro0.PAS' {frmscrolltext};

{$R *.RES}

begin
  Application.Title := 'TLMDScrollTextDemo';
  Application.CreateForm(Tfrmscrolltext, frmscrolltext);
  Application.Run;
end.
