unit lmdctg4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  lmdcont, lmdclass, LMDCustomComponent, LMDWaveList,
  LMDStringList, LMDImageList, LMDBaseController, LMDCustomContainer,
  LMDCustomImageList, LMDBitmapList;

type
  Tdata = class(TDataModule)
    bml: TLMDBitmapList;
    iml: TLMDImageList;
    sll: TLMDStringList;
    wvl: TLMDWaveList;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  data: Tdata;

implementation

{$R *.DFM}

end.
