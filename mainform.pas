unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Math, Menus, ExtCtrls, ComCtrls, Spin, Buttons,
  ActnList, CheckLst, synaser, StrUtils, LConvEncoding,
  SpinEx, DateTimePicker, jsonconf;

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

  TDataResult = record
    errorcode: integer;
    intresult: integer;
    floatresult: double;
  end;

  { TMainF }

  TMainF = class(TForm)
    bConnect: TButton;
    bDisconnect: TButton;
    bRescan: TButton;
    bSaveState: TButton;
    bLoadState: TButton;
    cbParity: TComboBox;
    cbPortSelect: TComboBox;
    clbLog1: TCheckListBox;
    clbLog2: TCheckListBox;
    clbLog3: TCheckListBox;
    clbLog4: TCheckListBox;
    clbLog5: TCheckListBox;
    clbLog6: TCheckListBox;
    clbLog7: TCheckListBox;
    clbLog8: TCheckListBox;
    iBaudRate: TLabel;
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
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lInterval: TLabel;
    lPort: TLabel;
    lActual: TLabel;
    lParity: TLabel;
    lTotalMessages: TLabel;
    lLog: TLabel;
    lTimeouts: TLabel;
    lCRCErr: TLabel;
    lOK: TLabel;
    OpenDialog: TOpenDialog;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    SaveDialog: TSaveDialog;
    seActual1: TFloatSpinEditEx;
    iDeviceID: TLabel;
    iExpectedValue: TLabel;
    lMargin: TLabel;
    Label1: TLabel;
    lDeviceNum: TLabel;
    Panel1: TPanel;
    pCaptions: TPanel;
    seActual2: TFloatSpinEditEx;
    seActual3: TFloatSpinEditEx;
    seActual4: TFloatSpinEditEx;
    seActual5: TFloatSpinEditEx;
    seActual6: TFloatSpinEditEx;
    seActual7: TFloatSpinEditEx;
    seActual8: TFloatSpinEditEx;
    seBaudRate: TSpinEdit;
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
    seExpected1: TFloatSpinEditEx;
    seExpected2: TFloatSpinEditEx;
    seExpected3: TFloatSpinEditEx;
    seExpected4: TFloatSpinEditEx;
    seExpected5: TFloatSpinEditEx;
    seExpected6: TFloatSpinEditEx;
    seExpected7: TFloatSpinEditEx;
    seExpected8: TFloatSpinEditEx;
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
    seOKPercent1: TSpinEditEx;
    seOKPercent2: TSpinEditEx;
    seOKPercent3: TSpinEditEx;
    seOKPercent4: TSpinEditEx;
    seOKPercent5: TSpinEditEx;
    seOKPercent6: TSpinEditEx;
    seOKPercent7: TSpinEditEx;
    seOKPercent8: TSpinEditEx;
    seOKTotal1: TSpinEditEx;
    seOKTotal2: TSpinEditEx;
    seOKTotal3: TSpinEditEx;
    seOKTotal4: TSpinEditEx;
    seOKTotal5: TSpinEditEx;
    seOKTotal6: TSpinEditEx;
    seOKTotal7: TSpinEditEx;
    seOKTotal8: TSpinEditEx;
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
    seMargin1: TSpinEdit;
    seID1: TSpinEdit;
    seNumDevices: TSpinEdit;
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
    procedure bLoadStateClick(Sender: TObject);
    procedure bRescanClick(Sender: TObject);
    procedure bDisconnectClick(Sender: TObject);
    procedure bSaveStateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function ConnectSerial: longint;
    procedure seNumDevicesChange(Sender: TObject);
    procedure tbQueryChange(Sender: TObject);
    procedure teQueryIntervalChange(Sender: TObject);
    procedure tQueryTimer(Sender: TObject);
    procedure sendByteCRC16(var CRC: word; Data: byte);
    procedure checkByteCRC16(var CRC: word; Data: byte);
    procedure sendCommand(deviceID, ModBusCode: byte; opCode, numRegisters: word);

    function getDeviceData(id: byte; device: integer): tDataResult;
    function withinMargin(expected, actual: double; margin: integer): boolean;
    procedure resetStats();
  private
    TestResult: string;
    SerPort: tBlockSerial;
    timeoutCount: longword;
    CRCErrorCount: longword;
    queryStart: TDateTime;

    aPanel: array [1..8] of tPanel;
    aID: array [1..8] of TSpinEdit;
    aExpected: array [1..8] of TFloatSpinEditEx;
    aMargin: array [1..8] of TSpinEdit;
    aActual: array [1..8] of TFloatSpinEditEx;
    aLog: array [1..8] of TCheckListBox;
    aTimeoutsTotal: array [1..8] of TSpinEditEx;
    aTimeoutsPercent: array [1..8] of TSpinEditEx;
    aCRCErrorTotal: array [1..8] of TSpinEditEx;
    aCRCErrorPercent: array [1..8] of TSpinEditEx;
    aOKTotal: array [1..8] of TSpinEditEx;
    aOKPercent: array [1..8] of TSpinEditEx;
    aMessagesTotal: array [1..8] of TSpinEditEx;

  public

  end;

