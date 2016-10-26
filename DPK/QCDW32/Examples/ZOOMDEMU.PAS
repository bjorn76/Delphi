{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   ZOOMDEMU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Zoomdemu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TZoomDemoForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ZoomDemoForm: TZoomDemoForm;

implementation
uses zoomdemx;
{$R *.DFM}

procedure TZoomDemoForm.FormCreate(Sender: TObject);
begin
  WM_CreateGraph(ZoomDemoForm.handle, hinstance);
end;

procedure TZoomDemoForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

end.
