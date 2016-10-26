{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   GRPBARDU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Grpbardu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Menus;

type
  TGrpBardForm = class(TForm)
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
  GrpBardForm: TGrpBardForm;

implementation
uses grpbardx;

{$R *.DFM}

procedure TGrpBardForm.About1Click(Sender: TObject);
begin
  MM_About(GrpBardForm.handle, hinstance);
end;

procedure TGrpBardForm.Start1Click(Sender: TObject);
begin
   MM_CreateGraph(GrpBardForm.handle, hinstance);
end;

procedure TGrpBardForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TGrpBardForm.FormCreate(Sender: TObject);
begin
     GrpBardForm.WindowState := wsMaximized;
end;

end.
