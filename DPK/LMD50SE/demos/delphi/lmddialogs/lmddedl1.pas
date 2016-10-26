unit Lmddedl1;

interface

uses
  SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdctrl, lmdstdcS, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel;

type
  Ttest2 = class(TForm)
    LMDSimpleLabel1: TLMDSimpleLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  test2: Ttest2;

implementation

{$R *.DFM}

end.
