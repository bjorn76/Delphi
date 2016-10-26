program Lmdappob;

uses
  Forms,
  Lmdappl0 in 'Lmdappl0.pas' {LMDApplForm};

{$R *.RES}

begin
  Application.Title := 'TLMDApplication Example';
  Application.CreateForm(TLMDApplForm, LMDApplForm);
  Application.Run;
end.
