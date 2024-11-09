unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ExtCtrls, ComCtrls, Spin, EditBtn, synaser, StrUtils,  LConvEncoding;

 procedure WriteProgramLog(Log: string; Force: boolean = false);
 procedure WriteProgramLog(i: longint; Force: boolean = false);
 procedure WriteProgramLog(i: int64; Force: boolean = false);
 procedure WriteProgramLog(d: double; Force: boolean = false);
 //procedure SeparateIndices(Source: string; sa: TStrings; var ia: tStringArray);

 function strf(x: double): string;
 function strf(x: longint): string;
 function strf(x: int64): string;
 function valf(s: string): integer;
 function vald(s: string): double;

type

  { TMainF }

  TMainF = class(TForm)
    bConnect: TButton;
    bDisconnect: TButton;
    cbPortSelect: TComboBox;
    cbParity: TComboBox;
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
    seMargin: TSpinEdit;
    seID: TSpinEdit;
    seExpected: TSpinEdit;
    seNumDevices: TSpinEdit;
    seBaudRate: TSpinEdit;
    Shape1: TShape;
    StatusBar: TStatusBar;
    TimeEdit1: TTimeEdit;
    Timer1: TTimer;
    tbQuery: TToggleBox;
    procedure bConnectClick(Sender: TObject);
    procedure bDisconnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function ConnectSerial: longint;
    function RecvString(TimeOut: longword): string;
  private
    TestResult: string;
    SerPort: tBlockSerial;

  public

  end;

const
  spConnection = 0;
  spDevice = 1;
  spTimeOuts = 2;
  spStatus = 3;

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

procedure WriteProgramLog(Log: string; Force: boolean = false); inline;
begin
  try
    EnterCriticalSection(LogCS);
      Log+= LineEnding;
      ProgramLog.Write(Log[1], length(Log));
  finally
    LeaveCriticalSection(LogCS);
  end;
end;

procedure WriteProgramLog(i: longint; Force: boolean = false); inline;
begin
  WriteProgramLog(strf(i), Force);
end;

procedure WriteProgramLog(i: int64; Force: boolean = false); inline;
begin
  WriteProgramLog(strf(i), Force);
end;

procedure WriteProgramLog(d: double; Force: boolean = false); inline;
begin
  WriteProgramLog(strf(d), Force);
end;

{$R *.lfm}

{ TMainF }

procedure TMainF.FormCreate(Sender: TObject);
var
  p: integer;
begin
  PortList:= GetSerialPortNames;

  PortCount:= 0;

  if IsEmptyStr(PortList, [' ']) then
    StatusBar.Panels[spStatus].Text:= 'Нет доступных COM-портов'
  else
    begin
      p:= pos(',', PortList);
      if p = 0 then cbPortSelect.AddItem(PortList, nil)
      else
        begin
          while p <> 0 do
          begin
            cbPortSelect.AddItem(copy(PortList, 1, p - 1), nil);
            delete(PortList, 1, p);
            inc(PortCount);
            p:= pos(',', PortList);
          end;
          cbPortSelect.AddItem(PortList, nil);
          inc(PortCount);
        end;
    end;
  inc(PortCount);
  cbPortSelect.ItemIndex:=0;
end;


function TMainF.RecvString(TimeOut: longword): string;
var
  t: longword;
begin
  if (serport.instanceactive) and (serport.CTS) then
  begin
    SerPort.RaiseExcept:= false;
    Result:= SerPort.RecvBufferStr(128, Timeout);
    SerPort.RaiseExcept:= true;

    showMessage('Получена строка ' + Result);

    case SerPort.LastError of
      0: ;
      //ErrTimeOut: TimeOutErrors:= TimeOutErrors + 1;
      else
        //WriteProgramLog('RecvString Error' + SerPort.LastErrorDesc);
    end;
  end;
end;

function TMainF.ConnectSerial: longint;
var
  Parity: char;
  i, ID: integer;
  buf : array [0..128] of Byte;

  s: string;
  ast: ansistring;
  enc: boolean;
  ts: TStream;
