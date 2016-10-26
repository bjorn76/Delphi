program lmdsys;

uses
  Forms,
  lmdsysinfo1 in 'lmdsysinfo1.pas' {frmLMDSysInfoDemo};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'LMD SysInfo';
  Application.CreateForm(TfrmLMDSysInfoDemo, frmLMDSysInfoDemo);
  Application.Run;
end.
