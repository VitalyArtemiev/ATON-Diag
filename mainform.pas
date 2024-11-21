unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Math, Menus, ExtCtrls, ComCtrls, Spin, EditBtn, Buttons, ButtonPanel, ActnList,
  ComboEx, CheckLst, synaser, StrUtils, LConvEncoding, SpinEx, CheckBoxThemed,
  DateTimePicker;

procedure WriteProgramLog(Log: string; Force: boolean = False);
procedure WriteProgramLog(i: longint; Force: boolean = False);
procedure WriteProgramLog(i: int64; Force: boolean = False);
procedure WriteProgramLog(d: double; Force: boolean = False);
//procedure SeparateIndices(Source: string; sa: TStrings; var ia: tStringArray);

function strf(x: double): string;
function strf(x: longint): string;
function strf(x: int64): string;
function valf(s: string): integer;
function vald(s: string): double;

type

  //TMyThread = class(TThread)
  //private
  //  fStatusText : string;
  //  procedure ShowStatus;
  //protected
  //  procedure Execute; override;
  //public
  //  Constructor Create(CreateSuspended : boolean);
  //end;

  //constructor TMyThread.Create(CreateSuspended : boolean);
  //begin
  //  inherited Create(CreateSuspended);
  //  FreeOnTerminate := True;
  //end;

  //procedure TMyThread.ShowStatus;
  //// this method is executed by the mainthread and can therefore access all GUI elements.
  //begin
  //  Form1.Caption := fStatusText;
  //end;

  //procedure TMyThread.Execute;
  //var
  //  newStatus : string;
  //begin
  //  fStatusText := 'TMyThread Starting...';
  //  Synchronize(@Showstatus);
  //  fStatusText := 'TMyThread Running...';
  //  while (not Terminated) and ([any condition required]) do
  //    begin
  //      ...
  //      [here goes the code of the main thread loop]
  //      ...
  //      if NewStatus <> fStatusText then
  //        begin
  //          fStatusText := newStatus;
  //          Synchronize(@Showstatus);
  //        end;
  //    end;
  //end;

  { TMainF }

  TMainF = class(TForm)
    bConnect: TButton;
    bDisconnect: TButton;
    cbParity2: TComboBox;
    cbParity3: TComboBox;
    cbParity4: TComboBox;
    cbParity5: TComboBox;
    cbParity6: TComboBox;
    cbParity7: TComboBox;
    cbParity8: TComboBox;
    cbPortSelect: TComboBox;
    cbParity1: TComboBox;
    clbLog1: TCheckListBox;
    clbLog2: TCheckListBox;
    clbLog3: TCheckListBox;
    clbLog4: TCheckListBox;
    clbLog5: TCheckListBox;
    clbLog6: TCheckListBox;
    clbLog7: TCheckListBox;
    clbLog8: TCheckListBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lActual: TLabel;
    lTotalMessages: TLabel;
    lLog: TLabel;
    lTimeouts: TLabel;
    lCRCErr: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    seActual1: TFloatSpinEditEx;
    iBaudRate: TLabel;
    iDeviceID: TLabel;
    iExpectedValue: TLabel;
    lMargin: TLabel;
    Label1: TLabel;
    lParity: TLabel;
    lParity1: TLabel;
    MainMenu: TMainMenu;
    About: TMenuItem;
    Panel1: TPanel;
    pCaptions: TPanel;
    seActual2: TFloatSpinEditEx;
    seActual3: TFloatSpinEditEx;
    seActual4: TFloatSpinEditEx;
    seActual5: TFloatSpinEditEx;
    seActual6: TFloatSpinEditEx;
    seActual7: TFloatSpinEditEx;
    seActual8: TFloatSpinEditEx;
    seBaudRate2: TSpinEdit;
    seBaudRate3: TSpinEdit;
    seBaudRate4: TSpinEdit;
    seBaudRate5: TSpinEdit;
    seBaudRate6: TSpinEdit;
    seBaudRate7: TSpinEdit;
    seBaudRate8: TSpinEdit;
    seCRCErrPercent2: TSpinEditEx;
    seCRCErrPercent3: TSpinEditEx;
    seCRCErrPercent4: TSpinEditEx;
    seCRCErrPercent5: TSpinEditEx;
    seCRCErrPercent6: TSpinEditEx;
    seCRCErrPercent7: TSpinEditEx;
    seCRCErrPercent8: TSpinEditEx;
    seCRCErrTotal2: TSpinEditEx;
    seCRCErrTotal3: TSpinEditEx;
    seCRCErrTotal4: TSpinEditEx;
    seCRCErrTotal5: TSpinEditEx;
    seCRCErrTotal6: TSpinEditEx;
    seCRCErrTotal7: TSpinEditEx;
    seCRCErrTotal8: TSpinEditEx;
    seExpected2: TFloatSpinEdit;
    seExpected3: TFloatSpinEdit;
    seExpected4: TFloatSpinEdit;
    seExpected5: TFloatSpinEdit;
    seExpected6: TFloatSpinEdit;
    seExpected7: TFloatSpinEdit;
    seExpected8: TFloatSpinEdit;
    seID2: TSpinEdit;
    seID3: TSpinEdit;
    seID4: TSpinEdit;
    seID5: TSpinEdit;
    seID6: TSpinEdit;
    seID7: TSpinEdit;
    seID8: TSpinEdit;
    seMargin2: TSpinEdit;
    seMargin3: TSpinEdit;
    seMargin4: TSpinEdit;
    seMargin5: TSpinEdit;
    seMargin6: TSpinEdit;
    seMargin7: TSpinEdit;
    seMargin8: TSpinEdit;
    seTimeoutsPercent2: TSpinEditEx;
    seTimeoutsPercent3: TSpinEditEx;
    seTimeoutsPercent4: TSpinEditEx;
    seTimeoutsPercent5: TSpinEditEx;
    seTimeoutsPercent6: TSpinEditEx;
    seTimeoutsPercent7: TSpinEditEx;
    seTimeoutsPercent8: TSpinEditEx;
    seTimeoutsTotal2: TSpinEditEx;
    seTimeoutsTotal3: TSpinEditEx;
    seTimeoutsTotal4: TSpinEditEx;
    seTimeoutsTotal5: TSpinEditEx;
    seTimeoutsTotal6: TSpinEditEx;
    seTimeoutsTotal7: TSpinEditEx;
    seTimeoutsTotal8: TSpinEditEx;
    seTotalMessages1: TSpinEditEx;
    seExpected1: TFloatSpinEdit;
    seMargin1: TSpinEdit;
    seID1: TSpinEdit;
    seNumDevices: TSpinEdit;
    seBaudRate1: TSpinEdit;
    seCRCErrPercent1: TSpinEditEx;
    seTimeoutsTotal1: TSpinEditEx;
    seTimeoutsPercent1: TSpinEditEx;
    seCRCErrTotal1: TSpinEditEx;
    seTotalMessages2: TSpinEditEx;
    seTotalMessages3: TSpinEditEx;
    seTotalMessages4: TSpinEditEx;
    seTotalMessages5: TSpinEditEx;
    seTotalMessages6: TSpinEditEx;
    seTotalMessages7: TSpinEditEx;
    seTotalMessages8: TSpinEditEx;
    StatusBar: TStatusBar;
    teQueryInterval: TDateTimePicker;
    tQuery: TTimer;
    tbQuery: TToggleBox;
    procedure bConnectClick(Sender: TObject);
    procedure bDisconnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function ConnectSerial: longint;
    procedure seNumDevicesChange(Sender: TObject);
    procedure tbQueryChange(Sender: TObject);
    procedure teQueryIntervalChange(Sender: TObject);
    procedure tQueryTimer(Sender: TObject);
    procedure sendByteCRC16(var CRC: word; Data: byte);
    procedure sendCommand(deviceID, ModBusCode: byte; opCode, numRegisters: word);

    function getDeviceData(id: byte): word;
    function withinMargin(expected, actual: double; margin: integer): boolean;
  private
    TestResult: string;
    SerPort: tBlockSerial;
    timeoutCount: longword;
    CRCErrorCount: longword;

  public

  end;

