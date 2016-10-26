unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  lmdctrl, lmddlgS, Menus, lmdclass, lmdnwgui, ShellApi, lmdcompo,
  LMDWndProcComponent, LMDTrayIcon, LMDCustomComponent,
  LMDContainerComponent, LMDBaseDialog, LMDAboutDlg;

type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    mnuInfo: TMenuItem;
    N1: TMenuItem;
    mnuQuit: TMenuItem;
    LMDAboutDlg1: TLMDAboutDlg;
    mnuVisitWeb: TMenuItem;
    mnuMailLMD: TMenuItem;
    N2: TMenuItem;
    LMDTrayIcon1: TLMDTrayIcon;
    procedure mnuInfoClick(Sender: TObject);
    procedure mnuQuitClick(Sender: TObject);
    procedure mnuVisitWebClick(Sender: TObject);
    procedure mnuMailLMDClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure JumpTo(const aAdress: String); // Go to Internet URL
    procedure MailTo(const aAdress: String); // Mail to recipent
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{******************************************************************************}
procedure TForm1.JumpTo(const aAdress: String);
var
  buffer: String;
begin
  buffer := 'http://' + aAdress;
  ShellExecute(Application.Handle, nil, PChar(buffer), nil, nil, SW_SHOWNORMAL);
end;

{******************************************************************************}
procedure TForm1.MailTo(const aAdress: String);
var
  buffer: String;
begin
  buffer := 'mailto://' + aAdress;
  ShellExecute(Application.Handle, nil, PChar(buffer), nil, nil, SW_SHOWNORMAL);
end;

{******************************************************************************}
procedure TForm1.mnuInfoClick(Sender: TObject);
begin
  LMDAboutDlg1.Execute;  // Show the info dialog...
end;

{******************************************************************************}
procedure TForm1.mnuQuitClick(Sender: TObject);
begin
  Close;                 // Quit the program...
end;

{******************************************************************************}
procedure TForm1.mnuVisitWebClick(Sender: TObject);
begin
  JumpTo('www.lmd.de');  // Here we start the Browser with
                         // http://www.lmd.de
end;

{******************************************************************************}
procedure TForm1.mnuMailLMDClick(Sender: TObject);
begin
  MailTo('info@lmd.de'); // Here we start the Mail program
                         // with mailto://info@lmd.de
end;

end.
