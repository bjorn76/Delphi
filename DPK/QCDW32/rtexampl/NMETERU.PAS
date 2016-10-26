{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   NMETERU.PAS                                 *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Nmeteru;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, StdCtrls, ExtCtrls;

type
  TnMeterForm = class(TForm)
    cmdExit: TButton;
    cmdStart: TButton;
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Exit1: TMenuItem;
    Timer1: TTimer;
    procedure Start1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure cmdStartClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  nMeterForm: TnMeterForm;

implementation
uses nmeterx;
{$R *.DFM}

procedure TnMeterForm.Start1Click(Sender: TObject);
begin

     WM_CreateGraph(NMeterForm.Handle, hinstance );

end;

procedure TnMeterForm.Exit1Click(Sender: TObject);
begin
     nMeterForm.Close;
end;

procedure TnMeterForm.cmdStartClick(Sender: TObject);
begin
     NMeterForm.Start1Click(Sender);
end;

procedure TnMeterForm.cmdExitClick(Sender: TObject);
begin
     NMeterForm.Close;
end;

procedure TnMeterForm.FormDestroy(Sender: TObject);
begin
     WM_DestroyGraph;
end;

procedure TnMeterForm.About1Click(Sender: TObject);
begin
     MM_About(nMeterForm.handle, hinstance);
end;

procedure TnMeterForm.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

end.
