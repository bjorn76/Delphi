unit Lmddedl0;

interface

uses
  SysUtils,Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdctrl, lmdstdcS, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel;

type
  Ttest1 = class(TForm)
    LMDSimpleLabel1: TLMDSimpleLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  test1: Ttest1;

implementation

{$R *.DFM}

end.
