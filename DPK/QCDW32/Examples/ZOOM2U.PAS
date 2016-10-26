{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ZOOM2U.PAS                                  *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Zoom2u;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TZoomDemo2Form = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ZoomDemo2Form: TZoomDemo2Form;

implementation
uses zoom2x;
{$R *.DFM}

procedure TZoomDemo2Form.FormCreate(Sender: TObject);
begin
  WM_CreateGraph(ZoomDemo2Form.handle, hinstance);
end;


procedure TZoomDemo2Form.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

end.
