{!
 *************************************************************
 *                                                           **
 *     Copyright (c) QUINN-CURTIS, INC. 1996                  *
 *                                                           **
 *************************************************************
 *                                                           **
 *   Filename :   BARDEMOU.PAS                                *
 *   Author   :   RC                                          *
 *   Revision :   2.5                                         *
 *   Date     :   March 15, 1996                              *
 *   Product  :   Delphi Charting Tools for Windows 16/32     *
 *                                                           **
 *************************************************************
!}
unit Bardemou;

interface

uses
  { Borland Units }
  SysUtils, WinProcs, WinTypes, classes, Messages, Graphics, Controls,
  Forms, Dialogs,
  { Charting Tools Units }
  qcwin, hook;

type
  TBarDemoForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  BarDemoForm: TBarDemoForm;

implementation
uses bardemox;
{$R *.DFM}


procedure TBarDemoForm.FormCreate(Sender: TObject);
VAR  wc: TWNDCLASS ;
     result: INTEGER;
begin

  WGCreatePage ('PAGE1',           {  page ID string}
        BarDemoForm.handle,                         {  handle to the parent window}
        hInstance,                         {  application instance handle }
        'Bar Graph',                   {  Window title string}
        @StartPage1,                   {  pointer to graph creation function}
        'PageMenu',
        {  Name of page window menu in resource file}
        C_LIGHTGRAY,                   {  window background color}
        MM_PROPORT,                    {  window sizing mode}
        0,                             {  window style - default}
        PAGE_CLIENT,
        {  window initial size and position option}
        0, 0, 0, 0);
end;

procedure TBarDemoForm.FormDestroy(Sender: TObject);
begin
   WGCleanup (TRUE);                {  clean up charting tools memory}
   PostQuitMessage (0);
end;

end.
