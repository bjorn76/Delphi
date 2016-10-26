unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, LMDCustomComponent, LMDSysInfo,
  LMDControl, LMDBaseControl, LMDBaseGraphicControl, LMDGraphicControl,
  LMDBaseMeter, LMDCustomProgress, LMDProgress, LMDCustomControl,
  LMDCustomPanel, LMDButtonControl, LMDCustomCheckBox, LMDCheckBox,
  LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
  LMDCustomExtSpinEdit, LMDSpinEdit;

type
  TForm1 = class(TForm)
    LMDSysInfo1: TLMDSysInfo;
    StatusBar1: TStatusBar;
    TimerLblupdate: TTimer;
    Label1: TLabel;
    TimerLog: TTimer;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    lblMemoryLoaded: TLabel;
    lblMemPageFree: TLabel;
    lblMemPageTotal: TLabel;
    lblMemPagePercentUsed: TLabel;
    lblMemPageUsed: TLabel;
    pbMemPagePercentUsed: TLMDProgress;
    pbMemPhysPercentUsed: TLMDProgress;
    lblMemPhysFree: TLabel;
    lblMemPhysTotal: TLabel;
    lblMemPhysUsed: TLabel;
    lblMemPhysPercentUsed: TLabel;
    lblMemVirtFree: TLabel;
    lblMemVirtTotal: TLabel;
    lblMemVirtExtended: TLabel;
    BtnUpdateSysinfo: TButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    cbAutoUpdateSysInfo: TLMDCheckBox;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    cbUseMB: TCheckBox;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    TabSheet2: TTabSheet;
    MemoMemPageLog: TMemo;
    Panel3: TPanel;
    LMDSpinEdit1: TLMDSpinEdit;
    btnManualLog: TButton;
    cbLogMempage: TLMDCheckBox;
    TabSheet3: TTabSheet;
    Label2: TLabel;
    lblIndex: TLabel;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
    btnGetMem2: TButton;
    Button3: TButton;
    TabSheet5: TTabSheet;
    Memo1: TMemo;
    Panel2: TPanel;
    lblHeader: TCheckBox;
    btnGetHeapStatus: TButton;
    btnClearLog: TButton;
      procedure btnGetHeapStatusClick(Sender: TObject);
    procedure lblHeaderClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BtnUpdateSysinfoClick(Sender: TObject);
    procedure TimerLblupdateTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerLogTimer(Sender: TObject);
    procedure LMDSpinEdit1Change(Sender: TObject);
    procedure btnGetMem2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 

var
  Form1: TForm1;

implementation

uses Math;
var
  Addheader : boolean = True;

  Parray : array [0..100] of Pointer;
  PointerArrayIndex : integer = -1;
  AllocSize : integer = 100000000;

  MemParray2 : array [0..100] of Pointer;
  AllocSizeArray2 : array [0..100] of integer;
  ArrayIndex2 : integer = -1;
{$R *.dfm}


procedure TForm1.btnGetHeapStatusClick(Sender: TObject);
var hstatus : THeapStatus;
    spacechars : string;

  function StrFixedStr(inStr : string) : string;
  const outlength : integer = 10;
  var strlength,i : integer;
    outstr : string;
  begin
    strlength := length(Instr);
    for i:=outlength - strlength downto 0 do
    begin
      outstr := outstr + ' ';
    end;
    outstr := Outstr + Instr;
    Result := Outstr;

  end;

  function IntToFixedStr(inint:integer) : string ;
  var Instr : string;
  begin
      Instr := IntToStr(inint);
      Result := StrFixedStr(Instr);
  end;


begin
  spacechars := ', ';
  hstatus := GetHeapStatus;


  if (addheader) then
  begin
    Memo1.Lines.Add( StrFixedStr('TotAddrSpace') + spacechars +
                     StrFixedStr('TotUncommit') + spacechars +
                     StrFixedStr('TotCommit') + spacechars +
                     StrFixedStr('TotAlloc') + spacechars +
                     StrFixedStr('TotFree')+   spacechars +
                     StrFixedStr('FreeSmall') + spacechars +
                     StrFixedStr('FreeBig') +   spacechars +
                     StrFixedStr('Unused') +   spacechars +
                     StrFixedStr('Overhead') +  spacechars +
                     StrFixedStr('HeapErrCode'));
  end;

  spacechars := ', ';

  Memo1.Lines.Add( IntToFixedStr(hstatus.TotalAddrSpace) + spacechars +
    IntToFixedStr(hstatus.TotalUncommitted) + spacechars +
    IntToFixedStr(hstatus.TotalCommitted) + spacechars +
    IntToFixedStr(hstatus.TotalAllocated) + spacechars +
    IntToFixedStr(hstatus.TotalFree) + spacechars +
    IntToFixedStr(hstatus.FreeSmall) + spacechars +
    IntToFixedStr(hstatus.FreeBig) + spacechars +
    IntToFixedStr(hstatus.Unused) + spacechars +
    IntToFixedStr(hstatus.Overhead) + spacechars +
    IntToFixedStr(hstatus.HeapErrorCode));

end;

procedure TForm1.lblHeaderClick(Sender: TObject);
begin
  Addheader := lblHeader.Checked;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

  inc(PointerArrayIndex);
  lblIndex.Caption := IntToStr(pointerarrayindex);
  try
    GetMem(Parray[PointerArrayIndex],AllocSize);
  except  // likly EOutOfMemory
    dec(PointerArrayIndex);
    lblIndex.Caption := IntToStr(pointerarrayindex);
    raise;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i,j : integer;
begin
  if PointerArrayIndex = -1 then exit;

  j := PointerArrayIndex;

  for i := 0 to j do
  begin
    FreeMem(Parray[PointerArrayIndex],AllocSize);
    dec(PointerArrayIndex);
    lblIndex.Caption := IntToStr(pointerarrayindex);
  end;
