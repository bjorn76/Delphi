unit u2lines;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Tfrm2lines = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BtnOK: TButton;
    BtnCancel: TButton;
    procedure BtnOKClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Pubic declarations }

  end;

var
  frm2lines: Tfrm2lines;

implementation

{$R *.dfm}

procedure Tfrm2lines.BtnOKClick(Sender: TObject);
begin
  frm2lines.ModalResult := mrOK;
  hide;
end;

procedure Tfrm2lines.BtnCancelClick(Sender: TObject);
begin
  frm2lines.ModalResult := mrCancel;
  hide;
end;



end.
