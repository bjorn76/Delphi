{small demo for TLMDFormDisplay.

demonstrates:
- creating forms at runtime and assigning them to the TLMDFormdisplay control.
- Hiding Forms (play with SaveResources and check the difference! )
- Focus-Handling
- handling modal forms shown from page forms

Note:
If property SaveRessources is enabled, please set
BorderStyle: bsNone
BorderIcons: []
for all forms which should be displayed in a TLMDFormDisplay-component}

unit lmdfd1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  lmdcont, 
  LMDFormTabControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDFormDisplay, LMDControl, LMDBaseControl, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel, StdCtrls, ComCtrls;

type
  Tfdisplay0 = class(TForm)
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    fd: TLMDFormDisplay;
    LMDSimpleLabel1: TLMDSimpleLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    lmdtab: TLMDFormTabControl;
    LMDSimpleLabel4: TLMDSimpleLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure halloClick(Sender: TObject);
    procedure LMDButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fdisplay0: Tfdisplay0;

implementation

uses lmdfd2, lmdfd3, lmdfd4;

{$R *.DFM}

procedure Tfdisplay0.Button2Click(Sender: TObject);
begin
  Close
end;

procedure Tfdisplay0.FormCreate(Sender: TObject);
begin
  {add the forms to TLMDFormDisplay}
  fd.AddFormClass(Tt1, true);
  fd.AddFormClass(Tt2, false);
  fd.AddFormClass(Tt3, false);
  ComboBox1.ItemIndex:=0;
  ComboBox2.ItemIndex:=4;

  {ad the forms to TLMDFormDisplay}
  lmdtab.AddFormClass(Tt1, true);
  lmdtab.AddFormClass(Tt2, false);
  lmdtab.AddFormClass(Tt3, false);

end;

procedure Tfdisplay0.ComboBox1Change(Sender: TObject);
begin
  fd.ActiveFormIndex:=combobox1.ItemIndex;
end;

procedure Tfdisplay0.ComboBox2Change(Sender: TObject);
begin
  fd.Position:=TLMDFormDisplayPosition(combobox2.ItemIndex);
end;

procedure Tfdisplay0.halloClick(Sender: TObject);
begin
  fd.ActiveFormIndex:=-1;
end;

procedure Tfdisplay0.LMDButton1Click(Sender: TObject);
begin
  fd.MoveForm(fd.Forms[0], 2);
end;

end.
