{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   EKGU.PAS                                    *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Ekgu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  oldw, oldh: INTEGER;
implementation
uses ekgx;
VAR formhandle, thinst: HWND;

{$R *.DFM}


procedure TForm1.FormCreate(Sender: TObject);
begin
  WM_CreateGraph(Form1.Handle, hinstance );
  oldw := width;
  oldh  := height;
  end;

procedure TForm1.FormResize(Sender: TObject);
begin
if (oldw <> width) OR (oldh <> height) THEN
   WM_ResizeGraph (width, height );
 oldw := width;
 oldh  := height;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
 TimerRoutine;
end;

end.
