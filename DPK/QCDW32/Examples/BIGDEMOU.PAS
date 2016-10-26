{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   BIGDEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Bigdemou;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Image1: TImage;
    Quit1: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Start1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses bigdemox;
{$R *.DFM}

procedure TForm1.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  MM_About(Form1.handle, hinstance);
end;

procedure TForm1.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(Form1.handle, hinstance);
end;

end.
