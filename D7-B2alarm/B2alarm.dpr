program B2alarm;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  u2lines in 'u2lines.pas' {frm2lines},
  uAbout in 'uAbout.pas' {frmAbout},
  uMobileList in 'uMobileList.pas' {frmMobileList},
  uMobileListFrame in 'uMobileListFrame.pas' {MobileListFrame: TFrame},
  uDummyFrame in 'uDummyFrame.pas' {DummyFrame: TFrame},
  uOptionsFrame in 'uOptionsFrame.pas' {OptionsFrame: TFrame},
  uDataModule1 in 'uDataModule1.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'B2alarm';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmMobileList, frmMobileList);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
