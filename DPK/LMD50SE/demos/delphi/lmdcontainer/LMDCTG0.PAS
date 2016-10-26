{
 Demo-Program Container Controls
 -------------------------------

 This demo demonstrate how to share image-/wave- or string resources among
 several forms. Unlike the demo in the delphi 1 directory the container
 controls are placed on a TDataModule.

 If you're writing Delphi 32bit applications only you should use TDataModules
 and the LMDContainer controls for sharing data. If you have to write
 16bit code you should use a TLMDContainerCtrl control like demonstrated
 in the demoproject in the Delphi 1 directory.


 © 95 - 97 by LMD Innovative
}

unit Lmdctg0;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,

  lmdctrl, lmdbtn, lmdclass, lmdformA, lmdcont, lmdextcA, lmdutils,

  Lmdctg1, Lmdctg2, Lmdctg3, lmddlgS, StdCtrls, ExtCtrls, lmdstdcS,
  lmdctrlA, lmdstdcA, ComCtrls, Tabnotbk, lmdcompo, lmdcctrl,
  LMDContainerComponent, LMDBaseDialog, LMDAboutDlg, LMDCustomComponent,
  LMDWndProcComponent, LMDFormStyler, LMDCustomButton, LMDButton,
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDSpeedButton, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel;

type
  TCont0 = class(TForm)
    PopupMenu1: TPopupMenu;
    o1: TMenuItem;
    o2: TMenuItem;
    o3: TMenuItem;
    LMDFormStyler1: TLMDFormStyler;
    about: TLMDAboutDlg;
    TabbedNotebook1: TPageControl;
    LMDBackPanel1: TLMDBackPanel;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDExplorerButton1: TLMDSpeedButton;
    LMDButton1: TLMDButton;
    LMDExplorerButton3: TLMDSpeedButton;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDExplorerButton2: TLMDSpeedButton;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDExplorerButton4: TLMDSpeedButton;
    Page21: TTabSheet;
    page31: TTabSheet;
    page41: TTabSheet;
    Page11: TTabSheet;
    procedure LMDExplorerButton4Click(Sender: TObject);
    procedure o1Click(Sender: TObject);
    procedure LMDExplorerButton1Click(Sender: TObject);
    procedure LMDButton1Click(Sender: TObject);
    procedure LMDExplorerButton2Click(Sender: TObject);
    procedure LMDExplorerButton4DblClick(Sender: TObject);
    procedure LMDExplorerButton3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Cont0: TCont0;

implementation

uses lmdctg4;

{$R *.DFM}

procedure TCont0.LMDExplorerButton4Click(Sender: TObject);
begin
  LMDShowModal(TCont3, self);
end;

procedure TCont0.o1Click(Sender: TObject);
begin
  if sender=o1 then LMDShowModal(TCont1, self)
  else if sender=o2 then LMDShowModal(TCont2, self)
  else if sender=o3 then LMDShowModal(TCont3, self);
end;

procedure TCont0.LMDExplorerButton1Click(Sender: TObject);
begin
  about.ExecuteEnh(self);
end;

procedure TCont0.LMDButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TCont0.LMDExplorerButton2Click(Sender: TObject);
begin
  LMDShowModal(TCont2, self)
end;

procedure TCont0.LMDExplorerButton4DblClick(Sender: TObject);
begin
  LMDShowModal(TCont1, self)
end;

procedure TCont0.LMDExplorerButton3Click(Sender: TObject);
begin
  LMDShowModal(TCont1, self)
end;

end.
