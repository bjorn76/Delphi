program Zoomdem2;

uses
  Forms,
  Zoom2u in 'ZOOM2U.PAS' {ZoomDemo2Form},
  Zoom2x in 'ZOOM2X.PAS';

{$R *.RES}

begin
  Application.CreateForm(TZoomDemo2Form, ZoomDemo2Form);
  Application.Run;
end.
