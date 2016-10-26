program Zoomdemo;

uses
  Forms,
  Zoomdemu in 'ZOOMDEMU.PAS' {ZoomDemoForm},
  Zoomdemx in 'Zoomdemx.pas';

{$R *.RES}

begin
  Application.CreateForm(TZoomDemoForm, ZoomDemoForm);
  Application.Run;
end.
