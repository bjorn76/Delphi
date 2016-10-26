{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ACQDEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ACQDEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}

unit Acqdemou;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Timer1: TTimer;
    Image1: TImage;
    procedure FormDestroy(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses acqdemox;
VAR formhandle, thinst: HWND;

{$R *.DFM}


procedure TForm1.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TForm1.Start1Click(Sender: TObject);
begin
    Form1.Left := 0;
    Form1.Top := 0;
    Form1.Height := Screen.Height;
    Form1.Width := Screen.Width;

    MM_CreateGraph(Form1.Handle, hinstance );
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  MM_About(Form1.handle, hinstance);
end;         

procedure TForm1.Timer1Timer(Sender: TObject);
var ncount: INTEGER;
begin
  ncount := TimerRoutine;
end;

end.
