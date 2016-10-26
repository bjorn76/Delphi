{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   PIEMETEU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Piemeteu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TPieMeterForm = class(TForm)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PieMeterForm: TPieMeterForm;

implementation
uses piemetex;
{$R *.DFM}

procedure TPieMeterForm.FormDestroy(Sender: TObject);
begin
 WM_DestroyGraph;
end;

procedure TPieMeterForm.FormCreate(Sender: TObject);
begin
  WM_CreateGraph(PieMeterForm.Handle, hinstance );
end;

end.
