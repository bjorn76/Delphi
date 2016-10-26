{
 Demo-Program which demonstrates some features of the new
 TLMDTechnicalLine component.

 -------------------------------------------------------------

 © 95 - 97 by LMD Innovative
}


unit Lmdtech0;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Tabs, ExtCtrls, StdCtrls,
  lmdclass, lmdformA, ComCtrls, LMDCustomComponent,
  LMDWndProcComponent, LMDFormStyler, LMDCustomComboBox,
  LMDCustomColorComboBox, LMDColorComboBox, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDGraphicControl, LMDTechnicalLine;

type
  Tfrmtechline = class(TForm)
    note: TPageControl;
    LMDTechnicalLine1: TLMDTechnicalLine;
    LMDTechnicalLine2: TLMDTechnicalLine;
    LMDTechnicalLine3: TLMDTechnicalLine;
    LMDTechnicalLine4: TLMDTechnicalLine;
    LMDTechnicalLine: TLMDTechnicalLine;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox3: TComboBox;
    Label3: TLabel;
    LMDColorComboBox1: TLMDColorComboBox;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    RadioGroup1: TRadioGroup;
    LMDTechnicalLine5: TLMDTechnicalLine;
    LMDFormStyler1: TLMDFormStyler;
    Button1: TButton;
    Label5: TLabel;
    LMDColorComboBox2: TLMDColorComboBox;
    page1: TTabSheet;
    page2: TTabSheet;
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure LMDColorComboBox1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmtechline: Tfrmtechline;

implementation

{$R *.DFM}

procedure Tfrmtechline.ComboBox1Change(Sender: TObject);
begin
  Case ComboBox1.ItemIndex Of
     0 : LMDTechnicalLine.LineType := lsTopLeftCurve;
     1 : LMDTechnicalLine.LineType := lsTopLeftEdge;
     2 : LMDTechnicalLine.LineType := lsTopRightCurve;
     3 : LMDTechnicalLine.LineType := lsTopRightEdge;
     4 : LMDTechnicalLine.LineType := lsBottomLeftCurve;
     5 : LMDTechnicalLine.LineType := lsBottomLeftEdge;
     6 : LMDTechnicalLine.LineType := lsBottomRightCurve;
     7 : LMDTechnicalLine.LineType := lsBottomRightEdge;
     8 : LMDTechnicalLine.LineType := lsStraightLeftToRight;
     9 : LMDTechnicalLine.LineType := lsStraightTopToBottom;
    10 : LMDTechnicalLine.LineType := lsTopLeftToBottomRight;
    11 : LMDTechnicalLine.LineType := lsBottomLeftToTopRight;
  end;
end;

procedure Tfrmtechline.ComboBox2Change(Sender: TObject);
begin
  Case ComboBox2.ItemIndex Of
     0 : LMDTechnicalLine.LineStartSign := leCircle;
     1 : LMDTechnicalLine.LineStartSign := leRectangle;
     2 : LMDTechnicalLine.LineStartSign := leRoundRect;
     3 : LMDTechnicalLine.LineStartSign := leParallelogramm;
     4 : LMDTechnicalLine.LineStartSign := leComb;
     5 : LMDTechnicalLine.LineStartSign := leDiamond;
     6 : LMDTechnicalLine.LineStartSign := leClosedArrowLeft;
     7 : LMDTechnicalLine.LineStartSign := leClosedArrowRight;
     8 : LMDTechnicalLine.LineStartSign := leClosedArrowUp;
     9 : LMDTechnicalLine.LineStartSign := leClosedArrowDown;
    10 : LMDTechnicalLine.LineStartSign := leOpenArrowLeft;
    11 : LMDTechnicalLine.LineStartSign := leOpenArrowRight;
    12 : LMDTechnicalLine.LineStartSign := leOpenArrowUp;
    13 : LMDTechnicalLine.LineStartSign := leOpenArrowDown;
    14 : LMDTechnicalLine.LineStartSign := leHalfcircleLeft;
    15 : LMDTechnicalLine.LineStartSign := leHalfcircleRight;
    16 : LMDTechnicalLine.LineStartSign := leHalfcircleUp;
    17 : LMDTechnicalLine.LineStartSign := leHalfcircleDown;
    18 : LMDTechnicalLine.LineStartSign := leNothing;
  end;
end;

procedure Tfrmtechline.ComboBox3Change(Sender: TObject);
begin
  Case ComboBox3.ItemIndex Of
     0 : LMDTechnicalLine.LineEndingSign := leCircle;
     1 : LMDTechnicalLine.LineEndingSign := leRectangle;
     2 : LMDTechnicalLine.LineEndingSign := leRoundRect;
     3 : LMDTechnicalLine.LineEndingSign := leParallelogramm;
     4 : LMDTechnicalLine.LineEndingSign := leComb;
     5 : LMDTechnicalLine.LineEndingSign := leDiamond;
     6 : LMDTechnicalLine.LineEndingSign := leClosedArrowLeft;
     7 : LMDTechnicalLine.LineEndingSign := leClosedArrowRight;
     8 : LMDTechnicalLine.LineEndingSign := leClosedArrowUp;
     9 : LMDTechnicalLine.LineEndingSign := leClosedArrowDown;
    10 : LMDTechnicalLine.LineEndingSign := leOpenArrowLeft;
    11 : LMDTechnicalLine.LineEndingSign := leOpenArrowRight;
    12 : LMDTechnicalLine.LineEndingSign := leOpenArrowUp;
    13 : LMDTechnicalLine.LineEndingSign := leOpenArrowDown;
    14 : LMDTechnicalLine.LineEndingSign := leHalfcircleLeft;
    15 : LMDTechnicalLine.LineEndingSign := leHalfcircleRight;
    16 : LMDTechnicalLine.LineEndingSign := leHalfcircleUp;
    17 : LMDTechnicalLine.LineEndingSign := leHalfcircleDown;
    18 : LMDTechnicalLine.LineEndingSign := leNothing;
  end;
end;

procedure Tfrmtechline.CheckBox1Click(Sender: TObject);
begin
  LMDTechnicalLine.ShadowVisible := CheckBox1.Checked;
end;

procedure Tfrmtechline.LMDColorComboBox1Change(Sender: TObject);
begin
  if sender=LMDColorComboBox1 then
    LMDTechnicalLine.FillColor := LMDColorComboBox1.SelectedColor
  else
    LMDTechnicalLine.LineSettings.Color := LMDColorComboBox2.SelectedColor
end;

procedure Tfrmtechline.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex Of
    0 : LMDTechnicalLine.SignPlaces := spStart;
    1 : LMDTechnicalLine.SignPlaces := spEnd;
    2 : LMDTechnicalLine.SignPlaces := spBoth;
    3 : LMDTechnicalLine.SignPlaces := spNoWhere;
  end;
end;

procedure Tfrmtechline.FormCreate(Sender: TObject);
begin
  {$IFNDEF WIN32} note.TabsPerRow:=4; {$ENDIF}
  LMDColorComboBox2.SelectedColor:=clBlack;
end;

procedure Tfrmtechline.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
