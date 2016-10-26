{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   HISTDEMU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Histdemu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls;

type
  THistdemForm = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    Help1: TMenuItem;
    Exit1: TMenuItem;
    AboutRealTimeGraphicsTools1: TMenuItem;
    Timer1: TTimer;
    procedure FormDestroy(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AboutRealTimeGraphicsTools1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HistdemForm: THistdemForm;

implementation
uses histdemx;

{$R *.DFM}

procedure THistdemForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure THistdemForm.Start1Click(Sender: TObject);
begin
     
     WM_CreateGraph(HistdemForm.Handle, hinstance );
end;

procedure THistdemForm.Exit1Click(Sender: TObject);
begin
     HistDemForm.Close;
end;

procedure THistdemForm.FormCreate(Sender: TObject);
begin
     HistDemForm.WindowState := wsMaximized;
end;

procedure THistdemForm.AboutRealTimeGraphicsTools1Click(Sender: TObject);
begin
     MM_About(HistdemForm.handle, hinstance);
end;

procedure THistdemForm.Timer1Timer(Sender: TObject);
begin
   TimerRoutine;
end;

end.
