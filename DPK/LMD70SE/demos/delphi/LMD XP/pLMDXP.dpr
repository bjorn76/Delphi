program pLMDXP;

uses
  Forms,
  d_lmdxp0 in 'd_lmdxp0.pas' {LMDXPDemo},
  d_lmdxp1 in 'd_lmdxp1.pas' {frmxp1},
  d_lmdxp2a in 'd_lmdxp2a.pas' {frmxp2a},
  d_lmdxp3 in 'd_lmdxp3.pas' {frmxp3},
  d_lmdxpedit in 'd_lmdxpedit.pas' {frmXPEdit},
  d_lmdxpstd in 'd_lmdxpstd.pas' {frmXPStd},
  d_lmdxplist in 'd_lmdxplist.pas' {frmXPList},
  d_lmdxp2 in 'd_lmdxp2.pas' {frmxp2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TLMDXPDemo, LMDXPDemo);
  Application.Run;
end.
