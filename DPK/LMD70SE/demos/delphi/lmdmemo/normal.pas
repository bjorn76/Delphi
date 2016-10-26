unit normal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDCustomMemo, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomStatusBar, LMDStatusBar, LMDBaseEdit, LMDMemo;

type
  TfrmNormalMemo = class(TForm)
    LMDStatusBar1: TLMDStatusBar;
    LMDMemo1: TLMDMemo;
    procedure LMDMemo1CursorPosChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNormalMemo: TfrmNormalMemo;

implementation

{$R *.DFM}

procedure TfrmNormalMemo.LMDMemo1CursorPosChanged(Sender: TObject);
begin
  LMDStatusBar1.Panels[0].Text := IntToStr (LMDMemo1.Row) + ' : ' + IntToStr (LMDMemo1.Rows);
  LMDStatusBar1.Panels[1].Text := IntToStr (LMDMemo1.CurrentChar) + ' : ' + IntToStr (Length(LMDMemo1.Text));
  LMDStatusBar1.Panels[2].Text := IntToStr (LMDMemo1.Column);  
end;

procedure TfrmNormalMemo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
