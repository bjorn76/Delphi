unit d_lmdxp0;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, lmdclass, lmdxpres,
  StdCtrls, LMDApplicationCtrl, LMDCustomComponent, lmdcont,
  LMDCustomListBox, LMDCustomImageListBox, LMDImageListBox, LMDFormDisplay,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel, LMDCustomParentPanel,
  LMDCustomGroupBox, LMDGroupBox, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDSimplePanel, LMDBaseController,
  LMDCustomContainer, LMDCustomImageList, LMDImageList;

type
  TLMDXPDemo = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    LMDGroupBox1: TLMDGroupBox;
    lbl: TLMDSimpleLabel;
    LMDGroupBox2: TLMDGroupBox;
    chkXP: TLMDCheckBox;
    chkOnly: TLMDCheckBox;
    fd: TLMDFormDisplay;
    LMDImageList1: TLMDImageList;
    LMDApplicationCtrl1: TLMDApplicationCtrl;
    LMDImageListBox1: TLMDImageListBox;
    procedure FormCreate(Sender: TObject);
    procedure chkXPClick(Sender: TObject);
    procedure chkOnlyClick(Sender: TObject);
    procedure LMDImageListBox1Select(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure BuildLabel;
  public
    { Public declarations }
  end;

var
  LMDXPDemo: TLMDXPDemo;

implementation
uses
  lmdsysin,
  d_lmdxp1,
  d_lmdxp2,
  d_lmdxp2a,
  d_lmdxp3,
  d_lmdxpstd,
  d_lmdxpedit,
  d_lmdxplist;
  
{$R *.DFM}

procedure TLMDXPDemo.BuildLabel;
var
  tmp:String;
begin
  try
    // Check for WindowsXP
    if LMDSIWindowsXP then
      tmp:='Windows XP'
    else
      begin
        tmp:='No Windows XP available, Theme support not possible';
        chkXP.Enabled:=False;
        chkOnly.Enabled:=False;
        exit;
      end;

    // Check whether Themes are enabled for system
    if LMDApplication.XPThemesSupported then
      tmp:=tmp+', Themes enabled'
    else
      tmp:=tmp+', Themes disabled'
  finally
    lbl.Caption:=tmp;
  end;
end;

procedure TLMDXPDemo.FormCreate(Sender: TObject);
begin
  BuildLabel;
  //LMDApplication.UseXPThemesLMDOnly:=True;
  chkXP.Checked:=LMDApplication.UseXPThemes;
  fd.AddFormClass(Tfrmxp1, True);
end;

procedure TLMDXPDemo.chkXPClick(Sender: TObject);
begin
  LMDApplication.UseXPThemes:=chkXP.Checked;
end;

procedure TLMDXPDemo.chkOnlyClick(Sender: TObject);
begin
  LMDApplication.UseXPThemesLMDOnly:=chkOnly.Checked;
end;

procedure TLMDXPDemo.LMDImageListBox1Select(Sender: TObject);
var
  tmp:TFormClass;
begin
  tmp:=nil;

  if LMDImageListBox1.ItemIndex=-1 then
    LMDImageListBox1.ItemIndex:=0;

  case LMDImageListBox1.ItemIndex of
    0: tmp:=Tfrmxp1;
    1: tmp:=Tfrmxp2;
    2: tmp:=Tfrmxp2a;
    3: tmp:=Tfrmxp3;
    4: tmp:=TfrmXPStd;
    5: tmp:=TfrmXPEdit;
    6: tmp:=TfrmXPList;
  end;

  if fd.ActiveForm.ClassType<>tmp then
    if tmp=nil then
      Application.Terminate
    else
      begin
        fd.Unload;
        fd.AddFormClass(tmp, True);
      end;
end;

procedure TLMDXPDemo.FormShow(Sender: TObject);
begin
  LMDImageListBox1Select(nil);
end;

end.