const
  spConnection = 0;
  spDevice = 1;
  spTimeOuts = 2;
  spCRCErrors = 3;

var
  MainF: TMainF;
  PortList: string;
  PortCount: integer = 0;
  LogCS: TRTLCriticalSection;
  ProgramLog: TFileStream;

implementation

function strf(x: double): string; inline;
begin
  str(x, Result);
end;

function strf(x: longint): string; inline;
begin
  str(x, Result);
end;

function strf(x: int64): string;
begin
  str(x, Result);
end;

function valf(s: string): integer; inline;
begin
  val(s, Result);
end;

function vald(s: string): double; inline;
begin
  val(s, Result);
end;

procedure WriteProgramLog(Log: string; Force: boolean = False); inline;
begin
  try
    EnterCriticalSection(LogCS);
    Log += LineEnding;
    ProgramLog.Write(Log[1], length(Log));
  finally
    LeaveCriticalSection(LogCS);
  end;
end;

procedure WriteProgramLog(i: longint; Force: boolean = False); inline;
begin
  WriteProgramLog(strf(i), Force);
end;

procedure WriteProgramLog(i: int64; Force: boolean = False); inline;
begin
  WriteProgramLog(strf(i), Force);
end;

procedure WriteProgramLog(d: double; Force: boolean = False); inline;
begin
  WriteProgramLog(strf(d), Force);
