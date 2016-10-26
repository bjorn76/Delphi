{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   FFTDEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit fftdemou;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus;

type
  TFFTDemoForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    procedure About1Click(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFTDemoForm: TFFTDemoForm;

implementation
uses fftdemox;
{$R *.DFM}

procedure TFFTDemoForm.About1Click(Sender: TObject);
begin
  MM_About(FFTDemoForm.handle, hinstance);
end;

procedure TFFTDemoForm.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(FFTDemoForm.handle, hinstance);
end;

procedure TFFTDemoForm.FormDestroy(Sender: TObject);
begin
  WM_DestroyGraph;
end;

end.
