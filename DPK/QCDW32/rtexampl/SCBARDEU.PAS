{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SCBARDEU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Scbardeu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, StdCtrls;

type
  TScrollBarForm = class(TForm)
    cmdStart: TButton;
    cmdExit: TButton;
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    Help1: TMenuItem;
    AboutRealTimeGraphicsTools1: TMenuItem;
    Exit1: TMenuItem;
    procedure Start1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure cmdStartClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure AboutRealTimeGraphicsTools1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScrollBarForm: TScrollBarForm;

implementation
uses scbardex;

{$R *.DFM}


procedure TScrollBarForm.Start1Click(Sender: TObject);
begin
     WM_CreateGraph(ScrollBarForm.Handle, hinstance );
end;

procedure TScrollBarForm.Exit1Click(Sender: TObject);
begin
     WM_DestroyGraph;
end;

procedure TScrollBarForm.cmdStartClick(Sender: TObject);
begin
     ScrollBarForm.Start1Click(Sender);
end;

procedure TScrollBarForm.cmdExitClick(Sender: TObject);
begin
     ScrollBarForm.Exit1Click(Sender);

end;

procedure TScrollBarForm.AboutRealTimeGraphicsTools1Click(Sender: TObject);
begin
     MM_About(ScrollBarForm.handle, hinstance);
end;

end.
