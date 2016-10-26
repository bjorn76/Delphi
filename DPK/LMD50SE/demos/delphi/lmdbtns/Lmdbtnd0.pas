{
 Demo-Program which demonstrates some features of the
 new button classes and the use in connection with the new
 imagelist container.

 -------------------------------------------------------------
 © 95 - 97 by LMD Innovative
}

unit Lmdbtnd0;

interface

uses
  Windows,  ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, TabNotBk, Menus,
  lmdctrl, lmdbtn, lmdstdcS, ExtCtrls,
  lmdclass, lmdcont, lmdextcA, lmdextcS, lmdgraph, lmddlgS,
  lmdformA, lmdmmS, lmdshapA, lmdcompo, lmdcctrl, LMDWndProcComponent,
  LMDFormStyler, LMDContainerComponent, LMDBaseDialog, LMDDirDlg,
  LMDCustomComponent, LMDCustomMMButton, LMDMMButton, LMDCustomButton,
  LMDButton, LMDDockSpeedButton, LMDCustomTrackBar, LMDTrackBar,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, LMDCustomLabel, LMDLabel,
  LMDDrawEdge, LMDCustomShapeButton, LMDShapeButton, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel, LMDCustomSpeedButton,
  LMDSpeedButton, LMDControl, LMDBaseControl, LMDBaseGraphicButton,
  LMDCustom3DButton, LMD3DEffectButton;

