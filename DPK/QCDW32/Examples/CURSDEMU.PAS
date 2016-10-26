{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   CURSDEMU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Cursdemu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TCursorForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CursorForm: TCursorForm;

implementation
uses cursdemx;
{$R *.DFM}

procedure TCursorForm.FormCreate(Sender: TObject);
begin
  WM_CreateGraph(CursorForm.handle, hinstance);
end;

procedure TCursorForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

end.
