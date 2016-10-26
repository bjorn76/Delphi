program Rtmdidem;

uses
  Forms,
  Rtmdiu1 in 'RTMDIU1.PAS' {Form1},
  Rtmdidex in 'RTMDIDEX.PAS',
  Rtmdiu1a in 'RTMDIU1A.PAS' {Form2},
  Rtmdiu1b in 'RTMDIU1B.PAS' {Form3};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
