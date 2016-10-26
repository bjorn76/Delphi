{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   FLODEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Flodemou;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Menus;

type
  TFloDemoForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Image1: TImage;
    procedure About1Click(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FloDemoForm: TFloDemoForm;

implementation
uses flodemox;
{$R *.DFM}

procedure TFloDemoForm.About1Click(Sender: TObject);
begin
  MM_About(FloDemoForm.handle, hinstance);
end;

procedure TFloDemoForm.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(FloDemoForm.handle, hinstance);
end;

procedure TFloDemoForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

end.
