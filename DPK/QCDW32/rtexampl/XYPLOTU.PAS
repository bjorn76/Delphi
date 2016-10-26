{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   XYPLOTU.PAS                                 *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Xyplotu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, StdCtrls, ExtCtrls;

type
  TXYPlotForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    Help2: TMenuItem;
    Exit1: TMenuItem;
    AboutRealTimeGraphicsTools1: TMenuItem;
    cmdStart: TButton;
    cmdExit: TButton;
    Timer1: TTimer;
    procedure FormDestroy(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure AboutRealTimeGraphicsTools1Click(Sender: TObject);
    procedure cmdStartClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  XYPlotForm: TXYPlotForm;

implementation
uses xyplotx;
{$R *.DFM}

procedure TXYPlotForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TXYPlotForm.Start1Click(Sender: TObject);
begin
     WM_CreateGraph(XYPlotForm.handle, hinstance);
end;

procedure TXYPlotForm.Exit1Click(Sender: TObject);
begin
     XYPlotForm.Close;
end;

procedure TXYPlotForm.AboutRealTimeGraphicsTools1Click(Sender: TObject);
begin
     MM_About(XYPlotForm.handle, hinstance);
end;

procedure TXYPlotForm.cmdStartClick(Sender: TObject);
begin
     XYPlotForm.Start1Click(Sender);
end;

procedure TXYPlotForm.cmdExitClick(Sender: TObject);
begin
     XYPlotForm.Close;
end;

procedure TXYPlotForm.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

end.
