{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   MONKEYDU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Monkeydu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Menus, StdCtrls;

type
  TMonkeyForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Image1: TImage;
    Exit1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MonkeyForm: TMonkeyForm;

implementation
 uses monkeydx;
{$R *.DFM}

procedure TMonkeyForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TMonkeyForm.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(MonkeyForm.handle, hinstance);
end;

procedure TMonkeyForm.About1Click(Sender: TObject);
begin
  MM_About(MonkeyForm.handle, hinstance);
end;

procedure TMonkeyForm.Button1Click(Sender: TObject);
begin
     MonkeyForm.Start1Click(Sender);
end;

procedure TMonkeyForm.Exit1Click(Sender: TObject);
begin
     MonkeyForm.Close;
end;

procedure TMonkeyForm.Button2Click(Sender: TObject);
begin
     MonkeyForm.Close;
end;

procedure TMonkeyForm.FormCreate(Sender: TObject);
begin
     MonkeyForm.WindowState := WSMaximized;
end;

end.
