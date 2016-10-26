program LMDMemoDemo;

uses
  Forms,
  memodemo in 'memodemo.pas' {lmdfrmMemoDemo},
  normal in 'normal.pas' {frmNormalMemo},
  letter in 'letter.pas' {frmLetterMemo},
  edit in 'edit.pas' {frmEditMemo};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TlmdfrmMemoDemo, lmdfrmMemoDemo);
  Application.Run;
end.