type
  TLMDBtnForm = class(TForm)
    page6: TPageControl;
    LMDSpeedButton4: TLMDSpeedButton;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDShapeLabelButton1: TLMDShapeButton;
    LMDSpeedButton1: TLMDSpeedButton;
    LMDImageList1: TLMDImageList;
    LMDSpeedButton2: TLMDSpeedButton;
    LMDSpeedButton3: TLMDSpeedButton;
    LMDSpeedButton5: TLMDSpeedButton;
    LMDSimpleLabel4: TLMDSimpleLabel;
    Image2: TImage;
    LMDShapeButton1: TLMDShapeButton;
    LMDShapeLabelButton2: TLMDShapeButton;
    LMD3DShapeButton2: TLMDShapeButton;
    LMD3DShapeLabelButton1: TLMDShapeButton;
    LMDButton1: TLMDButton;
    LMDOfficeButton1: TLMDSpeedButton;
    LMDOfficeButton2: TLMDSpeedButton;
    LMDOfficeButton3: TLMDSpeedButton;
    LMDOfficeButton4: TLMDSpeedButton;
    LMDOfficeButton5: TLMDSpeedButton;
    LMDOfficeButton6: TLMDSpeedButton;
    LMD3DCaptionButton1: TLMD3DEffectButton;
    LMD3DCaptionButton2: TLMD3DEffectButton;
    LMDLabel1: TLMDLabel;
    PopupMenu1: TPopupMenu;
    LastProject1: TMenuItem;
    hottestproject1: TMenuItem;
    LMDOfficeButton7: TLMDSpeedButton;
    LMD3DEffectButton1: TLMD3DEffectButton;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDSimpleLabel6: TLMDSimpleLabel;
    LMDSimpleLabel7: TLMDSimpleLabel;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDSimpleLabel9: TLMDSimpleLabel;
    LMDSimpleLabel10: TLMDSimpleLabel;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDDrawEdge2: TLMDDrawEdge;
    LMDSpeedButton9: TLMDSpeedButton;
    LMDSpeedButton10: TLMDSpeedButton;
    LMDSpeedButton11: TLMDSpeedButton;
    LMDSpeedButton12: TLMDSpeedButton;
    LMDDrawEdge3: TLMDDrawEdge;
    LMDDrawEdge4: TLMDDrawEdge;
    LMDSpeedButton13: TLMDSpeedButton;
    LMDSimpleLabel11: TLMDSimpleLabel;
    LMDSimpleLabel12: TLMDSimpleLabel;
    LMDDrawEdge5: TLMDDrawEdge;
    LMDDrawEdge6: TLMDDrawEdge;
    s1: TLMDSpeedButton;
    s3: TLMDSpeedButton;
    s2: TLMDSpeedButton;
    LMDSimpleLabel14: TLMDSimpleLabel;
    LMDSimpleLabel15: TLMDSimpleLabel;
    LMDSimpleLabel16: TLMDSimpleLabel;
    LMDSimpleLabel17: TLMDSimpleLabel;
    LMDSimpleLabel18: TLMDSimpleLabel;
    LMDDrawEdge7: TLMDDrawEdge;
    LMDSimpleLabel19: TLMDSimpleLabel;
    LMD3DShapeLabelButton2: TLMDShapeButton;
    LMDSimpleLabel20: TLMDSimpleLabel;
    LMDSimpleLabel21: TLMDSimpleLabel;
    LMDDrawEdge8: TLMDDrawEdge;
    LMDSimpleLabel22: TLMDSimpleLabel;
    LMDSimpleLabel23: TLMDSimpleLabel;
    LMDDrawEdge9: TLMDDrawEdge;
    LMDSimpleLabel24: TLMDSimpleLabel;
    LMDSimpleLabel25: TLMDSimpleLabel;
    LMD3DCaptionButton3: TLMD3DEffectButton;
    LMDDrawEdge10: TLMDDrawEdge;
    LMDDrawEdge11: TLMDDrawEdge;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDDrawEdge12: TLMDDrawEdge;
    LMDBitmapList1: TLMDBitmapList;
    LMDButton2: TLMDButton;
    LMDDrawEdge13: TLMDDrawEdge;
    LMDDrawEdge14: TLMDDrawEdge;
    LMDSimpleLabel26: TLMDSimpleLabel;
    LMDButton3: TLMDButton;
    LMDSimpleLabel27: TLMDSimpleLabel;
    Edit1: TEdit;
    LMDDrawEdge15: TLMDDrawEdge;
    LMDSimpleLabel28: TLMDSimpleLabel;
    LMDDirDlg1: TLMDDirDlg;
    LMDDockSpeedButton1: TLMDDockSpeedButton;
    LMDDockSpeedButton2: TLMDDockSpeedButton;
    LMDDockSpeedButton3: TLMDDockSpeedButton;
    LMDDockSpeedButton4: TLMDDockSpeedButton;
    LMDDockSpeedButton5: TLMDDockSpeedButton;
    LMDDockSpeedButton6: TLMDDockSpeedButton;
    LMDDockSpeedButton7: TLMDDockSpeedButton;
    LMDFormStyler1: TLMDFormStyler;
    page0: TTabSheet;
    page1: TTabSheet;
    page4: TTabSheet;
    LMDBackPanel3: TLMDBackPanel;
    Image4: TImage;
    LMDSpeedButton25: TLMDSpeedButton;
    LMDSpeedButton26: TLMDSpeedButton;
    LMDSpeedButton27: TLMDSpeedButton;
    LMDSpeedButton28: TLMDSpeedButton;
    LMDSpeedButton29: TLMDSpeedButton;
    LMDSpeedButton30: TLMDSpeedButton;
    LMDSpeedButton31: TLMDSpeedButton;
    s4: TLMDSpeedButton;
    s5: TLMDSpeedButton;
    s6: TLMDSpeedButton;
    s7: TLMDSpeedButton;
    s8: TLMDSpeedButton;
    LMDSpeedButton6: TLMDSpeedButton;
    LMDSpeedButton7: TLMDSpeedButton;
    LMDSpeedButton8: TLMDSpeedButton;
    LMDSpeedButton14: TLMDSpeedButton;
    LMDSpeedButton15: TLMDSpeedButton;
    LMDSimpleLabel13: TLMDSimpleLabel;
    TabSheet1: TTabSheet;
    Label7: TLabel;
    btn1: TLMDSpeedButton;
    btn2: TLMDShapeButton;
    btn3: TLMDSpeedButton;
    btn4: TLMDShapeButton;
    Label8: TLabel;
    sbtn1: TLMDSpeedButton;
    sbtn2: TLMDSpeedButton;
    lbl3: TLMDLabel;
    LMDTrackBar1: TLMDTrackBar;
    Label6: TLabel;
    TabSheet2: TTabSheet;
    LMDBackPanel1: TLMDBackPanel;
    LMDMMButton9: TLMDMMButton;
    LMDMMButton8: TLMDMMButton;
    LMDMMButton6: TLMDMMButton;
    LMDMMButton5: TLMDMMButton;
    LMDMMButton7: TLMDMMButton;
    LMDMMButton4: TLMDMMButton;
    lbl2: TLMDSimpleLabel;
    LMDMMButton3: TLMDMMButton;
    LMDMMButton2: TLMDMMButton;
    lbl1: TLMDSimpleLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    LMDBitmapList2: TLMDBitmapList;
    PopupMenu2: TPopupMenu;
    gfskl1: TMenuItem;
    gfdsl1: TMenuItem;
    positionandtheMenusalignment1: TMenuItem;
    TabSheet3: TTabSheet;
    LMDBackPanel2: TLMDBackPanel;
    lbl5: TLMDSimpleLabel;
    lbl4: TLMDSimpleLabel;
    LMDMMButton1: TLMDMMButton;
    LMDMMButton10: TLMDMMButton;
    LMDMMButton11: TLMDMMButton;
    LMDMMButton12: TLMDMMButton;
    LMDMMButton14: TLMDMMButton;
    Label13: TLabel;
    LMDMMButton17: TLMDMMButton;
    LMDMMButton18: TLMDMMButton;
    Label14: TLabel;
    LMDMMButton13: TLMDMMButton;
    procedure LMDOfficeButton3Click(Sender: TObject);
    procedure LMDOfficeButton5Click(Sender: TObject);
    procedure LMDOfficeButton4Click(Sender: TObject);
    procedure LMDOfficeButton6Click(Sender: TObject);
    procedure s1Click(Sender: TObject);
    procedure LMDShapeLabelButton2MouseEnter(Sender: TObject);
    procedure LMDShapeLabelButton2MouseExit(Sender: TObject);
    procedure LMD3DCaptionButton3Click(Sender: TObject);
    procedure LMDDockButton1Click(Sender: TObject);
    procedure LMDTrackBar1Change(Sender: TObject);
    procedure LMDTrackBar1DrawTick(Sender: TObject; aCanvas: TCanvas;
      aValue: Integer; pos: TPoint);
    procedure sbtn1Click(Sender: TObject);
    procedure sbtn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LMDBtnForm: TLMDBtnForm;

