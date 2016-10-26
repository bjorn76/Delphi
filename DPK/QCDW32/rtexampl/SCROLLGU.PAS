{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SCROLLGU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Scrollgu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls;

type
  TScrollG1Form = class(TForm)
    Timer1: TTimer;
    procedure FormDestroy(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScrollG1Form: TScrollG1Form;

implementation
uses scrollgx;

{$R *.DFM}

procedure TScrollG1Form.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TScrollG1Form.About1Click(Sender: TObject);
begin
  MM_About(ScrollG1Form.handle, hinstance);
end;

procedure TScrollG1Form.FormCreate(Sender: TObject);
begin
     MM_CreateGraph(ScrollG1Form.handle, hinstance);
end;

procedure TScrollG1Form.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

end.
