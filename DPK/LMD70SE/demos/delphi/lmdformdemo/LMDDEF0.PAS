{
 Demo-Program for TLMDForm
 ------------------------------


 © 95 - 97 by LMD Innovative
}


unit Lmddef0;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, lmdclass, lmdformA,
  LMDIniCtrl, LMDFormStyler, LMDCustomComponent,
  LMDWndProcComponent, LMDCustomScrollBox, LMDListBox, LMDDrawEdge,
  LMDControl, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel;

type
  Tfrmlmddemo = class(TForm)
    lb: TLMDListBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDDrawEdge2: TLMDDrawEdge;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDFormStyler1: TLMDFormStyler;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDIniCtrl1: TLMDIniCtrl;
    fc: TLMDForm;
    LMDDrawEdge3: TLMDDrawEdge;
    procedure LMDForm1TimeChange(Sender: TObject);
    procedure LMDForm1FMDragDrop(Sender: TObject; fcount, x, y: Integer;
      FileList: TStrings);
    procedure LMDForm1FontChange(Sender: TObject);
    procedure LMDForm1DisplayChange(Sender: TObject; xsize, ysize,
      flag: Word);
    procedure LMDForm1DevModeChange(Sender: TObject;
      const Section: String);
    procedure LMDForm1SysColorChange(Sender: TObject);
    procedure fcAPMSuspendRequest(Sender: TObject;
      var Cancel: Boolean);
    procedure fcAPMResume(Sender: TObject);
    procedure LMDForm1IniChange(Sender: TObject; const Section: String);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmlmddemo: Tfrmlmddemo;

implementation

{$R *.DFM}

procedure Tfrmlmddemo.LMDForm1TimeChange(Sender: TObject);
begin
  lb.Items.Add('You changed system time..');
end;

procedure Tfrmlmddemo.LMDForm1FMDragDrop(Sender: TObject; fcount, x, y: Integer;
  FileList: TStrings);
begin
  lb.Items:=FileList;
end;

procedure Tfrmlmddemo.LMDForm1FontChange(Sender: TObject);
begin
  lb.Items.Add('You changed fonts..');
end;

procedure Tfrmlmddemo.LMDForm1DisplayChange(Sender: TObject; xsize, ysize,
  flag: Word);
begin
  {this event will only fired in Delphi2-programs}
  lb.Items.Add(Format('Changing of screen resolution or color depth. New Values:'#13''+
                      'Width: %d, Height: %d, Color Depth: %d bit', [xsize, ySize, flag]));
end;

procedure Tfrmlmddemo.LMDForm1DevModeChange(Sender: TObject;
  const Section: String);
begin
  lb.Items.Add('A device was changed.. Section: '+section);
end;

procedure Tfrmlmddemo.LMDForm1SysColorChange(Sender: TObject);
begin
 lb.Items.Add('You changed system colors..');
end;

procedure Tfrmlmddemo.fcAPMSuspendRequest(Sender: TObject;
  var Cancel: Boolean);
begin
  lb.Items.Add('System will go to APM-mode..');
end;

procedure Tfrmlmddemo.fcAPMResume(Sender: TObject);
begin
  lb.items.Add('System resumes to Normal-Mode from APM-mode..');
end;

procedure Tfrmlmddemo.LMDForm1IniChange(Sender: TObject; const Section: String);
begin
  lb.items.Add('Ini-File was changed: '+section);
end;

end.
