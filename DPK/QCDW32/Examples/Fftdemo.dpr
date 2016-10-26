program Fftdemo;

uses
  Forms,
  Fftdemou in 'FFTDEMOU.PAS' {FFTDemoForm},
  Fftdemox in 'FFTDEMOX.PAS';

{$R *.RES}

begin
  Application.CreateForm(TFFTDemoForm, FFTDemoForm);
  Application.Run;
end.