const
  spConnection = 0;
  spDevice = 1;
  spTimeOuts = 2;
  spCRCErrors = 3;
  spTime = 4;

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
  i: integer;
  c: TComponent;
begin
  for i := 1 to 8 do
  begin
    c := findcomponent('Panel' + IntToStr(i));
    aPanel[i] := TPanel(c);
    c := findcomponent('seID' + IntToStr(i));
    aID[i] := TSpinEdit(c);
    c := findcomponent('seExpected' + IntToStr(i));
    aExpected[i] := TFloatSpinEditEx(c);
    c := findcomponent('seMargin' + IntToStr(i));
    aMargin[i] := TSpinEdit(c);
    c := findcomponent('seActual' + IntToStr(i));
    aActual[i] := TFloatSpinEditEX(c);
    c := findcomponent('clbLog' + IntToStr(i));
    aLog[i] := TCheckListBox(c);
    c := findcomponent('seTimeoutsTotal' + IntToStr(i));
    aTimeoutsTotal[i] := TSpinEditEX(c);
    c := findcomponent('seTimeoutsPercent' + IntToStr(i));
    aTimeoutsPercent[i] := TSpinEditEX(c);
    c := findcomponent('seCRCERRTotal' + IntToStr(i));
    aCRCErrorTotal[i] := TSpinEditEX(c);
    c := findcomponent('seCRCErrPercent' + IntToStr(i));
    aCRCErrorPercent[i] := TSpinEditEX(c);
    c := findcomponent('seOKTotal' + IntToStr(i));
    aOKTotal[i] := TSpinEditEX(c);
    c := findcomponent('seOKPercent' + IntToStr(i));
    aOKPercent[i] := TSpinEditEX(c);
    c := findcomponent('seTotalMessages' + IntToStr(i));
    aMessagesTotal[i] := TSpinEditEX(c);
  end;

  SerPort := TBlockSerial.Create;
  SerPort.DeadLockTimeOut := 4000;

  bRescanClick(Sender);

  seNumDevices.OnChange(Sender);
end;

procedure TMainF.tbQueryChange(Sender: TObject);
var
  i: integer;
begin
  teQueryInterval.OnChange(Sender);
  tQuery.Enabled := tbQuery.Checked;
  if tbQuery.Checked then
  begin
    tbQuery.Caption := 'Query is ON';
    resetStats;
    for i := 1 to 8 do
      aPanel[i].Enabled := False;
    seNumDevices.Enabled := False;
    bLoadState.Enabled := False;
    queryStart := now;
  end
  else
  begin
    tbQuery.Caption := 'Query is OFF';
    for i := 1 to 8 do
      aPanel[i].Enabled := True;
    seNumDevices.Enabled := True;
    bLoadState.Enabled := True;
  end;
end;

procedure TMainF.teQueryIntervalChange(Sender: TObject);
begin
  tQuery.Interval := Millisecondsbetween(0, teQueryInterval.Time);
end;

procedure TMainF.tQueryTimer(Sender: TObject);
var
  Result: tDataResult;
  marginOk: boolean;
  i: integer;
  time: string;
begin
  if SerPort.InstanceActive then
  begin
    for i := 1 to seNumDevices.Value do
    begin
      Result := getDeviceData(byte(aID[i].Value), i);

      if Result.errorcode = 0 then
      begin
        case IntToStr(aID[i].Value)[1] of
          '1': aActual[i].Value := Result.intresult / 100;
          '2': aActual[i].Value := Result.floatresult;
          '3': aActual[i].Value := Result.intresult;
          '4': aActual[i].Value := Result.floatresult;
          '5': aActual[i].Value := Result.intresult / 100;
          '6': aActual[i].Value := Result.intresult;
          else
            StatusBar.Panels[spDevice].Text :=
              'Device ID ' + IntToStr(i) + 'indicates unsupported data type';
        end;

        time := FormatDateTime('hh:nn:ss', now);
        aLog[i].AddItem(FloatToStrf(aActual[i].Value, ffGeneral, 3, 3) +
          ' @ ' + time, nil);

        marginOk := withinMargin(aExpected[i].Value, aActual[i].Value, aMargin[i].Value);

        aLog[i].Checked[aLog[i].Count - 1] := marginOk;
        aLog[i].TopIndex := aLog[i].Count - 1;

        if marginOk then
          aOKTotal[i].Value := aOKTotal[i].Value + 1;
        aOKPercent[i].Value := round(aOKTotal[i].Value / aMessagesTotal[i].Value * 100);
        if aOKPercent[i].Value <> 100 then
          aOKPercent[i].Color := clYellow
        else
          aOKPercent[i].Color := clLime;

        sleep(100);
        Application.ProcessMessages;
      end;
    end;
    StatusBar.Panels[spTime].Text := FormatDateTime('hh:nn:ss', now - queryStart);
  end;
