{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   FRM1MDIU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Frm1mdiu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TChildForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChildForm1: TChildForm1;

implementation
uses MDIDEMOx;
{$R *.DFM}

procedure TChildForm1.FormCreate(Sender: TObject);
begin
  CreateMDIChild1(ChildForm1.handle, hinstance);
end;

procedure TChildForm1.FormResize(Sender: TObject);
begin
   ResizeMDIChild1(ChildForm1.Clientwidth,
                   ChildForm1.Clientheight);
                        
end;

end.
