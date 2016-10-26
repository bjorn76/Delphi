program Formdemo;

uses
  Forms,
  Lmddef0 in 'LMDDEF0.PAS' {frmlmddemo};

{$R *.RES}

begin
  Application.Title := 'TLMDForm Demo';
  Application.CreateForm(Tfrmlmddemo, frmlmddemo);
  Application.Run;
end.
