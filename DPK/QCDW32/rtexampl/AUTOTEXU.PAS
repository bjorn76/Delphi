{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   AUTOTEXU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Autotexu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    ExitButton: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses Autotexx;

{$R *.DFM}

procedure TForm1.FormDestroy(Sender: TObject);
begin
 WM_DestroyGraph;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  WM_CreateGraph(Form1.Handle, hinstance );
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

procedure TForm1.ExitButtonClick(Sender: TObject);
begin
     Form1.Close;
end;

end.
