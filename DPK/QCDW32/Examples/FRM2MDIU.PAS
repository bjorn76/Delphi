{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   FRM2MDIU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Frm2mdiu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TChildForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChildForm2: TChildForm2;

implementation
uses MDIDEMOx;
{$R *.DFM}

procedure TChildForm2.FormCreate(Sender: TObject);
begin
  CreateMDIChild2(ChildForm2.handle, hinstance);
end;

procedure TChildForm2.FormResize(Sender: TObject);
begin
  ResizeMDIChild2(ChildForm2.Clientwidth,
                   ChildForm2.Clientheight);
end;

end.
