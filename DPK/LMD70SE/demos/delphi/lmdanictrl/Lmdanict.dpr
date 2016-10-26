program lmdanict;

uses
  Forms,
  LMDanic0 in 'LMDanic0.PAS' {frmanict};

{$R *.RES}

begin
  Application.Title := 'AnimationExample';
  Application.CreateForm(Tfrmanict, frmanict);
  Application.Run;
end.