end;

{$R *.lfm}

{ TMainF }

procedure TMainF.FormCreate(Sender: TObject);
var
  p: integer;
begin
  PortList := GetSerialPortNames;
  SerPort := TBlockSerial.Create;
  SerPort.DeadLockTimeOut := 4000;

  PortCount := 0;

  if IsEmptyStr(PortList, [' ']) then
    StatusBar.Panels[spConnection].Text := 'Нет доступных COM-портов'
  else
  begin
    p := pos(',', PortList);
    if p = 0 then cbPortSelect.AddItem(PortList, nil)
    else
    begin
      while p <> 0 do
      begin
        cbPortSelect.AddItem(copy(PortList, 1, p - 1), nil);
        Delete(PortList, 1, p);
        Inc(PortCount);
        p := pos(',', PortList);
      end;
      cbPortSelect.AddItem(PortList, nil);
      Inc(PortCount);
    end;
  end;
  Inc(PortCount);
  cbPortSelect.ItemIndex := 0;
end;

procedure TMainF.tbQueryChange(Sender: TObject);
begin
  teQueryInterval.OnChange(Sender);
  tQuery.Enabled := tbQuery.Checked;
  if tbQuery.Checked then
    tbQuery.Caption := 'Query ON'
  else
    tbQuery.Caption := 'Query OFF';
end;

procedure TMainF.teQueryIntervalChange(Sender: TObject);
begin
  tQuery.Interval := Millisecondsbetween(0, teQueryInterval.Time);
end;

procedure TMainF.tQueryTimer(Sender: TObject);
var
  Value: word;
  float: double;
begin
  if SerPort.InstanceActive then
  begin
    Value := getDeviceData(byte(seID1.Value));
    float := double(Value) / 10;
    seActual1.Value := float;
    clbLog1.AddItem(FloatToStrf(float, ffFixed, 2, 2), nil);

    clbLog1.Checked[clbLog1.Count - 1] :=
      withinMargin(seExpected1.Value, seActual1.Value, seMargin1.Value);
    clbLog1.TopIndex := clbLog1.Count - 1;
  end;
end;

procedure TMainF.sendByteCRC16(var CRC: word; Data: byte);
var
  I: integer;
begin
  CRC := CRC xor (word(Data));
  for I := 0 to 7 do
  begin
    if (CRC and 1) <> 0 then
      CRC := (CRC shr 1) xor $A001
    else
      CRC := CRC shr 1;
  end;
  //showmessage(inttohex(data));
  SerPort.SendByte(Data);
end;

procedure TMainF.sendCommand(deviceID, ModBusCode: byte; opCode, numRegisters: word);
var
  crc: word;
begin
  crc := $FFFF;
  sendByteCRC16(crc, deviceID);
  sendByteCRC16(crc, ModBusCode);
  sendByteCRC16(crc, hi(opCode));
  sendByteCRC16(crc, lo(opCode));
  sendByteCRC16(crc, hi(numRegisters));
  sendByteCRC16(crc, lo(numRegisters));
  SerPort.SendByte(lo(crc));
  SerPort.SendByte(hi(crc));
end;

function TMainF.getDeviceData(id: byte): word;
var
  Count: integer;
  buf: array [0..128] of byte;
begin
  StatusBar.Panels[spDevice].Text := 'Quering device ID: ' + IntToStr(id);
  StatusBar.Update;
  SerPort.RaiseExcept := False;
  seTotalMessages1.Value := seTotalMessages1.Value + 1;

  sendCommand(byte(ID), $03, $0800, $001A);
  Count := serport.RecvBufferEx(@buf[0], 31, 500);

  if Count = 31 then
    Result := (buf[12] or buf[11] shl 8)
  else
  begin
    Inc(timeoutCount);
    seTimeoutsTotal1.Value := seTimeoutsTotal1.Value + 1;

    StatusBar.Panels[spTimeouts].Text := 'Timeouts: ' + IntToStr(timeoutCount);
    StatusBar.Update;
    Result := 0;
  end;
  //Math.SetRoundMode(rmUp);
  seTimeoutsPercent1.Value := round(seTimeoutsTotal1.Value / seTotalMessages1.Value * 100);
  SerPort.RaiseExcept := True;
  StatusBar.Panels[spDevice].Text := '';
  StatusBar.Update;
end;

function TMainF.withinMargin(expected, actual: double; margin: integer): boolean;
begin
  Result := abs(expected - actual) < expected * (margin * 0.01);