end;

function wordToFloat(raw: word): double;
var
  p, k, n: word;
begin
  p := %1000000000000000 and raw shr 15;
  k := %0111000000000000 and raw shr 12;
  n := %0000111111111111 and raw;
  Result := n * intpower(10, (-2 * p + 1) * k);
end;

procedure TMainF.sendByteCRC16(var CRC: word; Data: byte);
begin
  checkByteCRC16(crc, Data);
  SerPort.SendByte(Data);
end;

procedure TMainF.checkByteCRC16(var CRC: word; Data: byte);
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



function TMainF.getDeviceData(id: byte; device: integer): tDataResult;
var
  Count: integer;
  buf: array [0..128] of byte;
  crc: word;
  i: integer;
begin
  StatusBar.Panels[spDevice].Text := 'Quering device ID: ' + IntToStr(id);
  StatusBar.Update;
  SerPort.RaiseExcept := False;
  aMessagesTotal[device].Value := aMessagesTotal[device].Value + 1;

  Result.errorcode := 0;

  sendCommand(id, $03, $0800, $001A);
  Count := serport.RecvBufferEx(@buf[0], 31, 500);

  if Count = 31 then
  begin
    crc := $FFFF;
    for i := 0 to 28 do
      checkByteCRC16(crc, buf[i]);
    if crc = (buf[29] or buf[30] shl 8) then
    begin
      Result.intresult := (buf[12] or buf[11] shl 8);
      Result.floatresult := wordToFloat(Result.intresult);
    end
    else
    begin
      Inc(crcerrorcount);
      aCRCErrorTotal[device].Value := aCRCErrorTotal[device].Value + 1;
      Result.errorcode := -1;

      StatusBar.Panels[spCRCErrors].Text := 'CRC errors: ' + IntToStr(timeoutCount);
      StatusBar.Update;
    end;
  end
  else
  begin
    Inc(timeoutCount);
    aTimeoutsTotal[device].Value := aTimeoutsTotal[device].Value + 1;
    Result.errorcode := -2;

    StatusBar.Panels[spTimeouts].Text := 'Timeouts: ' + IntToStr(timeoutCount);
    StatusBar.Update;
  end;
  //Math.SetRoundMode(rmUp);
  aTimeoutsPercent[device].Value :=
    round(aTimeoutsTotal[device].Value / aMessagesTotal[device].Value * 100);
  StatusBar.Panels[spDevice].Text := '';
  StatusBar.Update;
end;

function TMainF.withinMargin(expected, actual: double; margin: integer): boolean;
begin
  Result := abs(expected - actual) <= expected * (margin * 0.01);
end;

procedure TMainF.resetStats();
var
  i: integer;
begin
  for i := 1 to 8 do
  begin
    aLog[i].Clear;
    aActual[i].Value := 0;
    aTimeoutsTotal[i].Value := 0;
    aTimeoutsPercent[i].Value := 0;
    aCRCErrorTotal[i].Value := 0;
    aCRCErrorPercent[i].Value := 0;
    aOKTotal[i].Value := 0;
    aOKPercent[i].Value := 0;
    aMessagesTotal[i].Value := 0;
  end;
  StatusBar.Panels[spTime].Text := '00:00:00';
  StatusBar.Panels[spTimeOuts].Text := '';
  StatusBar.Panels[spCRCErrors].Text := '';
  timeoutCount := 0;
  CRCErrorCount := 0;
  aOKPercent[i].Color := clWindow;
end;

function TMainF.ConnectSerial: longint;
var
  Parity: char;
  i: integer;

  s: string;
  enc: boolean;
