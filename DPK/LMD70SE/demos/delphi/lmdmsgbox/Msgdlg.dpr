program Msgdlg;

uses
  Forms,
  Msgdlg1 in 'MSGDLG1.PAS' {frmMsgDemo};

{$R *.RES}

begin
  Application.CreateForm(TfrmMsgDemo, frmMsgDemo);
  Application.Run;
end.
