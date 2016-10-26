{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   STACKDEU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Stackdeu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus, ExtCtrls;

type
  TStackDemoFrm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Exit1: TMenuItem;
    Timer1: TTimer;
    procedure Start1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StackDemoFrm: TStackDemoFrm;

implementation
uses stackdex;

{$R *.DFM}

procedure TStackDemoFrm.Start1Click(Sender: TObject);
begin
     WM_CreateGraph(StackDemoFrm.handle, hinstance);
end;

procedure TStackDemoFrm.Exit1Click(Sender: TObject);
begin
     StackDemoFrm.Close;
end;

procedure TStackDemoFrm.About1Click(Sender: TObject);
begin
     MM_About(StackDemoFrm.handle, hinstance);
end;

procedure TStackDemoFrm.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

end.
