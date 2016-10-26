{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   AXSCALEU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Axscaleu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls;

type
  TAxScaleForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    Help1: TMenuItem;
    Image1: TImage;
    AboutChartText1: TMenuItem;
    procedure Start1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AboutChartText1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AxScaleForm: TAxScaleForm;

implementation
uses axscalex;
{$R *.DFM}

procedure TAxScaleForm.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(AxScaleForm.handle, hinstance);
end;

procedure TAxScaleForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;


procedure TAxScaleForm.AboutChartText1Click(Sender: TObject);
begin
     MM_Help(AxScaleForm.handle, hinstance);
end;

end.
