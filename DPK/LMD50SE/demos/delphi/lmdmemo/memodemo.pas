unit memodemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, lmdclass, lmdformA, ComCtrls, lmdextcA, lmdcompo,
  LMDCustomComponent, LMDWndProcComponent, LMDFormStyler, LMDFormTabControl;

type
  TlmdfrmMemoDemo = class(TForm)
    MainMenu1: TMainMenu;
    Demo1: TMenuItem;
    Exit1: TMenuItem;
    Examples1: TMenuItem;
    Normal1: TMenuItem;
    Letter1: TMenuItem;
    Edit1: TMenuItem;
    LMDFormStyler1: TLMDFormStyler;
    ft: TLMDFormTabControl;
    procedure Normal1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  lmdfrmMemoDemo: TlmdfrmMemoDemo;

implementation

uses
   edit, letter, normal;

{$R *.DFM}

procedure TlmdfrmMemoDemo.Normal1Click(Sender: TObject);
begin
  ft.ActiveFormIndex:=TMenuItem(Sender).Tag;
  TMenuItem(Sender).RadioItem:=True;
end;

procedure TlmdfrmMemoDemo.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TlmdfrmMemoDemo.FormCreate(Sender: TObject);
begin
  ft.AddFormClass(TfrmNormalMemo,True);
  ft.AddFormClass(TfrmLetterMemo,false);
  ft.AddFormClass(TfrmEditMemo,false);
end;

procedure TlmdfrmMemoDemo.FormActivate(Sender: TObject);
begin
  ft.ActiveForm.SetFocus;
end;

end.
