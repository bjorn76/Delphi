program Mdidemo;

uses
  Forms,
  Mdidemou in 'MDIDEMOU.PAS' {MDIForm1},
  Mdidemox in 'MDIDEMOX.PAS',
  Frm1mdiu in 'FRM1MDIU.PAS' {ChildForm1},
  Frm2mdiu in 'FRM2MDIU.PAS' {ChildForm2};

{$R *.RES}

begin
  Application.CreateForm(TMDIForm1, MDIForm1);
  Application.CreateForm(TChildForm1, ChildForm1);
  Application.CreateForm(TChildForm2, ChildForm2);
  Application.Run;
end.
