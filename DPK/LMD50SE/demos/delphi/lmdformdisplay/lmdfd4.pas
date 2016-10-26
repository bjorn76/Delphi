unit lmdfd4;

interface

uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  lmdctrl, Lmdled, StdCtrls, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDGraphicControl, LMDLEDCustomLabel, LMDLEDLabel;

type
  Tt3 = class(TForm)
    Button1: TButton;
    LMDLEDLabel1: TLMDLEDLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  t3: Tt3;

implementation

{$R *.DFM}

end.
