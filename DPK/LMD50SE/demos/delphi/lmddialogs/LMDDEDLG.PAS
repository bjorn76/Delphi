{
 Small demo-Program for dialog-components of LMD-Tools.
 This project demonstrates the common properties of the dialog components.

 © 95 -97 by LMD Innovative

 --------------------------------------------------------------------------------
}

unit Lmddedlg;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, lmddlgS, lmdclass, lmdctrl,
  lmdstdcS, lmdgraph, lmddedl0, lmddedl1, lmdnonvS, lmdcont, lmdgroup,
  lmdcompo, lmdcctrl, LMDWindowListDlg, LMDDirDlg, LMDTipDlg,
  LMDCustomComponent, LMDContainerComponent, LMDBaseDialog, LMDAboutDlg,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDCustomGroupBox, LMDCustomButtonGroup,
  LMDCustomRadioGroup, LMDRadioGroup, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel;

type
  Tfrmdlg = class(TForm)
    Button1: TButton;
    about: TLMDAboutDlg;
    rb1: TRadioGroup;
    rb2: TRadioGroup;
    tip: TLMDTipDlg;
    dir: TLMDDirDlg;
    Button2: TButton;
    rb4: TRadioGroup;
    ck: TCheckBox;
    ck2: TCheckBox;
    rg5: TRadioGroup;
    ck3: TCheckBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    wl: TLMDWindowListDlg;
    ck4: TCheckBox;
    ck5: TCheckBox;
    LMDBitmapList1: TLMDBitmapList;
    rbBA: TLMDRadioGroup;
    LMDSimpleLabel2: TLMDSimpleLabel;
    cbRP: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure aboutCustomClick(Sender: TObject);
    procedure Customize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  frmdlg: Tfrmdlg;

implementation

{$R *.DFM}

procedure Tfrmdlg.Button1Click(Sender: TObject);
var
  dummy, li:Integer;
  deffect:TLMDDlgEffect;
  tmp:String;
  shint, cf:Boolean;
begin
  case rb4.ItemIndex of
    1:deffect:=deExplode;
    2:deffect:=deExplodeext;
  else
    deffect:=deNone;
  end;

  if ck.State=cbChecked then tmp:='My Button' else tmp:='';
  sHint:=ck2.Checked;
  cf:=ck4.Checked;
  li:=Ord(not ck5.Checked);
  dummy:=rb1.Itemindex+rb2.itemindex*10;
  case dummy of
   0, 10, 20, 30:
          with about do
            begin
              IconStyle:=TLMDAboutIconStyle(rg5.ItemIndex);
              if ck3.Checked then OnCustomize:=Customize else OnCustomize:=nil;
              CustomButton:=tmp;
              Effect:=deffect;
              ShowHints:=sHint;
              CaptionFill:=cf;
              ListIndex:=li;
              Style:=TLMDAboutStyle(rb2.Itemindex);
              Position := TLMDDlgPosition (rbBA.ItemIndex+1);
              RelatePos:= TLMDDlgPosRel(cbRP.ItemIndex);
              Execute;
            end;
   1, 11, 21, 31:
          with dir do
            begin
              CustomButton:=tmp;
              if ck3.Checked then OnCustomize:=Customize else OnCustomize:=nil;
              Effect:=deffect;
              ShowHints:=sHint;
              CaptionFill:=cf;
              ListIndex:=li;
              Position := TLMDDlgPosition (rbBA.ItemIndex+1);
              RelatePos:= TLMDDlgPosRel(cbRP.ItemIndex);
              Execute;
            end;
   2,12, 22,32:
          with tip do
            begin
              ShowHints:=sHint;
              if ck3.Checked then OnCustomize:=Customize else OnCustomize:=nil;
              CustomButton:=tmp;
              Effect:=deffect;
              CaptionFill:=cf;
              ListIndex:=li;
              Position := TLMDDlgPosition (rbBA.ItemIndex+1);
              RelatePos:= TLMDDlgPosRel(cbRP.ItemIndex);
              Execute;
            end;
    3,13, 23,33:
          with wl do
            begin
              ShowHints:=sHint;
              if ck3.Checked then OnCustomize:=Customize else OnCustomize:=nil;
              CustomButton:=tmp;
              Effect:=deffect;
              CaptionFill:=cf;
              ListIndex:=li;
              Position := TLMDDlgPosition (rbBA.ItemIndex+1);
              RelatePos:= TLMDDlgPosRel(cbRP.ItemIndex);
              Execute;
            end;
  end;
end;

procedure Tfrmdlg.Button2Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmdlg.aboutCustomClick(Sender: TObject);
begin
  showmessage('The custom button was clicked!');
end;

procedure Tfrmdlg.Customize(Sender: TObject);
begin
  TForm(Sender).Color:=clBlue;
end;

procedure Tfrmdlg.FormCreate(Sender: TObject);
begin
  test1:=TTest1.Create(nil);
  test2:=TTest2.Create(nil);
end;

procedure Tfrmdlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(test1) then test1.Free;
  if Assigned(test2) then test2.Free;
end;



end.
