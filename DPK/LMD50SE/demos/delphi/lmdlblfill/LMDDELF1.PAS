{
 Demo-Program for TLMDLabelFill
 ------------------------------


 © 95 - 97 by LMD Innovative
}

unit Lmddelf1;

interface

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Tabs, lmdclass, lmdformA, lmdctrl, lmdstdcS,
  lmdextcA, StdCtrls, lmdextcS, lmdbtn, Tabnotbk, lmdcompo,
  LMDCustomComponent, LMDWndProcComponent, LMDFormStyler, LMDCustomButton,
  LMDButton, LMDControl, LMDBaseControl, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomLabel, LMDCustomLabelFill, LMDLabelFill;

type
  Tfrmlabelfill = class(TForm)
    note: TPageControl;
    LMDLabelFill6: TLMDLabelFill;
    LMDLabelFill7: TLMDLabelFill;
    LMDLabelFill8: TLMDLabelFill;
    LMDLabelFill4: TLMDLabelFill;
    LMDLabelFill5: TLMDLabelFill;
    LMDLabelFill3: TLMDLabelFill;
    LMDLabelFill2: TLMDLabelFill;
    LMDLabelFill1: TLMDLabelFill;
    lbl1: TLMDLabelFill;
    LMDFormStyler1: TLMDFormStyler;
    exitbtn: TLMDButton;
    page1: TTabSheet;
    page2: TTabSheet;
    page3: TTabSheet;
    procedure exitbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmlabelfill: Tfrmlabelfill;

implementation

{$R *.DFM}

procedure Tfrmlabelfill.exitbtnClick(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                             mb_DefButton1 + MB_ICONQUESTION)=IDOK then
   Close;
end;

end.
