unit Lmdilbx;

interface

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, lmdextcS, lmdclass, lmdformA, lmdctrl,
  lmdstdcS, lmdcont, TabNotBk, lmdbtn, lmdstdcA, lmdcompo, lmdcombo,
  lmdcctrl, LMDCustomComponent, LMDWndProcComponent, LMDFormStyler,
  LMDSimplePanel, LMDCustomScrollBox, LMDListBox, LMDCustomComboBox,
  LMDCustomImageComboBox, LMDImageComboBox, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  LMDCustomImageListBox, LMDImageListBox, LMDBaseGraphicButton,
  LMDCustomSpeedButton, LMDSpeedButton, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel;

type
  TfrmLMDImageListBoxDemo = class(TForm)
    TabbedNotebook1: TPageControl;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDFormStyler1: TLMDFormStyler;
    LMDImageListBox1: TLMDImageListBox;
    LMDImageList1: TLMDImageList;
    LMDImageListBox2: TLMDImageListBox;
    LMDSpeedButton1: TLMDSpeedButton;
    LMDImageListBox3: TLMDImageListBox;
    LMDImageListBox4: TLMDImageListBox;
    LMDSpeedButton2: TLMDSpeedButton;
    LMDBackPanel1: TLMDBackPanel;
    LMDImageListBox5: TLMDImageListBox;
    LMDImageListBox6: TLMDImageListBox;
    LMDImageListBox7: TLMDImageListBox;
    LMDListBox1: TLMDListBox;
    LMDSpinEdit1: TLMDSpinEdit;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSpeedButton3: TLMDSpeedButton;
    Edit1: TEdit;
    LMDSpinEdit2: TLMDSpinEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSpeedButton4: TLMDSpeedButton;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDSimpleLabel6: TLMDSimpleLabel;
    LMDSimpleLabel7: TLMDSimpleLabel;
    page1: TTabSheet;
    pag2: TTabSheet;
    page3: TTabSheet;
    pag4: TTabSheet;
    TabSheet1: TTabSheet;
    LMDImageListBox8: TLMDImageListBox;
    LMDImageComboBox1: TLMDImageComboBox;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDSimpleLabel9: TLMDSimpleLabel;
    LMDSimpleLabel10: TLMDSimpleLabel;
    procedure LMDImageListBox1Click(Sender: TObject);
    procedure LMDImageListBox3Click(Sender: TObject);
    procedure LMDSpinEdit1Change(Sender: TObject);
    procedure LMDListBox1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure LMDSpinEdit2Change(Sender: TObject);
    procedure LMDSpeedButton3Click(Sender: TObject);
    procedure LMDSpeedButton4Click(Sender: TObject);
  private
    setting : boolean;
  public
    { Public-Deklarationen }
  end;

var
  frmLMDImageListBoxDemo: TfrmLMDImageListBoxDemo;

implementation

{$R *.DFM}

procedure TfrmLMDImageListBoxDemo.LMDImageListBox1Click(Sender: TObject);
begin
  LMDSpeedButton1.ImageIndex := LMDImageListBox1.ItemIndex;
end;

procedure TfrmLMDImageListBoxDemo.LMDImageListBox3Click(Sender: TObject);
begin
  LMDSpeedButton2.Caption := LMDImageListBox3.Items[LMDImageListBox3.ItemIndex];
end;

procedure TfrmLMDImageListBoxDemo.LMDSpinEdit1Change(Sender: TObject);
begin
  LMDImageListBox7.Columns := LMDSpinEdit1.Value;
end;

procedure TfrmLMDImageListBoxDemo.LMDListBox1Click(Sender: TObject);
var
  s, s2: string;
begin
  setting := true;
  s := LMDListBox1.Items[LMDListBox1.ItemIndex];
  s2 := Copy (s, 1, Pos('|',s)-1);
  Edit1.Text := s2;

  s2 := Copy (s, Pos('|',s)+1, Length(s)-Pos('|',s));

  LMDSpinEdit2.Value := StrToInt (s2);
  setting := false;
end;

procedure TfrmLMDImageListBoxDemo.Edit1Change(Sender: TObject);
var
  s : string;
  i : longint;
begin
  if setting then exit;
  s := LMDListBox1.Items[LMDListBox1.ItemIndex];
  Delete (s, 1, Pos('|',s)-1);
  s := Edit1.Text+s;
  i := LMDListBox1.ItemIndex;
  LMDListBox1.Items[LMDListBox1.ItemIndex] := s;
  LMDListBox1.ItemIndex := i;
end;

procedure TfrmLMDImageListBoxDemo.LMDSpinEdit2Change(Sender: TObject);
var
  s : string;
  i : longint;
begin
  if setting then exit;
  s := LMDListBox1.Items[LMDListBox1.ItemIndex];
  Delete (s, Pos('|',s)+1, Length(s)-Pos('|',s));
  s := s+IntToStr(LMDSpinEdit2.Value);
  i := LMDListBox1.ItemIndex;
  LMDListBox1.Items[LMDListBox1.ItemIndex] := s;
  LMDListBox1.ItemIndex := i;
end;

procedure TfrmLMDImageListBoxDemo.LMDSpeedButton3Click(Sender: TObject);
begin
  LMDImageListBox7.Items.Assign (LMDListBox1.Items);
end;

procedure TfrmLMDImageListBoxDemo.LMDSpeedButton4Click(Sender: TObject);
begin
  Close;
end;




end.