begin
  //WriteProgramLog('Подключение...');

  //SerPort.TestDsr:= true;
  try
    s := cbPortSelect.Text;
    SerPort.Connect(s);
    sleep(100);
    if SerPort.LastError = 0 then
    begin
      for i := 1 to seNumDevices.Value do
      begin
        //SerPort.RaiseExcept:= false;   //because this resets in recvstring

        s := 'Connecting to ' + cbPortSelect.Text;
        StatusBar.Panels[spConnection].Text := s;
        StatusBar.Update;
        //WriteProgramLog(s);
        Parity := cbParity.Text[1];
        SerPort.Config(seBaudRate.Value, 8, Parity, SB2, False, False);
        sleep(100);
      end;
    end
    else
    begin
      Result := -4;   //synaser error
    end;

    if SerPort.InstanceActive and (Result = 0) then
    begin
      StatusBar.Panels[spConnection].Text :=
        'Connected to ' + cbPortSelect.Text;
      Result := 0;
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
  Panel2.Visible := seNumDevices.Value > 1;
  Panel3.Visible := seNumDevices.Value > 2;
  Panel4.Visible := seNumDevices.Value > 3;
  Panel5.Visible := seNumDevices.Value > 4;
  Panel6.Visible := seNumDevices.Value > 5;
  Panel7.Visible := seNumDevices.Value > 6;
  Panel8.Visible := seNumDevices.Value > 7;
  Width := 780 + Panel1.Width * (seNumDevices.Value - 5);
end;

procedure TMainF.bConnectClick(Sender: TObject);
var
  Result: integer;
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


procedure TMainF.bRescanClick(Sender: TObject);
var
  p: integer;
begin
  PortList := GetSerialPortNames;
  PortCount := 0;

  if IsEmptyStr(PortList, [' ']) then
    StatusBar.Panels[spConnection].Text := 'No available COM-ports'
  else
  begin
    StatusBar.Panels[spConnection].Text := '';
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

procedure TMainF.bDisconnectClick(Sender: TObject);
var
  i: integer;
begin
  tQuery.Enabled := False;
  if assigned(SerPort) then
  begin
    if SerPort.InstanceActive then
    begin
      SerPort.Purge;
      SerPort.CloseSocket;
    end;
    resetStats;
    //freeandnil(SerPort);
  end;
  bConnect.Enabled := True;
  bDisconnect.Enabled := False;
  tbQuery.Enabled := False;
  tbQuery.Checked := False;
end;

procedure TMainF.bSaveStateClick(Sender: TObject);
var
  i: integer;
  c: TJsonConfig;
begin
  if not SaveDialog.Execute then
    exit;

  c:= TJSONConfig.Create(Nil);
  try
    //try/except to handle broken json file
    try
      c.Formatted:= true;
      c.Filename:= SaveDialog.Filename;
    except
      exit;
    end;

    c.SetValue(UTF8Decode('/parity/itemindex'), cbParity.ItemIndex);
    c.SetValue(UTF8Decode('/baudrate/value'), seBaudRate.Value);
    c.SetValue(UTF8Decode('/numdevices/value'), seNumDevices.Value);
    c.SetValue(UTF8Decode('/queryinterval/value'), teQueryInterval.Time);

    for i := 1 to 8 do
    begin
      c.SetValue(UTF8Decode('/id/' + inttostr(i) + '/value'), aID[i].Value);
      c.SetValue(UTF8Decode('/expected/' + inttostr(i) + '/value'), aExpected[i].Value);
      c.SetValue(UTF8Decode('/margin/' + inttostr(i) + '/value'), aMargin[i].Value);
    end;

  finally
    c.Free;
  end;
end;


procedure TMainF.bLoadStateClick(Sender: TObject);
var
  i: integer;
  c: TJsonConfig;
begin
  if not OpenDialog.Execute then
    exit;
  if not fileExists(OpenDialog.Filename) then
    exit;

  c:= TJSONConfig.Create(Nil);
  try
    //try/except to handle broken json file
    try
      c.Formatted:= true;
      c.Filename:= OpenDialog.Filename;
    except
      exit;
    end;

    cbParity.ItemIndex:= c.GetValue(UTF8Decode('/parity/itemindex'), cbParity.ItemIndex);
    seBaudRate.Value:= c.GetValue(UTF8Decode('/baudrate/value'), seBaudRate.Value);
    seNumDevices.Value:= c.GetValue(UTF8Decode('/numdevices/value'), seNumDevices.Value);
    teQueryInterval.Time:= c.GetValue(UTF8Decode('/queryinterval/value'), teQueryInterval.Time);

    for i := 1 to 8 do
    begin
      aID[i].Value:= c.GetValue(UTF8Decode('/id/' + inttostr(i) + '/value'), aID[i].Value);
      aExpected[i].Value:= c.GetValue(UTF8Decode('/expected/' + inttostr(i) + '/value'), aExpected[i].Value);
      aMargin[i].Value:= c.GetValue(UTF8Decode('/margin/' + inttostr(i) + '/value'), aMargin[i].Value);
    end;
  finally
    c.Free;
  end;
  seNumDevices.OnChange(Sender);
  teQueryInterval.OnChange(Sender);
end;


end.
