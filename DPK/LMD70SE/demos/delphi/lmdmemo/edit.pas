unit edit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDMemo,StdCtrls,
  LMDBaseEdit, LMDCustomMemo, LMDCustomComboBox, LMDComboBox,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, LMDStatusBar,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDCustomStatusBar;

type
  TfrmEditMemo = class(TForm)
    LMDStatusBar1: TLMDStatusBar;
    LMDMemo1: TLMDMemo;
    LMDCheckBox1: TLMDCheckBox;
    LMDComboBox1: TLMDComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LMDCheckBox1Change(Sender: TObject);
    procedure LMDComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditMemo: TfrmEditMemo;

implementation

{$R *.DFM}

procedure TfrmEditMemo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmEditMemo.LMDCheckBox1Change(Sender: TObject);
begin
  LMDMemo1.WordWrap := LMDCheckBox1.Checked;
end;

procedure TfrmEditMemo.LMDComboBox1Change(Sender: TObject);
begin
  case LMDComboBox1.ItemIndex of
    0 : LMDMemo1.Alignment := taLeftJustify;
    1 : LMDMemo1.Alignment := taCenter;
    2 : LMDMemo1.Alignment := taRightJustify;
  end;
end;

end.
