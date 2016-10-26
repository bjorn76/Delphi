{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SCADAU.PAS                                  *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Scadau;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls;

type
  TScadaForm = class(TForm)
    MainMenu1: TMainMenu;
    Help1: TMenuItem;
    AboutRealTimeGraphicsTools1: TMenuItem;
    EXit1: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EXit1Click(Sender: TObject);
    procedure AboutRealTimeGraphicsTools1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScadaForm: TScadaForm;

implementation
uses scadax;
{$R *.DFM}

procedure TScadaForm.FormCreate(Sender: TObject);
begin
     ScadaForm.Left := 91;
     ScadaForm.Top := 106;
     ScadaForm.Height := 588;
     ScadaForm.Width := 779;

  WM_CreateGraph(ScadaForm.handle, hinstance);
end;

procedure TScadaForm.FormDestroy(Sender: TObject);
begin
     WM_DestroyGraph;
end;

procedure TScadaForm.EXit1Click(Sender: TObject);
begin
     ScadaForm.Close;
end;

procedure TScadaForm.AboutRealTimeGraphicsTools1Click(Sender: TObject);
begin
     MM_About(ScadaForm.handle, hinstance);
end;

procedure TScadaForm.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

end.
