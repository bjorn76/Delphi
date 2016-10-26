{
 Demo-Program for TLMDMousepositioner and TLMDMouseFencer.

 The following important elements are not demonstrated:
 ExecuteEnh (TLMDMousefencer):       mousecursor can be fenced on any
                                     rectangular area on form/control
 AutoActive (TLMDMouseFencer):       Fencing of mousecursor active after creating
                                     form

 Note:
 -----
 AutoActive is only usable normally after CREATING a form. If you hide a form
 after displaying, the AutoActive-functionality will not be activated by showing 

 © 95 - 97by LMD Innovative
}

unit Lmddemo0;

interface

uses
  Windows, ComCtrls, Forms, Dialogs,
  SysUtils, Messages, Classes, Graphics, Controls,
  LMDGraph, LMDCustomComponent, LMDWndProcComponent, LMDMouseBaseCtrl,
  LMDMousePositioner, LMDCustomButton, LMDButton, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel, LMDCustomControl, LMDCustomPanel,
  LMDCustomTrackBar, LMDTrackBar, LMDFill, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDGraphicControl, LMDTechnicalLine,
  LMDFormStyler, LMDMouseFencer, StdCtrls, ExtCtrls;

type
  Tfrmmousectrl1 = class(TForm)
    MousePositioner: TLMDMousePositioner;
    MouseFencer: TLMDMouseFencer;
    LMDFormStyler1: TLMDFormStyler;
    exitbtn: TButton;
    note: TPageControl;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    LMDSimpleLabel2: TLMDSimpleLabel;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    LMDTrackBar1: TLMDTrackBar;
    LMDFill1: TLMDFill;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    RadioGroup2: TRadioGroup;
    GroupBox2: TGroupBox;
    Button12: TButton;
    Button15: TButton;
    Button18: TButton;
    Button11: TButton;
    Button14: TButton;
    Button17: TButton;
    Button16: TButton;
    Button13: TButton;
    Button3: TButton;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    btnp: TLMDButton;
    btne: TLMDButton;
    g: TGroupBox;
    ListBox2: TListBox;
    LMDTechnicalLine1: TLMDTechnicalLine;
    Shape: TShape;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    page1: TTabSheet;
    page2: TTabSheet;
    procedure btnpClick(Sender: TObject);
    procedure btneClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure exitbtnClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure LMDTrackBar1Change(Sender: TObject);
    procedure LMDFill1Click(Sender: TObject);
    procedure noteChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmmousectrl1: Tfrmmousectrl1;

implementation

uses Lmddemo1;

{$R *.DFM}

procedure Tfrmmousectrl1.btnpClick(Sender: TObject);
begin
  frmmousectrl2:=Tfrmmousectrl2.Create(Self);
  Try
    frmmousectrl2.ShowModal;
  finally
    frmmousectrl2.Free;
  end;
end;

procedure Tfrmmousectrl1.btneClick(Sender: TObject);
begin
  Mousepositioner.Style:=mpClientArea;
  Mousepositioner.ExecuteEnh(shape.left+1,shape.top+1);
end;

procedure Tfrmmousectrl1.RadioGroup1Click(Sender: TObject);
begin
  if sender=RadioGroup1 then
    MouseFencer.Style:=TLMDMousePosStyle(RadioGroup1.ItemIndex)
  else
   MousePositioner.Style:=TLMDMousePosStyle(RadioGroup2.ItemIndex);
end;

procedure Tfrmmousectrl1.Button1Click(Sender: TObject);
begin
  MouseFencer.Execute;
end;

procedure Tfrmmousectrl1.exitbtnClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrmmousectrl1.ListBox1Click(Sender: TObject);
begin
  MouseFencer.Stop;
end;

procedure Tfrmmousectrl1.Button4Click(Sender: TObject);
begin
  MouseFencer.Stop;
end;

procedure Tfrmmousectrl1.ListBox1DblClick(Sender: TObject);
begin
  MouseFencer.Stop;
end;

procedure Tfrmmousectrl1.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  MouseFencer.Stop;
end;

procedure Tfrmmousectrl1.Button3Click(Sender: TObject);
begin
   MousePositioner.Position:=TLMDAlignment(TButton(Sender).Tag);
   MousePositioner.Execute;
end;

procedure Tfrmmousectrl1.ComboBox1Change(Sender: TObject);
begin
  case combobox1.itemindex of
  0:
    MouseFencer.Control:=listbox1;
  1:
    MouseFencer.Control:=lmdtrackbar1;
  2:
    MouseFencer.Control:=lmdfill1;
  end;
end;

procedure Tfrmmousectrl1.LMDTrackBar1Change(Sender: TObject);
begin
  MouseFencer.Stop;
end;

procedure Tfrmmousectrl1.LMDFill1Click(Sender: TObject);
begin
  MouseFencer.Stop;
end;

procedure Tfrmmousectrl1.noteChange(Sender: TObject);
begin
 if (note.ActivePage=page2) then
   begin
     MousePositioner.Control:=listbox2;
     //MousePositioner.Style:=mpDefaultButton;
   end;

end;

end.
