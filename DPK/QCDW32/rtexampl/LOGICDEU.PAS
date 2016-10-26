{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   LOGICDEU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Logicdeu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Timer1: TTimer;
    procedure FormDestroy(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses logicdex;

{$R *.DFM}

procedure TForm1.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TForm1.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(Form1.Handle, hinstance );
end;

procedure TForm1.About1Click(Sender: TObject);
begin
 MM_About(Form1.Handle, hinstance );
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

end.
