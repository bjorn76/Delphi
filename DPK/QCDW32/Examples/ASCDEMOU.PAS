{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ASCDEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Ascdemou;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus, ExtCtrls;

type
  TForm1 = class(TForm)
    Button2: TButton;
    MainMenu1: TMainMenu;
    StartItem: TMenuItem;
    ExitItem: TMenuItem;
    Image1: TImage;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure StartItemClick(Sender: TObject);
    procedure ExitItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses ascdemox;
{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
     if (Sender = Button1) then
        Form1.StartItemClick(Sender)
     else
        Form1.ExitItemClick(Sender);
End;


procedure TForm1.StartItemClick(Sender: TObject);
begin
     WM_CreateGraph(Form1.handle, hinstance);
end;

procedure TForm1.ExitItemClick(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     WM_DestroyGraph;
end;

end.
