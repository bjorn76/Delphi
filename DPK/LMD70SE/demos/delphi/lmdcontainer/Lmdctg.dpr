program Lmdctg;

uses
  Forms,
  Lmdctg0 in 'LMDCTG0.PAS' {Cont0},
  Lmdctg1 in 'LMDCTG1.PAS' {Cont1},
  Lmdctg3 in 'LMDCTG3.PAS' {Cont3},
  Lmdctg2 in 'LMDCTG2.PAS' {Cont2},
  lmdctg4 in 'lmdctg4.pas' {data: TDataModule};

{$R *.RES}

begin
  Application.Title := 'LMD Container Controls';
  Application.CreateForm(TCont0, Cont0);
  Application.CreateForm(TData, Data);
  Application.Run;
end.
