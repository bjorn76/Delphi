{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   RTMDIU1B.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi R-T Graphics Tools for Windows 16/32 *
 *                                                           **
 *************************************************************
!}
unit Rtmdiu1b;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TForm3 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
uses RTMDIDEx;
{$R *.DFM}

procedure TForm3.FormCreate(Sender: TObject);
begin
  CreateMDIChild2(Form3.handle, hinstance);
end;

procedure TForm3.FormResize(Sender: TObject);
begin
  ResizeMDIChild2(Form3.Clientwidth,
                   Form3.Clientheight);
end;

end.
