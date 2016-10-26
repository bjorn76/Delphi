{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   DEM3P1GU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Dem3p1gu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Menus;

type
  TDemo3P1GForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Image1: TImage;
    procedure FormDestroy(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Demo3P1GForm: TDemo3P1GForm;

implementation
uses dem3p1gx;

{$R *.DFM}

procedure TDemo3P1GForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TDemo3P1GForm.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(Demo3P1GForm.handle, hinstance);
end;

procedure TDemo3P1GForm.About1Click(Sender: TObject);
begin
  MM_About(Demo3P1GForm.handle, hinstance);
end;

procedure TDemo3P1GForm.FormCreate(Sender: TObject);
begin
        Demo3P1GForm.WindowState := wsMaximized;
end;

end.
