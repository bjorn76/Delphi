{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   LINEMARU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Linemaru;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, StdCtrls, ExtCtrls;

type
  TLineMarkForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Exit1: TMenuItem;
    AboutChartingTools1: TMenuItem;
    cmdButton1: TButton;
    cmdButton2: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure AboutChartingTools1Click(Sender: TObject);
    procedure cmdButton1Click(Sender: TObject);
    procedure cmdButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Var
  LineMarkForm: TLineMarkForm;

implementation
uses linemarx;
{$R *.DFM}

procedure TLineMarkForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TLineMarkForm.Exit1Click(Sender: TObject);
begin
     LineMarkForm.Close;
end;

procedure TLineMarkForm.Start1Click(Sender: TObject);
begin
     WM_CreateGraph(LineMarkForm.handle, hinstance);
end;

procedure TLineMarkForm.AboutChartingTools1Click(Sender: TObject);
begin
     MM_Help(LineMarkForm.handle, hinstance);
end;

procedure TLineMarkForm.cmdButton1Click(Sender: TObject);
begin
     LineMarkForm.Start1Click(Sender);
end;

procedure TLineMarkForm.cmdButton2Click(Sender: TObject);
begin
     LineMarkForm.Close;
end;


procedure TLineMarkForm.FormCreate(Sender: TObject);
begin
        LineMarkForm.WindowState := wsMaximized;
end;

end.
