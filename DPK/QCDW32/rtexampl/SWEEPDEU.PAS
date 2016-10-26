{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   SWEEPDEU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Sweepdeu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus, ExtCtrls;

type
  TSweepForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    Help1: TMenuItem;
    Exit1: TMenuItem;
    AboutRTTools1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AboutRTTools1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SweepForm1: TSweepForm1;

implementation
uses sweepdex;

{$R *.DFM}

procedure TSweepForm1.Button1Click(Sender: TObject);
begin
     SweepForm1.Start1Click(Sender);
end;

procedure TSweepForm1.Start1Click(Sender: TObject);
begin
     WM_CreateGraph(SweepForm1.handle, hinstance);
end;

procedure TSweepForm1.Exit1Click(Sender: TObject);
begin
     SweepForm1.Close;
end;

procedure TSweepForm1.Button2Click(Sender: TObject);
begin
     SweepForm1.Exit1Click(Sender);
end;

procedure TSweepForm1.AboutRTTools1Click(Sender: TObject);
begin
     MM_About(SweepForm1.handle, hinstance);
end;

procedure TSweepForm1.Timer1Timer(Sender: TObject);
begin
  TimerRoutine;
end;

end.
