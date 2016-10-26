program Speedtst;

uses
  Forms,
  Lmdspts0 in 'LMDSPTS0.PAS' {frmsptst};

{$R *.RES}

begin
  Application.Title := 'SpeedTest';
  Application.CreateForm(Tfrmsptst, frmsptst);
  Application.Run;
end.
