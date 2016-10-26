{
 Demo-Program TLMDAssist
 -----------------------

 Writing wizards is fairly easy with the TLMDAssist control....

 ------------------------------------------------------------------------------
 © 95 - 98 by LMD Innovative
}

unit lmdassi1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, lmdcont, LMDWndProcComponent,
  LMDFormStyler, LMDContainerComponent, LMDBaseDialog, LMDAboutDlg,
  LMDCustomComponent, LMDCustomDockLabel, LMDDockLabel, LMDGraphicControl,
  LMDBaseImage, LMDCustomLImage, LMDLImage, LMDCustomPanel,
  LMDCustomBevelPanel, LMDSimplePanel, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDCustomControl, LMDAssist, LMDBaseController,
  LMDCustomContainer, LMDCustomImageList, LMDBitmapList;

type
  Tfrmassist = class(TForm)
    assist: TLMDAssist;
    page1: TLMDAssistPage;
    LMDBitmapList1: TLMDBitmapList;
    about: TLMDAboutDlg;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLImage1: TLMDLImage;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    ck1: TCheckBox;
    LMDAssistPage1: TLMDAssistPage;
    ck2: TCheckBox;
    LMDAssistPage2: TLMDAssistPage;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLImage2: TLMDLImage;
    LMDSimpleLabel5: TLMDSimpleLabel;
    ed3: TMemo;
    ed1: TEdit;
    LMDDockLabel1: TLMDDockLabel;
    LMDDockLabel2: TLMDDockLabel;
    ed2: TEdit;
    LMDDockLabel3: TLMDDockLabel;
    LMDDockLabel4: TLMDDockLabel;
    ed4: TEdit;
    LMDDockLabel5: TLMDDockLabel;
    ed6: TEdit;
    LMDDockLabel6: TLMDDockLabel;
    ed5: TEdit;
    LMDSimpleLabel6: TLMDSimpleLabel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLImage3: TLMDLImage;
    LMDSimpleLabel7: TLMDSimpleLabel;
    cmb: TComboBox;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDSimpleLabel9: TLMDSimpleLabel;
    cmb1: TComboBox;
    LMDSimpleLabel10: TLMDSimpleLabel;
    LMDAssistPage3: TLMDAssistPage;
    LMDSimplePanel4: TLMDSimplePanel;
    LMDLImage4: TLMDLImage;
    LMDSimpleLabel11: TLMDSimpleLabel;
    LMDSimpleLabel12: TLMDSimpleLabel;
    LMDSimpleLabel13: TLMDSimpleLabel;
    LMDSimpleLabel14: TLMDSimpleLabel;
    LMDSimpleLabel15: TLMDSimpleLabel;
    LMDFormStyler1: TLMDFormStyler;
    LMDAssistPage4: TLMDAssistPage;
    LMDSimpleLabel16: TLMDSimpleLabel;
    procedure page1Completed(Sender: TObject; var Cancel: Boolean);
    procedure LMDAssistPage1Completed(Sender: TObject;
      var Cancel: Boolean);
    procedure LMDAssistPage2Completed(Sender: TObject;
      var Cancel: Boolean);
    procedure assistCustomClick(Sender: TObject);
    procedure ck1Click(Sender: TObject);
    procedure assistCompleted(Sender: TObject; var Cancel: Boolean);
    procedure assistCancelClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmassist: Tfrmassist;

implementation

{$R *.DFM}

procedure Tfrmassist.page1Completed(Sender: TObject; var Cancel: Boolean);
begin
  {Specify here if we could enable the Next Button,
   in this set Cancel true, if not either CheckBox ck1 or ck2 is checked}
  Cancel:=not (ck1.Checked or ck2.Checked);
end;

procedure Tfrmassist.LMDAssistPage1Completed(Sender: TObject;
  var Cancel: Boolean);
begin
  {Specify here if we could enable the Next Button}
  Cancel:=(ed1.Text='') or (ed4.Text='') or (ed3.Text='');
end;

procedure Tfrmassist.LMDAssistPage2Completed(Sender: TObject;
  var Cancel: Boolean);
begin
  {Specify here if we could enable the Next Button}
  Cancel:=(cmb.ItemIndex=-1) or (cmb1.ItemIndex=-1);
end;

procedure Tfrmassist.assistCustomClick(Sender: TObject);
begin
  about.ExecuteEnh(self);
end;

procedure Tfrmassist.ck1Click(Sender: TObject);
begin
  {All times we should verify changes on the current page we have to
   call the Verify Next method. For the current page the OnCompleted
   event is generated where you should decide, if the next page could
   be displayed}
  assist.VerifyNext;
end;

procedure Tfrmassist.assistCompleted(Sender: TObject; var Cancel: Boolean);
begin
  showmessage('Now we could print the order - but it is only a demo...');
  Close;
end;


procedure Tfrmassist.assistCancelClick(Sender: TObject);
begin
  Close;
end;

end.