begin
  //WriteProgramLog('Подключение...');
  TestResult:= '';

  //ConnectionKind:= cSerial;
  SerPort:= TBlockSerial.Create;
  SerPort.ConvertLineEnd:= true;
  SerPort.DeadLockTimeOut:= 4000;
  SerPort.RaiseExcept:= true;
  SerPort.TestDsr:= true;
  try
    s:= cbPortSelect.Text;
    SerPort.Connect(s);
    sleep(500);
    if SerPort.LastError = 0 then
    begin
      for i:= 1 to seNumDevices.Value do
      begin
        ID:= seID.Value;
        //SerPort.RaiseExcept:= false;   //because this resets in recvstring

        s:= 'Попытка подключения к ' + IntToStr(ID);
        StatusBar.Panels[spStatus].Text:= s;
        StatusBar.Update;
        //WriteProgramLog(s);
        Parity:= cbParity.Text[1];
        SerPort.Config(seBaudRate.Value, 8, Parity, 2, true, true);
          sleep(500);
        SerPort.Purge;
          sleep(500);

        //command:= HexStr($0103080000104666);

        //SerPort.SendInteger($0C030800001AC77C);   //cts????
        SerPort.SendByte($0C);
        SerPort.SendByte($03);
        SerPort.SendByte($08);
        SerPort.SendByte($00);
        SerPort.SendByte($00);
        SerPort.SendByte($10);
        SerPort.SendByte($C7);
        SerPort.SendByte($7C);

        SerPort.SendByte($0D);
        SerPort.SendByte($0A);

        //ts := TStream.Create;
        //Serport.RecvStreamSize(ts, 1000, 32);
        //showmessage(inttostr(SerPort.WaitingDataex()));

        serport.RecvBufferEx(@buf[0], 128, 1000);

        StatusBar.Panels[spTimeouts].Text:= hexstr(buf[1],1);
        StatusBar.Panels[spStatus].Text:= hexstr(word(buf[2]),1);
        StatusBar.Update;
        //if (serport.instanceactive) and (serport.CTS) then
        //begin
        //  SerPort.Purge;
        //end;
      end;
    end
    else
    begin
      Result:= -4   //synaser error
    end;

    if SerPort.InstanceActive and (Result = 0) then
    begin
      StatusBar.Panels[spConnection].Text:= 'Подключено к ' + cbPortSelect.Text;
      Result:= 0;
      //TimeOutErrors:= 0;
      //EnableControls(true);

      SerPort.RaiseExcept:= true;

      //case Config.OnConnect of
      //  AQuery: btQueryClick(Self);
      //  AReset: btResetClick(Self);
      //end;
    end
    else
    begin
      StatusBar.Panels[spConnection].Text:= 'Нет подключения';
      case Result of
        -1: StatusBar.Panels[spStatus].Text:= 'Устройство не ответило';
        -2: StatusBar.Panels[spStatus].Text:= 'Устройство ' + TestResult + ' не опознано';
        -3: StatusBar.Panels[spStatus].Text:= 'Нет совместимых устройств - COM';
        -4:  //problems with encoding from win drivers
          begin
            s:= SerPort.LastErrorDesc;
            s:= ConvertEncodingToUTF8(s, GuessEncoding(s), enc);
            StatusBar.Panels[spStatus].Text:= 'Ошибка подключения: ' + s;
          end;
      end;
      //if DisplayMessages then
        //ShowMessage(StatusBar.Panels[spStatus].Text);
      //WriteProgramLog(StatusBar.Panels[spStatus].Text);

      SerPort.CloseSocket;
      freeandnil(SerPort);
      if Result = 0 then
        Result:= -5; //this should never happen; instance not active
      exit;
    end;

  except
    on E:Exception do
    begin
      //WriteProgramLog(E.Message, true);
      //WriteProgramLog(SerPort.LastError, true);
      //WriteProgramLog('LB' + SerPort.LineBuffer, true);
      ShowMessage(E.Message);
      SerPort.CloseSocket;
      freeandnil(SerPort);
      Result:= -6; //driver error: receive framing error
    end;
  end;
end;



procedure TMainF.bConnectClick(Sender: TObject);
var
  Result: integer;
  Crutch: integer absolute Result;
begin
  //SetCursorAll(crHourGlass);

  //btnDisconnectClick(Sender);

  Result:= ConnectSerial;

  if (Result = 0) {$IFDEF D+} or debug {$ENDIF}     then
  begin
    Crutch:= cbPortSelect.ItemIndex;  //because it loads port too
    //GetDeviceParams;
    //AfterConnect;

    cbPortSelect.ItemIndex:= Crutch;
  end
  //else
  //  WriteProgramLog('Подключение - результат: ' + strf(Result));
  //SetCursorAll(crDefault);
end;

procedure TMainF.bDisconnectClick(Sender: TObject);
begin
  if assigned(SerPort) then
  begin
    if SerPort.InstanceActive then
    begin
      SerPort.Purge;
      SerPort.CloseSocket;
    end;
    freeandnil(SerPort);
  end;
end;

end.

