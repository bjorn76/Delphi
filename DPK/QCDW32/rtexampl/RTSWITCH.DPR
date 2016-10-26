program Rtswitch;

uses
  Forms,
  Rtswitcx in 'RTSWITCX.PAS',
  Rtswitcu in 'RTSWITCU.PAS' {RTSwitchForm};

{$R *.RES}

begin
  Application.CreateForm(TRTSwitchForm, RTSwitchForm);
  Application.Run;
end.
