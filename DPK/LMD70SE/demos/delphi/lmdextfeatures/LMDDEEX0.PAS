{
 Demo-Program for several extended controls of LMD-Tools
 -------------------------------------------------------


 © 95 - 97 by LMD Innovative
}

unit Lmddeex0;

interface

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Tabs, lmdclass, lmdformA,
  lmdcont, LMDCustomComponent,
  LMDWndProcComponent, LMDFormStyler, LMDCustomButton, LMDButton,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDCustomPanelFill, LMDPanelFill,
  LMDCustomLabelFill, LMDLabelFill, LMDBaseMeter, LMDCustomProgressFill,
  LMDProgressFill, LMDShadowFill, LMDCustomLabel, LMDLabel, LMDBaseImage,
  LMDCustomNImage, LMDNImage, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDControl, LMDBaseControl, LMDBaseGraphicControl,
  LMDGraphicControl, LMDFill, LMDBaseController, LMDCustomContainer,
  LMDCustomImageList, LMDBitmapList, StdCtrls;

type
  Tfrmextct = class(TForm)
    note: TPageControl;
    LMDFill2: TLMDFill;
    LMDSimpleLabel14: TLMDSimpleLabel;
    LMDNImage5: TLMDNImage;
    LMDNImage6: TLMDNImage;
    LMDSimpleLabel15: TLMDSimpleLabel;
    LMDSimpleLabel16: TLMDSimpleLabel;
    LMDSimpleLabel17: TLMDSimpleLabel;
    LMDNImage8: TLMDNImage;
    LMDSimpleLabel18: TLMDSimpleLabel;
    LMDSimpleLabel19: TLMDSimpleLabel;
    LMDSimpleLabel28: TLMDSimpleLabel;
    LMDFill4: TLMDFill;
    LMDFill3: TLMDFill;
    LMDFill5: TLMDFill;
    LMDFill6: TLMDFill;
    LMDFill7: TLMDFill;
    LMDFill8: TLMDFill;
    LMDFill9: TLMDFill;
    LMDLabel1: TLMDLabel;
    LMDShadowFill1: TLMDShadowFill;
    LMDShadowFill2: TLMDShadowFill;
    LMDFormStyler1: TLMDFormStyler;
    LMDNImage1: TLMDNImage;
    LMDButton1: TLMDButton;
    TabSheet1: TTabSheet;
    page1: TTabSheet;
    page2: TTabSheet;
    LMDFill1: TLMDFill;
    LMDProgressFill2: TLMDProgressFill;
    LMDLabelFill2: TLMDLabelFill;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSimpleLabel11: TLMDSimpleLabel;
    LMDPanelFill2: TLMDPanelFill;
    LMDBitmapList1: TLMDBitmapList;
    TabSheet2: TTabSheet;
    LMDSimpleLabel12: TLMDSimpleLabel;
    LMDPanelFill3: TLMDPanelFill;
    LMDPanelFill4: TLMDPanelFill;
    LMDPanelFill5: TLMDPanelFill;
    LMDPanelFill6: TLMDPanelFill;
    LMDSimpleLabel4: TLMDSimpleLabel;
    procedure LMDButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmextct: Tfrmextct;

implementation

{$R *.DFM}

procedure Tfrmextct.LMDButton1Click(Sender: TObject);
begin
  if Application.MessageBox('Do you really want to exit?', 'LMD Tools', mb_OKCancel +
                            mb_DefButton1 + MB_ICONQUESTION)=IDOK then
   Close;
end;





end.
