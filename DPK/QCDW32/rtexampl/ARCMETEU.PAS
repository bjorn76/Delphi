{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ARCMETEU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Arcmeteu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Timer1: TTimer;
    Button1: TButton;
    procedure Start1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
 uses arcmetex;

{$R *.DFM}

procedure TForm1.Start1Click(Sender: TObject);
begin
   MM_CreateGraph(Form1.Handle, hinstance );
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  MM_About(Form1.handle, hinstance);
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Form1.Left := 140;
     Form1.Top:= 125;
     Form1.Height:= 450;
     Form1.Width:= 715;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
     WM_DestroyGraph;
     Form1.Close;
end;

end.
