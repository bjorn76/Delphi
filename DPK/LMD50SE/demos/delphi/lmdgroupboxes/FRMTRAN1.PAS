unit Frmtran1;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdclass, lmdformA, ExtCtrls, Tabs, StdCtrls, lmdstdcA,
  lmdstdcS, lmdctrl, lmdextcS, lmdcont, lmdnonvS, lmdgroup, lmdbtn,
  lmdextcA, ComCtrls, lmdcompo, lmdcombo, lmdcctrl, LMDCustomHint,
  LMDCustomShapeHint, LMDShapeHint, LMDCustomComponent,
  LMDWndProcComponent, LMDFormStyler, LMDCustomComboBox,
  LMDCustomColorComboBox, LMDColorComboBox, LMDCustomTrackBar, LMDTrackBar,
  LMDCustomImageListBox, LMDImageListBox, LMDButtonControl,
  LMDCustomCheckBox, LMDCheckBox, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDGroupBox, LMDCustomCheckGroup, LMDCheckGroup,
  LMDCustomGroupBox, LMDCustomButtonGroup, LMDCustomRadioGroup,
  LMDRadioGroup, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel;

type
  TfrmTransDemo = class(TForm)
    note: TPageControl;
    LMDFormStyler1: TLMDFormStyler;
    LMDBitmapList1: TLMDBitmapList;
    LMDBackPanel1: TLMDBackPanel;
    radiog: TLMDRadioGroup;
    chkg: TLMDCheckGroup;
    LMDShapeHint1: TLMDShapeHint;
    LMDBackPanel2: TLMDBackPanel;
    lmdimglistbox: TLMDImageListBox;
    LMDBackPanel3: TLMDBackPanel;
    lmdtrack: TLMDTrackBar;
    LMDGroupBox1: TLMDGroupBox;
    chk: TLMDCheckBox;
    LMDSimpleLabel4: TLMDSimpleLabel;
    cmbalign: TComboBox;
    cmbfocus: TComboBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    Button1: TButton;
    Button2: TButton;
    LMDGroupBox2: TLMDGroupBox;
    Button3: TButton;
    Button4: TButton;
    LMDGroupBox3: TLMDGroupBox;
    cmbTick: TComboBox;
    cmbOrientation: TComboBox;
    Label1: TLabel;
    cmbcolor: TLMDColorComboBox;
    Label2: TLabel;
    Label3: TLabel;
    LMDImageList1: TLMDImageList;
    Button5: TButton;
    page1: TTabSheet;
    page2: TTabSheet;
    page3: TTabSheet;
    procedure cmbalignChange(Sender: TObject);
    procedure chkChange(Sender: TObject);
    procedure LMDExplorerButton1Click(Sender: TObject);
    procedure cmbfocusChange(Sender: TObject);
    procedure cmbTickChange(Sender: TObject);
    procedure cmbOrientationChange(Sender: TObject);
    procedure cmbcolorChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmTransDemo: TfrmTransDemo;

implementation

uses lmdgraph;

{$R *.DFM}

procedure TfrmTransDemo.cmbalignChange(Sender: TObject);
begin
  radiog.alignment:=TLMDGroupCaptionAlign(cmbalign.ItemIndex);
  chkg.alignment:=TLMDGroupCaptionAlign(cmbalign.ItemIndex);
end;

procedure TfrmTransDemo.chkChange(Sender: TObject);
begin
  chkg.Enabled:=chk.Checked;
  radiog.Enabled:=chk.Checked;
end;

procedure TfrmTransDemo.LMDExplorerButton1Click(Sender: TObject);
begin
 Close;
end;

procedure TfrmTransDemo.cmbfocusChange(Sender: TObject);
begin
  radiog.FocusStyle:=TLMDGlyphTextFocusStyle(cmbfocus.ItemIndex);
  chkg.FocusStyle:=TLMDGlyphTextFocusStyle(cmbfocus.ItemIndex);
end;

procedure TfrmTransDemo.cmbTickChange(Sender: TObject);
begin
  lmdtrack.TickMarks:=TLMDTickMarks(cmbTick.ItemIndex);
end;

procedure TfrmTransDemo.cmbOrientationChange(Sender: TObject);
begin
  with lmdtrack do
    case cmbOrientation.ItemIndex of
    0:
      begin
        visible:=False;
        Left:=20;
        Top:=200;
        Width:=284;
        Height:=31;
        Orientation:=toHorizontal;
        visible:=True;
      end;
    1:
      begin
        visible:=False;
        Left:=126;
        Top:=140;
        Width:=33;
        Height:=197;
        Orientation:=toVertical;
        visible:=True;
      end
    end;
end;

procedure TfrmTransDemo.cmbcolorChange(Sender: TObject);
begin
  lmdtrack.TickColor:=cmbcolor.SelectedColor;
end;

procedure TfrmTransDemo.FormCreate(Sender: TObject);
begin
  cmbColor.SelectedColor:=clBlack;
end;

procedure TfrmTransDemo.Button5Click(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                            mb_DefButton1 + MB_ICONQUESTION)=IDOK then
   Close

end;

end.
