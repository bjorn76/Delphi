unit Lmdgrlab;

interface

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, lmdstdcA, lmdextcS, lmdstdcS, lmdbtn, lmdctrl,
  lmdextcA, ExtCtrls, Tabs, lmdclass, lmdformA, TabNotBk, lmdcompo,
  lmdcctrl, LMDCustomComponent, LMDWndProcComponent, LMDFormStyler,
  LMDDrawEdge, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel,
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDSpeedButton,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel,
  LMDControl, LMDBaseControl, LMDBaseGraphicControl, LMDGraphicControl,
  LMDCustomGraphicLabel, LMDGraphicLabel;

type
  TfrmGrLabDemo = class(TForm)
    note: TPageControl;
    LMDGraphicLabel1: TLMDGraphicLabel;
    LMDGraphicLabel2: TLMDGraphicLabel;
    LMDGraphicLabel9: TLMDGraphicLabel;
    LMDGraphicLabel5: TLMDGraphicLabel;
    LMDGraphicLabel6: TLMDGraphicLabel;
    LMDGraphicLabel3: TLMDGraphicLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSpeedButton1: TLMDSpeedButton;
    LMDSpeedButton2: TLMDSpeedButton;
    LMDSpeedButton3: TLMDSpeedButton;
    LMDSpeedButton4: TLMDSpeedButton;
    LMDSpeedButton5: TLMDSpeedButton;
    LMDSpeedButton6: TLMDSpeedButton;
    LMDSpeedButton7: TLMDSpeedButton;
    LMDSpeedButton8: TLMDSpeedButton;
    LMDSpeedButton9: TLMDSpeedButton;
    LMDSpeedButton10: TLMDSpeedButton;
    LMDSpeedButton11: TLMDSpeedButton;
    LMDSpeedButton12: TLMDSpeedButton;
    LMDSpeedButton13: TLMDSpeedButton;
    LMDSpeedButton14: TLMDSpeedButton;
    LMDSpeedButton15: TLMDSpeedButton;
    LMDSpeedButton16: TLMDSpeedButton;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDSpeedButton17: TLMDSpeedButton;
    LMDSpeedButton18: TLMDSpeedButton;
    LMDSpeedButton19: TLMDSpeedButton;
    LMDDrawEdge2: TLMDDrawEdge;
    LMDDrawEdge3: TLMDDrawEdge;
    LMDSpinEdit: TLMDSpinEdit;
    LMDGraphicLabel: TLMDGraphicLabel;
    FontDialog: TFontDialog;
    LMDFormStyler1: TLMDFormStyler;
    Label1: TLabel;
    Button1: TButton;
    page1: TTabSheet;
    page2: TTabSheet;
    procedure LMDSpinEditChange(Sender: TObject);
    procedure LMDSpeedButton1Click(Sender: TObject);
    procedure LMDSpeedButton4Click(Sender: TObject);
    procedure LMDSpeedButton8Click(Sender: TObject);
    procedure LMDSpeedButton12Click(Sender: TObject);
    procedure LMDSpeedButton3Click(Sender: TObject);
    procedure LMDSpeedButton10Click(Sender: TObject);
    procedure LMDSpeedButton2Click(Sender: TObject);
    procedure LMDSpeedButton11Click(Sender: TObject);
    procedure LMDSpeedButton5Click(Sender: TObject);
    procedure LMDSpeedButton9Click(Sender: TObject);
    procedure LMDSpeedButton6Click(Sender: TObject);
    procedure LMDSpeedButton7Click(Sender: TObject);
    procedure LMDSpeedButton13Click(Sender: TObject);
    procedure LMDSpeedButton14Click(Sender: TObject);
    procedure LMDSpeedButton15Click(Sender: TObject);
    procedure LMDSpeedButton16Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmGrLabDemo: TfrmGrLabDemo;

implementation

uses
lmdgrlf;

{$R *.DFM}

procedure TfrmGrLabDemo.LMDSpeedButton1Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmWave;
end;

procedure TfrmGrLabDemo.LMDSpeedButton7Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmFly;
end;

procedure TfrmGrLabDemo.LMDSpeedButton8Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmEnterprise;
end;

procedure TfrmGrLabDemo.LMDSpeedButton9Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmBuckled;
end;

procedure TfrmGrLabDemo.LMDSpeedButton10Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmInvStairs;
end;

procedure TfrmGrLabDemo.LMDSpeedButton11Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmInvSpeaker;
end;

procedure TfrmGrLabDemo.LMDSpeedButton12Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmHalfmoon;
end;

procedure TfrmGrLabDemo.LMDSpeedButton14Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmRNoseUp;
end;

procedure TfrmGrLabDemo.LMDSpeedButton16Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmRNoseDown;
end;

procedure TfrmGrLabDemo.LMDSpeedButton2Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmSpeaker;
end;

procedure TfrmGrLabDemo.LMDSpeedButton3Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmStairs;
end;

procedure TfrmGrLabDemo.LMDSpeedButton4Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmNone;
end;

procedure TfrmGrLabDemo.LMDSpeedButton5Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmChair;
end;

procedure TfrmGrLabDemo.LMDSpeedButton6Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmCube;
end;

procedure TfrmGrLabDemo.LMDSpeedButton13Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmLNoseUp;
end;

procedure TfrmGrLabDemo.LMDSpeedButton15Click(Sender: TObject);
begin
  LMDGraphicLabel.Transform := tmLNoseDown;
end;

procedure TfrmGrLabDemo.LMDSpinEditChange(Sender: TObject);
begin
  LMDGraphicLabel.Factor := LMDSpinEdit.Value;
end;

procedure TfrmGrLabDemo.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure TfrmGrLabDemo.FormCreate(Sender: TObject);
begin
  {$IFNDEF WIN32} note.TabsPerRow:=4; {$ENDIF}
end;

end.
