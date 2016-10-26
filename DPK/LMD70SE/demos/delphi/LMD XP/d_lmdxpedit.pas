unit d_lmdxpedit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDCustomParentPanel, LMDCustomPanelFill, LMDButtonPanel, StdCtrls,
  LMDCustomScrollBox, LMDScrollBox, LMDCustomTrackBar, LMDTrackBar,
  LMDCustomMemo, LMDMemo, LMDButtonControl, LMDCustomCheckBox, LMDCheckBox,
  LMDFileSaveEdit, LMDCustomFileEdit, LMDFileOpenEdit, LMDColorEdit,
  LMDCustomBrowseEdit, LMDBrowseEdit, LMDCustomMaskEdit, LMDMaskEdit,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit,
  LMDCustomEdit, LMDEdit, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel;

type
  TfrmXPEdit = class(TForm)
    LMDEdit1: TLMDEdit;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDMaskEdit1: TLMDMaskEdit;
    LMDBrowseEdit1: TLMDBrowseEdit;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel10: TLMDSimpleLabel;
    LMDColorEdit1: TLMDColorEdit;
    LMDFileOpenEdit1: TLMDFileOpenEdit;
    LMDFileSaveEdit1: TLMDFileSaveEdit;
    LMDCheckBox1: TLMDCheckBox;
    LMDMemo1: TLMDMemo;
    TLMDMemo: TLMDSimpleLabel;
    LMDSimpleLabel9: TLMDSimpleLabel;
    LMDTrackBar1: TLMDTrackBar;
    LMDScrollBox1: TLMDScrollBox;
    Button1: TButton;
    LMDSimpleLabel11: TLMDSimpleLabel;
    LMDSimpleLabel12: TLMDSimpleLabel;
    LMDButtonPanel1: TLMDButtonPanel;
    procedure LMDCheckBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmXPEdit: TfrmXPEdit;

implementation

{$R *.DFM}

procedure TfrmXPEdit.LMDCheckBox1Change(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to ControlCount-1 do
    begin
      if Controls[i] is TLMDBaseEdit then
        TLMDBaseEdit(Controls[i]).Flat:=LMDCheckBox1.Checked;
    end;
end;

end.
