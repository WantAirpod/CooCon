unit ChatClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  StdCtrls, ExtCtrls, IdGlobal, IdAntiFreezeBase, IdAntiFreeze,math,
 IdThreadMgr, IdThreadMgrDefault, IdException;

type
  Tkloikm = class(TForm)
    ChatMsg: TEdit;
    EnterBtn: TButton;
    UserId: TEdit;
    Label1: TLabel;
    ChatMemo: TMemo;
    Timer1: TTimer;
    IdTCPClient1: TIdTCPClient;
    IdAntiFreeze1: TIdAntiFreeze;
    IdThreadMgrDefault1: TIdThreadMgrDefault;
    Label2: TLabel;
    ExitBtn: TButton;
    Label3: TLabel;
    procedure EnterBtnClick(Sender: TObject);
    procedure ChatMsgKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject );
    procedure ExitBtnClick(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure IdTCPClient1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure ChatMemoKeyPress(Sender: TObject; var Key: Char);
    procedure UserIdKeyPress(Sender: TObject; var Key: Char);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  kloikm: Tkloikm;
  rand3 : Byte;
  cnt : Integer;

implementation



{$R *.dfm}

//접속 버튼
procedure Tkloikm.EnterBtnClick(Sender: TObject);
var
a : array[0..10] of String;
i : Integer;
rand : Integer;
abc : Boolean;

begin
  if Trim(UserId.Text) = '' then
    begin
    ShowMessage('아이디를 입력하세요');
    exit;
    end;
 try IdTCPClient1.Connect();
  randomize;  //랜덤하기전에 꼭 randomize를 써야함.
  rand3:=Random(9999);
  IdTCPClient1.WriteLn(Format('%s#%s님이 로그인 하셨습니다.',[UserId.Text,IntToStr(rand3)]));
  EnterBtn.Destroy;
 Except
  ShowMessage('서버에 접속이 되어있지 않습니다.');
 end;
end;

Function  ReceiveText(IdTCPClient:TIdTCPClient):String;
Var
 Data : Pointer;
 DataSize : Integer;
 ssData : TStringStream;
Begin

 DataSize:= IdTCPClient.ReadFromStack(True, 5, False);
 If DataSize = 0 then Begin
   Result:= '';
   Exit;
 End;

 GetMem(Data, DataSize);
 ssData:= TStringStream.Create('');
 Try
   IdTCPClient.ReadBuffer(Data^, DataSize);
   ssData.Write(Data^, DataSize);
   ssData.Position:= 0;
   Result:= ssData.DataString;
 Finally
   FreeMem(Data);
   ssData.Free;
 End;
End;

//입력 Enter 누를 시
procedure Tkloikm.ChatMsgKeyPress(Sender: TObject; var Key: Char);
var
  stTemp : String;
begin
  If Key =#13 then Begin
  //key:=#0;    //소리가 안남 null키로 바꾸는 것
   IdTCPClient1.WriteLn(Format('talk;%s#%s;%s',[UserId.Text,IntToStr(rand3),ChatMsg.Text]));
  ChatMsg.Text:='';  //전송하고 초기화 하기.
  End;
end;


procedure Tkloikm.Timer1Timer(Sender: TObject);
var
  stTemp : String;

 begin
  If IdTCPClient1.Connected = False then Exit;

    stTemp:=ReceiveText(IdTCPClient1);
    if stTemp <> '' then ChatMemo.Lines.Add(stTemp);
  end;
//귓속말 보내기
procedure Tkloikm.IdTCPClient1Connected(Sender: TObject);

begin
    ChatMemo.Lines.Add('연결 되었습니다');
    cnt := cnt+1;

end;

procedure Tkloikm.ExitBtnClick(Sender: TObject);
begin

   IdTCPClient1.WriteLn(Format('%s#%s님이 나갔습니다.',[UserId.Text,IntToStr(rand3)]));
   Close;
end;

procedure Tkloikm.IdTCPClient1Disconnected(Sender: TObject);
begin
 if IdTCPClient1.Connected = False then
  begin
    ShowMessage('서버에서 접속을 끊었습니다.');
    Close;
  end;

end;


procedure Tkloikm.IdTCPClient1WorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin

  IdTCPClient1.WriteLn(Format('%s님이 나갔습니다.',[UserId.Text]));
  Close;
end;

procedure Tkloikm.ChatMemoKeyPress(Sender: TObject; var Key: Char);
begin
    Key := #0;
end;

procedure Tkloikm.UserIdKeyPress(Sender: TObject; var Key: Char);
begin
     if IdTCPClient1.Connected then
     begin
      Key:=#0;
     end;

     //아이디 입력 6글자로 제한
     if Length(UserId.Text) > 5 then
     begin
      Key:=#0;
     end;

end;

end.
