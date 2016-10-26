unit Frminfo5;

interface

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, lmdclass, lmdcont,
  LMDFormStyler, LMDCustomComponent, LMDBackPanel, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel,
  LMDCustomGroupBox, LMDGroupBox, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDInformationLabel,
  LMDBaseController, LMDCustomContainer, LMDCustomImageList, LMDBitmapList,
  LMDWndProcComponent;

type
  TlmdinfoForm = class(TForm)
    TabbedNotebook1: TPageControl;
    LMDInformationLabel5: TLMDInformationLabel;
    LMDGroupBox1: TLMDGroupBox;
    LMDInformationLabel2: TLMDInformationLabel;
    LMDInformationLabel4: TLMDInformationLabel;
    LMDInformationLabel10: TLMDInformationLabel;
    LMDInformationLabel1: TLMDInformationLabel;
    LMDInformationLabel12: TLMDInformationLabel;
    LMDGroupBox2: TLMDGroupBox;
    LMDInformationLabel3: TLMDInformationLabel;
    LMDInformationLabel6: TLMDInformationLabel;
    LMDInformationLabel7: TLMDInformationLabel;
    LMDInformationLabel8: TLMDInformationLabel;
    LMDInformationLabel9: TLMDInformationLabel;
    LMDInformationLabel11: TLMDInformationLabel;
    LMDGroupBox3: TLMDGroupBox;
    LMDInformationLabel13: TLMDInformationLabel;
    LMDInformationLabel14: TLMDInformationLabel;
    LMDInformationLabel16: TLMDInformationLabel;
    LMDInformationLabel15: TLMDInformationLabel;
    Button1: TButton;
    LMDBitmapList1: TLMDBitmapList;
    LMDBackPanel1: TLMDBackPanel;
    LMDGroupBox7: TLMDGroupBox;
    LMDInformationLabel18: TLMDInformationLabel;
    LMDInformationLabel33: TLMDInformationLabel;
    LMDInformationLabel34: TLMDInformationLabel;
    LMDInformationLabel35: TLMDInformationLabel;
    LMDGroupBox6: TLMDGroupBox;
    LMDInformationLabel23: TLMDInformationLabel;
    LMDInformationLabel24: TLMDInformationLabel;
    LMDInformationLabel25: TLMDInformationLabel;
    LMDInformationLabel26: TLMDInformationLabel;
    LMDInformationLabel27: TLMDInformationLabel;
    LMDInformationLabel28: TLMDInformationLabel;
    LMDGroupBox4: TLMDGroupBox;
    LMDInformationLabel17: TLMDInformationLabel;
    LMDInformationLabel22: TLMDInformationLabel;
    LMDInformationLabel29: TLMDInformationLabel;
    LMDInformationLabel30: TLMDInformationLabel;
    LMDInformationLabel31: TLMDInformationLabel;
    LMDInformationLabel32: TLMDInformationLabel;
    LMDGroupBox5: TLMDGroupBox;
    LMDInformationLabel19: TLMDInformationLabel;
    LMDInformationLabel20: TLMDInformationLabel;
    LMDInformationLabel21: TLMDInformationLabel;
    LMDFormStyler1: TLMDFormStyler;
    page1: TTabSheet;
    page2: TTabSheet;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  lmdinfoForm: TlmdinfoForm;

implementation

{$R *.DFM}

procedure TlmdinfoForm.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
