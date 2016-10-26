program Drawedg;

uses
  Forms,
  Lmddede0 in 'LMDDEDE0.PAS' {frmdrawedge};

{$R *.RES}

begin
  Application.Title := 'TLMDDrawEdge Example';
  Application.CreateForm(Tfrmdrawedge, frmdrawedge);
  Application.Run;
end.