end;

procedure TForm1.BtnUpdateSysinfoClick(Sender: TObject);
var
  MemPagePercentUsed : integer;
  MemPhysPercentUsed : integer;
  MemPageFree_I,MemPageTotal_I  : integer;
  MemPhysFree_I, MemPhysTotal_I : integer;

begin

   //
   with LMDSysInfo1 do
   begin
       lblMemoryLoaded.Caption := MemoryLoaded;

       //Mempage
       MemPageFree_I := MemPageFree;
       MemPageTotal_I := MemPageTotal;
       if cbUseMB.Checked then
       begin
         MemPageFree_I := MemPageFree_I div 1024;
         MemPageTotal_I := MemPageTotal_I div 1024;
       end;
       lblMemPageFree.Caption :=  IntToStr(MemPageFree_I);
       lblMemPageTotal.Caption := IntToStr(MemPageTotal_I);
       lblMemPageUsed.Caption := IntToStr(MemPageTotal_I - MemPageFree_I);

       // Mempage Per cent used
       MemPagePercentUsed := Trunc((MemPageTotal - MemPageFree) / MemPageTotal * 100);
       pbMemPagePercentUsed.UserValue := MemPagePercentUsed;
       lblMemPagePercentUsed.Caption :=IntToStr(MemPagePercentUsed) + '%';

       //MemPhys
       MemPhysFree_I := MemPhysFree;
       MemPhysTotal_I := MemPhysTotal;
       if cbUseMB.Checked then
       begin
         MemPhysFree_I := MemPhysFree_I div 1024;
         MemPhysTotal_I := MemPhysTotal_I div 1024;
       end;
       lblMemPhysFree.Caption := IntToStr(MemPhysFree_I);
       lblMemPhysTotal.Caption := IntToStr(MemPhysTotal_I);
       lblMemPhysUsed.Caption := IntToStr(MemPhysTotal_I - MemPhysFree_I);

       //MemPhys per cent used
       MemPhysPercentUsed := Trunc((MemPhysTotal - MemPhysFree) / MemPhysTotal * 100);
       pbMemPhysPercentUsed.UserValue :=  MemPhysPercentUsed;
       lblMemPhysPercentUsed.Caption := IntToStr(MemPhysPercentUsed) + '%';

       //MemVirt
       lblMemVirtExtended.Caption := IntToStr(MemVirtExtended);
       lblMemVirtFree.Caption := IntToStr(MemVirtFree);
       lblMemVirtTotal.Caption := IntToStr(MemVirtTotal);


   end;

end;

procedure TForm1.TimerLblupdateTimer(Sender: TObject);
begin
  If cbAutoUpdateSysInfo.Checked then
  begin
    BtnUpdateSysinfoClick(sender);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
end;

procedure TForm1.TimerLogTimer(Sender: TObject);

  //Fixed String Length
  function FSL(inStr : string) : string;
  const outlength : integer = 22;
  var strlength,i : integer;
    outstr : string;
  begin
    strlength := length(Instr);
    for i:=outlength - strlength downto 0 do
    begin
      outstr := outstr + ' ';
    end;
    outstr := Outstr + Instr + ';';
    Result := Outstr;

  end;
begin
  if cbLogMempage.Checked then
  begin
    if MemoMemPageLog.Lines.Count < 1 then
    begin
    MemoMemPageLog.Lines.Add(
      FSL('DateTime') + FSL('used MemPage(%)') +
        FSL('Used MemPage (KB/MB)') + FSL('Total MemPage (KB/MB)')+
        FSL('Used MemPhys(%)')+ FSL('used MemPhys(KB/MB)') +
        FSL('Total MemPhys(KB/MB)')
        );
    end;

    MemoMemPageLog.Lines.Add(
      FSL(DateTimeToStr(Now))+ FSL(lblMemPagePercentUsed.Caption) +
      FSL(lblMemPageUsed.Caption) + FSL(lblMemPageTotal.Caption) +
      FSL(lblMemPhysPercentUsed.Caption) + FSL(lblMemPhysUsed.Caption) +
      FSL(lblMemPhysTotal.Caption)
      );

      
  end;

end;

procedure TForm1.LMDSpinEdit1Change(Sender: TObject);
begin
  TimerLog.Interval := LMDSpinEdit1.Value * 1000;
end;

procedure TForm1.btnGetMem2Click(Sender: TObject);
var
  F: file;
  Size: Integer;
  Buffer: PChar;
begin
  AssignFile(F, 'data.doc');
  Reset(F, 1);
  try
    Size := FileSize(F);
    GetMem(Buffer, Size);
    //buffer := Parray[1];
    try
      BlockRead(F, Buffer^, Size);

      MemParray2[ArrayIndex2] := buffer;
      AllocSizeArray2[ArrayIndex2] := Size;
      inc(ArrayIndex2);
      Caption := IntToStr(ArrayIndex2);
      //ProcessFile(Buffer, Size);
    finally
       //FreeMem(Buffer); // free later with  freemem2 button
    end;
  finally
    CloseFile(F);
  end;



end;

procedure TForm1.Button3Click(Sender: TObject);
var
 i : integer;
begin
  if ArrayIndex2 = -1 then exit;
  i := ArrayIndex2;

  for i := 0 to i do
  begin
    dec(ArrayIndex2);
    FreeMem(MemParray2[ArrayIndex2],AllocSizeArray2[ArrayIndex2]);
    Caption := IntToStr(ArrayIndex2);
  end;
end;

procedure TForm1.btnClearLogClick(Sender: TObject);
begin
  MemoMemPageLog.Lines.Clear;
end;

end.
