{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   DEM1P3GU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Dem1p3gu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Menus;

type
  TDemo1P3GForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Image1: TImage;
    Exit1: TMenuItem;
    procedure About1Click(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Demo1P3GForm: TDemo1P3GForm;

implementation
uses dem1p3gx;
{$R *.DFM}

procedure TDemo1P3GForm.About1Click(Sender: TObject);
begin
  MM_About(Demo1P3GForm.handle, hinstance);
end;

procedure TDemo1P3GForm.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(Demo1P3GForm.handle, hinstance);
end;

procedure TDemo1P3GForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TDemo1P3GForm.Exit1Click(Sender: TObject);
begin
     Demo1P3GForm.Close;
end;

procedure TDemo1P3GForm.FormCreate(Sender: TObject);
begin
        Demo1P3GForm.WindowState := wsMaximized;
end;

end.
