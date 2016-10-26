{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   RTMDIU1A.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Rtmdiu1a;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses RTMDIdex;
{$R *.DFM}

procedure TForm2.FormCreate(Sender: TObject);
begin
  CreateMDIChild1(Form2.handle, hinstance);
end;

procedure TForm2.FormResize(Sender: TObject);
begin
   ResizeMDIChild1(Form2.Clientwidth,
                   Form2.Clientheight);

end;

end.