implementation

{$R *.DFM}

procedure TLMDBtnForm.LMDOfficeButton3Click(Sender: TObject);
begin
  if LMDOfficeButton3.Pressed then
    LMDLabel1.Font.Style:=LMDLabel1.Font.Style+[fsBold]
  else
    LMDLabel1.Font.Style:=LMDLabel1.Font.Style-[fsBold];
end;

procedure TLMDBtnForm.LMDOfficeButton5Click(Sender: TObject);
begin
   if LMDOfficeButton5.Pressed then
    LMDLabel1.Font.Style:=LMDLabel1.Font.Style+[fsItalic]
  else
    LMDLabel1.Font.Style:=LMDLabel1.Font.Style-[fsItalic];
end;

procedure TLMDBtnForm.LMDOfficeButton4Click(Sender: TObject);
begin
   if LMDOfficeButton4.Pressed then
    LMDLabel1.Font.Style:=LMDLabel1.Font.Style+[fsUnderline]
  else
    LMDLabel1.Font.Style:=LMDLabel1.Font.Style-[fsUnderline];
end;

procedure TLMDBtnForm.LMDOfficeButton6Click(Sender: TObject);
begin
  if LMDOfficeButton6.Pressed then
    LMDLabel1.Font.Size:=10
  else
    LMDLabel1.Font.Size:=12;
end;

procedure TLMDBtnForm.s1Click(Sender: TObject);
begin
  s1.Style:=TLMDUserButtonStyle(TComponent(Sender).Tag);
  s2.Style:=s1.Style;
  s3.Style:=s1.Style;
  s4.Style:=s1.Style;
  s5.Style:=s1.Style;
  s6.Style:=s1.Style;
  s7.Style:=s1.Style;
  s8.Style:=s1.Style;
end;

procedure TLMDBtnForm.LMDShapeLabelButton2MouseEnter(Sender: TObject);
begin
  LMDShapeLabelButton2.FontFX.Tracing:=5;

end;

procedure TLMDBtnForm.LMDShapeLabelButton2MouseExit(Sender: TObject);
begin
  LMDShapeLabelButton2.FontFX.Tracing:=0;
end;

procedure TLMDBtnForm.LMD3DCaptionButton3Click(Sender: TObject);
begin
 Close;
end;

procedure TLMDBtnForm.LMDDockButton1Click(Sender: TObject);
begin
  LMDDirDlg1.execute;
  Edit1.Text:=LMDDirDlg1.Path;
end;

























procedure TLMDBtnForm.LMDTrackBar1Change(Sender: TObject);
begin
  sbtn1.RepeatingInterval:=lmdtrackbar1.position*50;
  sbtn2.RepeatingInterval:=lmdtrackbar1.position*50;
  btn1.RepeatingInterval:=lmdtrackbar1.position*50;
  btn2.RepeatingInterval:=lmdtrackbar1.position*50;
  btn3.RepeatingInterval:=lmdtrackbar1.position*50;
  btn4.RepeatingInterval:=lmdtrackbar1.position*50;
end;

procedure TLMDBtnForm.LMDTrackBar1DrawTick(Sender: TObject;
  aCanvas: TCanvas; aValue: Integer; pos: TPoint);
begin
  pos.Y:=pos.Y-30;
  if (aValue mod 1)=0 then
    begin
      aCanvas.Pen.Color:=clBlack;
      aCanvas.Brush.Color:=clBlack;
      aCanvas.MoveTo(pos.X,pos.Y);
      if (aValue mod 2)=0 then
        aCanvas.LineTo(pos.X,pos.Y+20)
      else
        begin
          aCanvas.Pen.Color:=clGray;
          aCanvas.LineTo(pos.X,pos.Y+10)
        end;
    end;
  if (aValue mod 2)=0 then
    begin
      aCanvas.Pen.Color:=clBlack;
      aCanvas.Brush.Color:=clSilver;
      aCanvas.TextOut(pos.X-20,pos.Y+20,inttostr(aValue*50));
    end;


end;

procedure TLMDBtnForm.sbtn1Click(Sender: TObject);
begin
  lbl3.Caption:=inttostr(strtoint(lbl3.Caption)+1);
end;

procedure TLMDBtnForm.sbtn2Click(Sender: TObject);
begin
  if strtoint(Lbl3.Caption)>0 then
    lbl3.Caption:=inttostr(strtoint(lbl3.Caption)-1);
end;

procedure TLMDBtnForm.btn1Click(Sender: TObject);
begin
  messagebeep(0);
end;





end.
