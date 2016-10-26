unit d_lmdxplist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDDriveComboBox, LMDPrinterComboBox, LMDFontSizeComboBox,
  LMDFontComboBox, LMDCustomColorComboBox, LMDColorComboBox,
  LMDCustomImageComboBox, LMDImageComboBox, StdCtrls, LMDCustomComboBox,
  LMDComboBox, LMDCustomScrollBox, LMDListBox, LMDCustomListBox,
  LMDCustomImageListBox, LMDImageListBox, LMDCustomControl, LMDCustomPanel,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel;

type
  TfrmXPList = class(TForm)
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDCheckBox1: TLMDCheckBox;
    LMDImageListBox1: TLMDImageListBox;
    LMDListBox1: TLMDListBox;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel10: TLMDSimpleLabel;
    LMDSimpleLabel11: TLMDSimpleLabel;
    LMDSimpleLabel12: TLMDSimpleLabel;
    LMDSimpleLabel13: TLMDSimpleLabel;
    LMDSimpleLabel14: TLMDSimpleLabel;
    LMDSimpleLabel15: TLMDSimpleLabel;
    LMDSimpleLabel16: TLMDSimpleLabel;
    LMDComboBox1: TLMDComboBox;
    LMDImageComboBox1: TLMDImageComboBox;
    LMDColorComboBox1: TLMDColorComboBox;
    LMDFontComboBox1: TLMDFontComboBox;
    LMDFontSizeComboBox1: TLMDFontSizeComboBox;
    LMDPrinterComboBox1: TLMDPrinterComboBox;
    LMDDriveComboBox1: TLMDDriveComboBox;
    procedure LMDCheckBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmXPList: TfrmXPList;

implementation

uses d_lmdxp0;

{$R *.DFM}

procedure TfrmXPList.LMDCheckBox1Change(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to ControlCount-1 do
    begin
      if Controls[i] is TLMDCustomListBox then
        TLMDCustomListBox(Controls[i]).Flat:=LMDCheckBox1.Checked;
      if Controls[i] is TLMDCustomComboBox then
        TLMDCustomComboBox(Controls[i]).Flat:=LMDCheckBox1.Checked;
    end;
end;

end.
