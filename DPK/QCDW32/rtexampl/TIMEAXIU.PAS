{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   TIMEAXIU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Timeaxiu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, StdCtrls, ExtCtrls;

type
  TTimeAxisForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    Help1: TMenuItem;
    Exit1: TMenuItem;
    AboutRealTimeGraphicsTools1: TMenuItem;
    cmdExit: TButton;
    cmdStart: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Start1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure cmdStartClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure AboutRealTimeGraphicsTools1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TimeAxisForm: TTimeAxisForm;

implementation
uses timeaxix;

{$R *.DFM}


procedure TTimeAxisForm.Start1Click(Sender: TObject);
begin
     WM_CreateGraph(TimeAxisForm.handle, hinstance);
end;

procedure TTimeAxisForm.Exit1Click(Sender: TObject);
begin
  TimeAxisForm.Close;
end;

procedure TTimeAxisForm.cmdStartClick(Sender: TObject);
begin
     TimeAxisForm.Start1Click(Sender);
end;

procedure TTimeAxisForm.cmdExitClick(Sender: TObject);
begin
      TimeAxisForm.Close;
end;

procedure TTimeAxisForm.AboutRealTimeGraphicsTools1Click(Sender: TObject);
begin
     MM_About(TimeAxisForm.handle, hinstance);
end;

procedure TTimeAxisForm.FormDestroy(Sender: TObject);
begin
     TimeAxisForm.Timer1.Enabled := FALSE;
     TimeAxisForm.Timer2.Enabled := FALSE;
     WM_DestroyGraph;
end;

procedure TTimeAxisForm.Timer1Timer(Sender: TObject);
begin
  Timer1Routine;
end;

procedure TTimeAxisForm.Timer2Timer(Sender: TObject);
begin
  Timer2Routine;
end;

end.
