{
Demo-Program for TLMDFontComboBoxes
***********************************

Please note that the FontSizeComboBox is 'docked' to the TLMDFontComboBox.

© 95 - 97 by LMD Innovative
}



unit LMDfcb0;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, 
  lmdclass, lmdformA, LMDCustomComponent, LMDWndProcComponent,
  LMDFormStyler, LMDFontSizeComboBox, LMDCustomComboBox, LMDFontComboBox,
  LMDCustomLabel, LMDLabel, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel;

type
  Tfrmfontbox = class(TForm)
    LMDSimpleLabel1: TLMDSimpleLabel;
    lb: TLMDLabel;
    Button4: TButton;
    fc: TLMDFontComboBox;
    GroupBox1: TGroupBox;
    ck1: TCheckBox;
    ck2: TCheckBox;
    ck3: TCheckBox;
    fsc: TLMDFontSizeComboBox;
    LMDSimpleLabel3: TLMDSimpleLabel;
    ck4: TCheckBox;
    ck5: TCheckBox;
    LMDFormStyler1: TLMDFormStyler;
    LMDSimpleLabel2: TLMDSimpleLabel;
    ck6: TCheckBox;
    ck7: TCheckBox;
    procedure ck1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ck4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fscChange(Sender: TObject);
    procedure fcChange(Sender: TObject);
  private
    procedure SetOptions;
  public

  end;

var
  frmfontbox: Tfrmfontbox;

const
  fmessage='Background of this'#13'Label displays'#13'selected Color';

implementation

{$R *.DFM}

procedure Tfrmfontbox.SetOptions;
var
  opt:TLMDFontCBOptions;
begin
  opt:=[];
  if ck1.Checked then opt:=[foPrinterFonts];
  if ck2.Checked then opt:=opt+[foScreenFonts];
  if ck3.Checked then opt:=opt+[foTrueTypeOnly];
  if ck6.Checked then opt:=opt+[foDisplayFont];
  if ck7.Checked then opt:=opt+[foDisplaySymbol];
  fc.Options:=opt;
end;

procedure Tfrmfontbox.ck1Click(Sender: TObject);
begin
  SetOptions;
end;

procedure Tfrmfontbox.Button4Click(Sender: TObject);
begin
  Close;
end;

procedure Tfrmfontbox.ck4Click(Sender: TObject);
begin
  fsc.UseNearestSize:=ck4.Checked;
  fsc.EditorEnabled:=ck5.Checked;
end;

procedure Tfrmfontbox.FormCreate(Sender: TObject);
begin
  fc.SelectedFont:=lb.Font.Name;
  fsc.FontSize:=lb.Font.Size;
end;

procedure Tfrmfontbox.fscChange(Sender: TObject);
begin
  lb.Font.Size:=fsc.FontSize;
end;

procedure Tfrmfontbox.fcChange(Sender: TObject);
begin
  lb.Font.Name:=fc.SelectedFont;
end;


end.
