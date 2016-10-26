{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   PIECHARU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Piecharu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls, StdCtrls;

type
  TPieChartForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Image1: TImage;
    cmdStart: TButton;
    cmdExit: TButton;
    Exit1: TMenuItem;
    procedure Start1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure cmdStartClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PieChartForm: TPieChartForm;

implementation
uses piecharx;
{$R *.DFM}

procedure TPieChartForm.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(PieChartForm.handle, hinstance);
end;

procedure TPieChartForm.About1Click(Sender: TObject);
begin
  MM_About(PieChartForm.handle, hinstance);
end;

procedure TPieChartForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TPieChartForm.Exit1Click(Sender: TObject);
begin
     PieChartForm.FormDestroy(Sender);
end;

procedure TPieChartForm.cmdStartClick(Sender: TObject);
begin
     PieChartForm.Start1Click(Sender);     
end;

procedure TPieChartForm.cmdExitClick(Sender: TObject);
begin
     PieChartForm.Close;
end;

end.
