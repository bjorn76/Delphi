{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   RTSWITCU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Rtswitcu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls;

type
  TRTSwitchForm = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    Help1: TMenuItem;
    Exit1: TMenuItem;
    About1: TMenuItem;
    Timer1: TTimer;
    procedure FormDestroy(Sender: TObject);
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
  RTSwitchForm: TRTSwitchForm;

implementation

uses rtswitcx;
VAR formhandle, thinst: HWND;

{$R *.DFM}


procedure TRTSwitchForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TRTSwitchForm.Start1Click(Sender: TObject);
begin
     WM_CreateGraph(RTSwitchForm.Handle, hinstance );
end;

procedure TRTSwitchForm.Exit1Click(Sender: TObject);
begin
     RTSwitchForm.Close;
end;

procedure TRTSwitchForm.About1Click(Sender: TObject);
begin
     MM_About(RTSwitchForm.handle, hinstance);
end;

procedure TRTSwitchForm.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

end.
