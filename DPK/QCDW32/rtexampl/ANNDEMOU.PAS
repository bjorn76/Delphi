{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ANNDEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Anndemou;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TAnnDemoForm = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AnnDemoForm: TAnnDemoForm;

implementation

uses anndemox;
VAR formhandle, thinst: HWND;

{$R *.DFM}


procedure TAnnDemoForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TAnnDemoForm.Button1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  WM_CreateGraph(AnnDemoForm.Handle, hinstance );

end;

procedure TAnnDemoForm.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

procedure TAnnDemoForm.Button2Click(Sender: TObject);
begin
     AnnDemoForm.Close;
end;

end.
