unit Lmddete1;

interface

uses
  Windows,Classes, Graphics, Forms, Controls, Printers,
  Dialogs, Menus, Clipbrd, StdCtrls, lmdclass, lmdformA, messages, lmdctrl,
  lmdnonvA, lmdnonvS, lmdeditb, lmdmemoc, LMDMemo, lmddlgS, lmdcompo,
  lmdcctrl, LMDCustomIniComponent, LMDMRUList, LMDCustomComponent,
  LMDWndProcComponent, LMDFormStyler, LMDBaseEdit, LMDCustomMemo,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel;

type
  TfrmEdit = class(TForm)
    MainMenu1: TMainMenu;
    MemoPopUp: TPopupMenu;
    FontDialog1: TFontDialog;
    WordWrap1: TMenuItem;
    Left1: TMenuItem;
    Right1: TMenuItem;
    Center1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    Cut2: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    Edit1: TMenuItem;
    SelectAll1: TMenuItem;
    Character1: TMenuItem;
    Font1: TMenuItem;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Close1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N3: TMenuItem;
    Exit1: TMenuItem;
    SaveFileDialog: TSaveDialog;
    nc: TLMDFormStyler;
    LMDForm1: TLMDForm;
    mruchild: TLMDMRUList;
    LMDBackPanel1: TLMDBackPanel;
    LMDMemo1: TLMDMemo;
    Lined1: TMenuItem;
    ReOpen1: TMenuItem;
    Search1: TMenuItem;
    Search2: TMenuItem;
    FindDialog1: TFindDialog;
    procedure SelectAll(Sender: TObject);
    procedure SetFont(Sender: TObject);
    procedure SetWordWrap(Sender: TObject);
    procedure AlignClick(Sender: TObject);
    procedure CopyToClipboard(Sender: TObject);
    procedure CutToClipboard(Sender: TObject);
    procedure PasteFromClipboard(Sender: TObject);
    procedure Delete(Sender: TObject);
    procedure SetPopUpItems(Sender: TObject);
    procedure SetEditItems(Sender: TObject);
    procedure Open(const AFilename: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure New1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mruchildClick(Sender: TObject; const aValue: String;
      var Remove: Boolean);
    procedure Lined1Click(Sender: TObject);
    procedure LMDMemo1CursorPosChanged(Sender: TObject);
    procedure mruchildClearListClick(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure Search2Click(Sender: TObject);
    procedure ReplaceDialog1Find(Sender: TObject);
    procedure FindReplace1Click(Sender: TObject);
  private
    Filename: string;
    procedure UpdateMenus;
    procedure SetEditRect;

    {Das muﬂ leider hierein!!!}
    procedure CMTEXTChanged(var Message: TMessage); message CM_TEXTCHANGED;
  end;

implementation

{$R *.DFM}

uses lmddete0, SysUtils;

const
  BackupExt = '.BAK';
  SWarningText = 'Save Changes to ''%s''?';
  DefaultCaption = 'Untitled';
var
  Flag:Boolean;

procedure TfrmEdit.CMTEXTChanged(var Message: TMessage);
begin
  inherited;
  if self.Visible then nc.ForceNCPaint;
end;

procedure TfrmEdit.SelectAll(Sender: TObject);
begin
  LMDMemo1.SelectAll;
end;

procedure TfrmEdit.SetFont(Sender: TObject);
begin
  FontDialog1.Font := LMDMemo1.Font;
  if FontDialog1.Execute then
    LMDMemo1.Font := FontDialog1.Font;
  SetEditRect;
end;

procedure TfrmEdit.SetWordWrap(Sender: TObject);
begin
  with LMDMemo1 do
  begin
    WordWrap := not WordWrap;
    WordWrap1.Checked := WordWrap;
  end;
  SetEditRect;
end;

procedure TfrmEdit.AlignClick(Sender: TObject);
begin
  Left1.Checked := False;
  Right1.Checked := False;
  Center1.Checked := False;
  with Sender as TMenuItem do Checked := True;
  with LMDMemo1 do
    if Left1.Checked then
      Alignment := taLeftJustify
    else if Right1.Checked then
      Alignment := taRightJustify
    else if Center1.Checked then
      Alignment := taCenter;
end;

procedure TfrmEdit.CopyToClipboard(Sender: TObject);
begin
  LMDMemo1.CopyToClipboard;
end;

procedure TfrmEdit.CutToClipboard(Sender: TObject);
begin
  LMDMemo1.CutToClipboard;
end;

procedure TfrmEdit.PasteFromClipboard(Sender: TObject);
begin
  LMDMemo1.PasteFromClipboard;
end;

procedure TfrmEdit.Delete(Sender: TObject);
begin
  LMDMemo1.ClearSelection;
end;

procedure TfrmEdit.UpdateMenus;
var
  HasSelection: Boolean;
begin
  Paste1.Enabled := Clipboard.HasFormat(CF_TEXT);
  Paste2.Enabled := Clipboard.HasFormat(CF_TEXT);
  HasSelection := LMDMemo1.SelLength <> 0;
  Cut1.Enabled := HasSelection;
  Copy1.Enabled := HasSelection;
  Delete1.Enabled := HasSelection;
  Cut2.Enabled := HasSelection;
  Copy2.Enabled := HasSelection;
end;

procedure TfrmEdit.SetEditItems(Sender: TObject);
begin
  UpdateMenus;
end;

procedure TfrmEdit.SetPopUpItems(Sender: TObject);
begin
  UpdateMenus;
end;

procedure TfrmEdit.Open(const AFilename: string);
begin
  Filename := AFilename;
  LMDMemo1.Lines.LoadFromFile(FileName);
  LMDMemo1.SelStart := 0;
  Caption := ExtractFileName(FileName);
  LMDMemo1.Modified := False;
end;

procedure TfrmEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmEdit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  DialogValue: Integer;
  FName: string;
begin
  if LMDMemo1.Modified then
  begin
    FName := Caption;
    DialogValue := MessageDlg(Format(SWarningText, [FName]), mtConfirmation,
      [mbYes, mbNo, mbCancel], 0);
    case DialogValue of
      id_Yes: Save1Click(Self);
      id_Cancel: CanClose := False;
    end;
  end;
end;

procedure TfrmEdit.New1Click(Sender: TObject);
begin
  frmFrame.NewChild(Sender);
end;

procedure TfrmEdit.Open1Click(Sender: TObject);
begin
  frmFrame.OpenChild(Sender);
end;

procedure TfrmEdit.Exit1Click(Sender: TObject);
begin
  frmFrame.ExitClick(Sender);
end;

procedure TfrmEdit.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmEdit.SaveAs1Click(Sender: TObject);
begin
  SaveFileDialog.Filename := Filename;
  if SaveFileDialog.Execute then
  begin
    Filename := SaveFileDialog.Filename;
    Caption := ExtractFileName(Filename);
    Save1Click(Sender);
    if not Application.Terminated then frmframe.MRU.Add(FileName);
  end;
end;

procedure TfrmEdit.Save1Click(Sender: TObject);

  procedure CreateBackup(const Filename: string);
  var
    BackupFilename: string;
  begin
    BackupFilename := ChangeFileExt(Filename, BackupExt);
    DeleteFile(BackupFilename);
    RenameFile(Filename, BackupFilename);
  end;

begin
  if (Filename = '') then
    SaveAs1Click(Sender)
  else
  begin
    CreateBackup(Filename);
    LMDMemo1.Lines.SaveToFile(Filename);
    LMDMemo1.Modified := False;
  end;
end;

procedure TfrmEdit.SetEditRect;
var
  R: TRect;
begin
  R := LMDMemo1.ClientRect;
  InflateRect(R, -3, -2);
  SendMessage(LMDMemo1.Handle, EM_SETRECT, 0, Longint(@R));
end;

procedure TfrmEdit.FormCreate(Sender: TObject);
begin
  SetEditRect;
end;

procedure TfrmEdit.FormResize(Sender: TObject);
begin
  SetEditRect;
end;

procedure TfrmEdit.FormActivate(Sender: TObject);
begin
  Flag:=True;
  frmFrame.fc.FocusControl := self;
  frmFrame.fcs.FocusControl := self;
end;

procedure TfrmEdit.mruchildClick(Sender: TObject; const aValue: String;
  var Remove: Boolean);
begin
  frmframe.mru.CheckSharedFile(aValue);
end;

procedure TfrmEdit.Lined1Click(Sender: TObject);
begin
  with LMDMemo1 do
  begin
    Lined := not Lined;
    Lined1.Checked := Lined;
  end;
end;

procedure TfrmEdit.LMDMemo1CursorPosChanged(Sender: TObject);
begin
  frmFrame.LMDStatusBar1.Panels[0].Text := IntToStr (LMDMemo1.CurrentChar)+':'+IntToStr (Length(LMDMemo1.Text));
  frmFrame.LMDStatusBar1.Panels[1].Text := IntToStr (LMDMemo1.Row)+':'+IntToStr (LMDMemo1.Rows);
  frmFrame.LMDStatusBar1.Panels[2].Text := IntToStr (LMDMemo1.Column);
end;

procedure TfrmEdit.mruchildClearListClick(Sender: TObject);
begin
  frmframe.mru.CheckClearList(Sender);
end;

procedure TfrmEdit.FindDialog1Find(Sender: TObject);
var
  sd : TLMDSearchDirection;
  st : TLMDSearchStart;
begin
  if frDown in FindDialog1.Options then
    sd := sdDown
  else
    sd := sdUp;
  st := stCursor;
  LMDMemo1.Search (FindDialog1.FindText,st,frMatchCase in FindDialog1.Options,frWholeWord in FindDialog1.Options,sd);
  FindDialog1.CloseDialog;
end;

procedure TfrmEdit.Search2Click(Sender: TObject);
begin
  FindDialog1.Execute;
end;

procedure TfrmEdit.ReplaceDialog1Find(Sender: TObject);
var
  sd : TLMDSearchDirection;
  st : TLMDSearchStart;
  b : Boolean;
begin
  b := LMDMemo1.HideSelection;
  LMDMemo1.HideSelection := false;
  if frDown in FindDialog1.Options then
    sd := sdDown
  else
    sd := sdUp;
  st := stCursor;
{  LMDMemo1.SearchAndReplace (ReplaceDialog1.FindText, ReplaceDialog1.ReplaceText, st,frMatchCase in FindDialog1.Options,sd, true, false);
  ReplaceDialog1.CloseDialog;}
  LMDMemo1.HideSelection := b;
end;

procedure TfrmEdit.FindReplace1Click(Sender: TObject);
begin
//  ReplaceDialog1.Execute;
end;

end.

