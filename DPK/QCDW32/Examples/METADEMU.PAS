{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   METADEMU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Metademu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TMetaDemoForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MetaDemoForm: TMetaDemoForm;

implementation
uses metademx;
{$R *.DFM}

procedure TMetaDemoForm.FormCreate(Sender: TObject);
begin
  WM_CreateGraph(MetaDemoForm.handle, hinstance);
end;

procedure TMetaDemoForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

procedure TMetaDemoForm.FormPaint(Sender: TObject);
begin
  WM_PaintGraph(MetaDemoForm.handle, hinstance);
end;

procedure TMetaDemoForm.FormResize(Sender: TObject);
begin
  MetaDemoForm.Refresh;
end;

end.
