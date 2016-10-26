program Lmdbtnde;

uses
  Forms,
  Lmdbtnd0 in 'Lmdbtnd0.pas' {LMDBtnForm};

{$R *.RES}

begin
  Application.Title := 'Button Demo';
  Application.CreateForm(TLMDBtnForm, LMDBtnForm);
  Application.Run;
end.
