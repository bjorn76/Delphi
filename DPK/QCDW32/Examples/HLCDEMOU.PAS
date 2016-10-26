{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   HLCDEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Hlcdemou;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Menus;

type
  THLCForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Image1: TImage;
    procedure About1Click(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HLCForm: THLCForm;

implementation
uses hlcdemox;
{$R *.DFM}

procedure THLCForm.About1Click(Sender: TObject);
begin
  MM_About(HLCForm.handle, hinstance);
end;

procedure THLCForm.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(HLCForm.handle, hinstance);
end;

procedure THLCForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure THLCForm.FormCreate(Sender: TObject);
begin
    HLCForm.WindowState := wsMaximized;
end;

end.
