unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DropSource, StdCtrls, Menus;

type
  TDummy = class (TControl)
    public
      property Caption;
      property OnMouseDown; //TMouseEvent read FOnMouseDown write FOnMouseDown;
      property OnMouseMove; //TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
  end;


  TForm1 = class(TForm)
    DropTextSource1: TDropTextSource;
    Label1: TLabel;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    AddLabel1: TMenuItem;
    procedure dsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddLabel1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    DragPoint : TPoint;
    FNbrOfAddedLabels : integer;  //For label naming purpose
    procedure AssignEvents;
    procedure createLabel(Caption_ : string);
    procedure LoadFromfile;
    procedure SaveToFile;
    function GetInifilename() : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation
uses
  inifiles;
{$R *.DFM}

procedure TForm1.dsMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  //Start drag after moviing 10 pixels
  if (DragPoint.X = -1) or ((Shift <> [ssLeft]) and (Shift <> [ssRight])) or
     ((abs(DragPoint.X - X) <10) and (abs(DragPoint.Y - Y) <10)) then exit;
  if Sender is TControl then
  begin
    DropTextSource1.Text :=TDummy(Sender).Caption;
  end else
  begin
    exit;
  end;
    //Start the dragdrop...
  //Note: DropFileSource1.DragTypes = [dtCopy]
  DropTextSource1.execute;
end;

procedure TForm1.dsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DragPoint := Point(X,Y);
  if Button = mbright then
  begin
    if sender is TLabel then
      TLabel(Sender).Caption :=
        InputBox('Update','Enter a new value:',TLabel(Sender).Caption);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);

begin
  FNbrOfAddedLabels := 1;
  Caption := Application.Title;
  AssignEvents();

  LoadFromfile;
end;

procedure TForm1.AssignEvents();
var
  i : integer;
  MouseDown  : TMouseEvent;
  MouseMove : TMouseMoveEvent;
begin
  MouseDown := dsMouseDown;
  MouseMove := dsMouseMove;
  for i := 0 to ControlCount -1 do
  begin
    if Controls[i] is TControl then
    begin
      TDummy(Controls[i]).OnMouseDown := MouseDown;
      TDummy(Controls[i]).OnMouseMove := MouseMove;
    end;
  end;
end;


procedure TForm1.AddLabel1Click(Sender: TObject);

begin
  CreateLabel('null');
end;

procedure TForm1.createLabel(Caption_ : string);
var
  O : TLabel;
const
  constOffset = 16;
begin
  Inc(FNbrOfAddedLabels);
  O := TLabel.Create(Self);
  O.Parent := self;
  O.Name := 'Label' + IntToStr(FNbrOfAddedLabels);
  O.Left := Label1.Left;
  O.Top := Label1.Top + constOffset * (FNbrOfAddedLabels -1);
  Height := Height + constOffset;
  O.Visible := True;
  O.Caption := Caption_;
  AssignEvents();
end;

procedure TForm1.LoadFromfile();
var
 f : TIniFile;
 i : integer;
 lst : TStrings;
 s : string;
begin
  lst := nil;
  f := nil;
  try
    lst := TStringList.Create;
    f := TIniFile.Create(GetInifilename);
    f.ReadSection('Data',lst);
    for i := 0 to lst.Count - 1 do
    begin
      s := f.ReadString('Data',lst[i],'null');
      if lst[i] = 'Label1' then
        Label1.Caption := s
      else
        createLabel(s);
    end;
  finally
    f.Free;
    lst.Free;
  end;
end;

function TForm1.GetInifilename() : string;
begin
  Result := ChangeFileExt(paramstr(0),'.ini');
end;

procedure TForm1.SaveToFile();
var
 f : TIniFile;
 i : integer;
begin
  f :=nil;
  try
    f := TIniFile.Create(GetInifilename);
    for i := 0 to ControlCount -1 do
    begin
      if Controls[i] is TLabel then
      begin
        f.WriteString('Data',TLabel(Controls[i]).Name,TLabel(Controls[i]).Caption);
      end;
    end;
  finally
    f.Free;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  SaveToFile;
end;

end.
