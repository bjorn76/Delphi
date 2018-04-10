unit uDataModule1;

interface

uses
  SysUtils, Classes;

type
  TDataModule1 = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

uses uAbout, uMain, Controls,uOptionsframe, Forms, Math;

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  with frmMain do
  begin
    //Init options panel
    panel1.SetBounds(0,25,340,205);

    //Init Browser panel
    panel2.Top := panel1.Top;
    panel2.Left := panel1.Left;
    panel2.Width := panel1.Width;
    panel2.Height := panel1.Height;
    gbBrowser.Align := alClient;
    WebBrowser1.Align := alClient;

    //Init Log (memo) panel
    panel3.Top := panel1.Top + panel1.Height;
    panel3.Left := panel1.Left;
    panel3.Width := panel1.Width;
    Panel3.Height := panel1.Height div 2;
    gbLog.Align := alClient;
    Memo1.Align := alClient;

    //Init mainform
    Height := BitBtn1.Height + panel1.Height + panel3.Height + 25;
    Width := Panel1.Width + 5;
    BorderStyle := bsDialog;
    Caption := Application.Title;

    // Crate options panel
    If not Assigned(FOptionsFrame) then
    begin
      FOptionsFrame := TOptionsFrame.Create(panel1);
      FOptionsFrame.Parent := panel1;
    end;

    ReadIniClick(sender);

    If (ParamCount > 0) then actSendAlarm.Execute;


  end;


end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
  frmMain.WriteIniClick(sender);
end;

end.
