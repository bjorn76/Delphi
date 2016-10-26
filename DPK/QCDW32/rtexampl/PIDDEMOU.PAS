{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   PIDDEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Piddemou;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Menus;

type
  TPIDForm = class(TForm)
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    Help1: TMenuItem;
    About1: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PIDForm: TPIDForm;

implementation
uses piddemox;

{$R *.DFM}

procedure TPIDForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TPIDForm.FormCreate(Sender: TObject);
begin
  WM_CreateGraph(PidForm.Handle, hinstance );

end;

procedure TPIDForm.Timer1Timer(Sender: TObject);
begin
   TimerRoutine;
end;

procedure TPIDForm.Exit1Click(Sender: TObject);
begin
     PidForm.Close;
end;

end.