end;

function TMainF.ConnectSerial: longint;
var
  Parity: char;
  i, ID, Count: integer;

  s: string;
  ast: ansistring;
  enc: boolean;
  ts: TStream;
begin
  //WriteProgramLog('Подключение...');

  //SerPort.RaiseExcept:= true;
  //SerPort.TestDsr:= true;
  try
    s := cbPortSelect.Text;
    SerPort.Connect(s);
    sleep(500);
    if SerPort.LastError = 0 then
    begin
      for i := 1 to seNumDevices.Value do
      begin
        ID := seID1.Value;
        //SerPort.RaiseExcept:= false;   //because this resets in recvstring

        s := 'Попытка подключения к ' + cbPortSelect.Text;
        StatusBar.Panels[spConnection].Text := s;
        StatusBar.Update;
        //WriteProgramLog(s);
        Parity := cbParity1.Text[1];
        SerPort.Config(seBaudRate1.Value, 8, Parity, SB2, False, False);
        sleep(500);
      end;
    end
    else
    begin
      Result := -4;   //synaser error
    end;

    if SerPort.InstanceActive and (Result = 0) then
    begin
      StatusBar.Panels[spConnection].Text :=
        'Подключено к ' + cbPortSelect.Text;
      Result := 0;
      //TimeOutErrors:= 0;
      //EnableControls(true);

      SerPort.RaiseExcept := True;

      //case Config.OnConnect of
      //  AQuery: btQueryClick(Self);
      //  AReset: btResetClick(Self);
      //end;
    end
    else
    begin
      StatusBar.Panels[spConnection].Text := 'Нет подключения';
      case Result of
        -1: StatusBar.Panels[spConnection].Text := 'Устройство не ответило';
        -2: StatusBar.Panels[spConnection].Text :=
            'Устройство ' + TestResult + ' не опознано';
        -3: StatusBar.Panels[spConnection].Text :=
            'Нет совместимых устройств - COM';
        -4:  //problems with encoding from win drivers
        begin
          s := SerPort.LastErrorDesc;
          s := ConvertEncodingToUTF8(s, GuessEncoding(s), enc);
          StatusBar.Panels[spConnection].Text :=
            'Ошибка подключения: ' + s;
        end;
      end;
      //if DisplayMessages then
      //ShowMessage(StatusBar.Panels[spStatus].Text);
      //WriteProgramLog(StatusBar.Panels[spStatus].Text);

      SerPort.CloseSocket;
      //FreeAndNil(SerPort);
      if Result = 0 then
        Result := -5; //this should never happen; instance not active
      exit;
    end;

  except
    on E: Exception do
    begin
      //WriteProgramLog(E.Message, true);
      //WriteProgramLog(SerPort.LastError, true);
      //WriteProgramLog('LB' + SerPort.LineBuffer, true);
      ShowMessage(E.Message);
      SerPort.CloseSocket;
      //FreeAndNil(SerPort);
      Result := -6; //driver error: receive framing error
    end;
  end;
end;

procedure TMainF.seNumDevicesChange(Sender: TObject);
begin
     Panel2.Visible:= seNumDevices.Value > 1;
     Panel3.Visible:= seNumDevices.Value > 2;
     Panel4.Visible:= seNumDevices.Value > 3;
     Panel5.Visible:= seNumDevices.Value > 4;
     Panel6.Visible:= seNumDevices.Value > 5;
     Panel7.Visible:= seNumDevices.Value > 6;
     Panel8.Visible:= seNumDevices.Value > 7;
     Width:= 780 + Panel1.Width * (seNumDevices.Value -5)
end;

procedure TMainF.bConnectClick(Sender: TObject);
var
  Result: integer;
  Crutch: integer absolute Result;
begin
  //SetCursorAll(crHourGlass);

  Result := ConnectSerial;

  if (Result = 0)
  {$IFDEF D+}
 or debug
  {$ENDIF}
  then
  begin
    bConnect.Enabled := False;
    bDisconnect.Enabled := True;
    tbQuery.Enabled := True;
  end;
  //else
  //  WriteProgramLog('Подключение - результат: ' + strf(Result));
  //SetCursorAll(crDefault);
end;

procedure TMainF.bDisconnectClick(Sender: TObject);
begin
  tQuery.Enabled := False;
  if assigned(SerPort) then
  begin
    if SerPort.InstanceActive then
    begin
      SerPort.Purge;
      SerPort.CloseSocket;
    end;
    clbLog1.Clear;
    //freeandnil(SerPort);
  end;
  bConnect.Enabled := True;
  bDisconnect.Enabled := False;
  tbQuery.Enabled := False;
  tbQuery.Checked := False;
end;

end.
