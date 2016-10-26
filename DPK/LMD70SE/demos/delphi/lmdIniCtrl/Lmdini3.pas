unit Lmdini3;

interface

uses
  Windows, ComCtrls,
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  lmdclass, lmdformA, 
  LMDWndProcComponent, LMDCustomFormFill, LMDFormFill, LMDControl,
  LMDBaseControl, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDSpeedButton, LMDCustomComponent;

type
  Tfrmini3 = class(TForm)
    LMDFormFill1: TLMDFormFill;
    LMDForm1: TLMDForm;
    LMDExplorerButton1: TLMDSpeedButton;
    procedure LMDExplorerButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmini3: Tfrmini3;

implementation

uses Lmdini2;

{$R *.DFM}

procedure Tfrmini3.LMDExplorerButton1Click(Sender: TObject);
begin
  Close;
end;

end.
