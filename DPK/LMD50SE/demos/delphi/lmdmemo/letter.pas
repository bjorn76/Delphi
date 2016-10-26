unit letter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  lmdclass, lmdcont, lmdeditb, lmdmemoc, LMDMemo, lmdctrl, lmdgroup,
  lmdstdcS, StdCtrls, lmdextcS, lmdcaret, LMDCustomComponent,
  LMDCustomComboBox, LMDCustomColorComboBox, LMDColorComboBox,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel, LMDBaseEdit, LMDCustomMemo,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel;

type
  TfrmLetterMemo = class(TForm)
    LMDBackPanel1: TLMDBackPanel;
    LMDMemo1: TLMDMemo;
    LMDBitmapList1: TLMDBitmapList;
    LMDBackPanel2: TLMDBackPanel;
    LMDCheckBox1: TLMDCheckBox;
    LMDColorComboBox1: TLMDColorComboBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LMDCheckBox1Change(Sender: TObject);
    procedure LMDColorComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLetterMemo: TfrmLetterMemo;

implementation

{$R *.DFM}


procedure TfrmLetterMemo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmLetterMemo.LMDCheckBox1Change(Sender: TObject);
begin
  LMDMemo1.Lined := LMDCheckBox1.Checked;
end;

procedure TfrmLetterMemo.LMDColorComboBox1Change(Sender: TObject);
begin
  LMDMemo1.LineStyle.Color := LMDColorComboBox1.SelectedColor;
end;

end.
