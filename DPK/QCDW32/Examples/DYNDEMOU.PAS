{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   DYNDEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Dyndemou;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Menus;

type
  TDynDemoForm = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    About1: TMenuItem;
    Timer1: TTimer;
    Image2: TImage;
    procedure FormDestroy(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DynDemoForm: TDynDemoForm;

implementation
uses dyndemox;

{$R *.DFM}

procedure TDynDemoForm.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := FALSE;
  WM_DestroyGraph;
end;

procedure TDynDemoForm.About1Click(Sender: TObject);
begin
  MM_About(DynDemoForm.handle, hinstance);
end;

procedure TDynDemoForm.Start1Click(Sender: TObject);
begin
  MM_CreateGraph(DynDemoForm.handle, hinstance);
end;

procedure TDynDemoForm.Timer1Timer(Sender: TObject);
begin
   TimerRoutine;
end;

end.
