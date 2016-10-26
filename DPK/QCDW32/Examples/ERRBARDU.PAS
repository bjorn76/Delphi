{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ERRBARDU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Errbardu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TErrBarForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ErrBarForm: TErrBarForm;

implementation
uses errbardx;

{$R *.DFM}

procedure TErrBarForm.FormCreate(Sender: TObject);
begin
  WM_CreateGraph(ErrBarForm.handle, hinstance);
end;

procedure TErrBarForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

end.
