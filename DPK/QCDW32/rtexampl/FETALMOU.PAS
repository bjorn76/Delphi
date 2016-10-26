{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   FETALMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Fetalmou;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls;

type
  TFMForm = class(TForm)
    MainMenu1: TMainMenu;
    Help1: TMenuItem;
    Exit1: TMenuItem;
    Timer1: TTimer;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMForm: TFMForm;

implementation
uses fetalmox;

{$R *.DFM}

procedure TFMForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TFMForm.FormCreate(Sender: TObject);
begin
  FMForm.Left := 50;
  FMForm.Top:= 60;
  FMForm.Width:= 900;
  FMForm.Height:= 680;
  WM_CreateGraph(FMForm.Handle, hinstance );
end;

procedure TFMForm.Exit1Click(Sender: TObject);
begin
     FMForm.Close;
end;

procedure TFMForm.Help1Click(Sender: TObject);
begin
     MM_About(FMForm.handle, hinstance);
end;

procedure TFMForm.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

end.
