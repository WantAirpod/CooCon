unit ChatClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  StdCtrls, ExtCtrls, IdGlobal, IdAntiFreezeBase, IdAntiFreeze,
  IdThreadMgr, IdThreadMgrDefault;

type
  Tkloikm = class(TForm)
    ChatMsg: TEdit;
    Button1: TButton;
    UserId: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    ChatMemo: TMemo;
    Timer1: TTimer;
    IdTCPClient1: TIdTCPClient;
    IdAntiFreeze1: TIdAntiFreeze;
    IdThreadMgrDefault1: TIdThreadMgrDefault;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ChatMsgKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject );
    procedure IdTCPClient1Disconnected(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  kloikm: Tkloikm;

implementation



{$R *.dfm}

//접속 버튼
procedure Tkloikm.Button1Click(Sender: TObject);
var
a : array[0..10] of String;
i : Integer;
rand : Integer;
begin

  //rand:=random(i);
  //ShowMessage(inttostr(rand));
  if(UserId.Text='')
   then
   begin
   ShowMessage('아이디를 입력하세요');
   exit;
   end
   else
    begin
     IdTCPClient1.Connect();
     //IdTCPClient1.WriteLn(Format('%s#%s님이 로그인 하셨습니다.',[UserId.Text,inttostr(rand)]));
     IdTCPClient1.WriteLn(Format('%s님이 로그인 하셨습니다.',[UserId.Text]));
     Button1.Destroy;
    end;
 // rand:=0;
 // rand:=random(3000);
  //rand:=random
  //UserListMemo.Lines.add(Edit2.Text);
  //for i := 1 to 10 do
  //begin
  //if Edit2.Text <> '' then a[i] := Edit2.Text;
  //if a[i]:= then ShowMessage('아이디 값이 같아요');
  //end;

//    IdTCPClient1.WriteLn('%s , %s님이 로그인 하셨습니다.',[UserId.Text],[inttostr(rand)]);


end;
////////////////////////////////////////////////////////
Function  ReceiveText(IdTCPClient:TIdTCPClient):String;
Var
 Data : Pointer;
 DataSize : Integer;
 ssData : TStringStream;
Begin
//Data:=  Pointer( IdTCPClient.ReadLn());
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
   IdTCPClient1.WriteLn(Format('talk;%s;%s',[UserId.Text, ChatMsg.Text]));

  //IdTCPClient1.WriteLn(Edit1.Text);
  //aaa.Lines.Add(Edit1.Text);
  ChatMsg.Text:='';  //전송하고 초기화 하기.
  End;
end;


procedure Tkloikm.Timer1Timer(Sender: TObject);
var
  stTemp : String;

 begin
  If IdTCPClient1.Connected = False then Exit;

  //IdTCPClient1.WriteLn(Format('talk;%s;%s',[Edit2.Text, Edit1.Text]));
 // stTemp:= IdTCPClient1.ReadLn();
    stTemp:=ReceiveText(IdTCPClient1);
  //    stTemp:=IdTCPClient1.ReadLn(Format('talk;%s' , [Edit2.Text]));
  //IdTCPClient1.WriteLn(Format('%s;%s',[Edit2.Text,Edit3.Text, Edit1.Text]));
    //if Edit1.Text <> '' then abc.Lines.Add(Edit1.Text);
    //abc.Lines.Add(stTemp);
    if stTemp <> '' then ChatMemo.Lines.Add(stTemp);
//  If stTemp = null then abc.Lines.Add('ㅎㅇ')

  end;
//귓속말 보내기
procedure Tkloikm.Button2Click(Sender: TObject);
begin
 IdTCPClient1.WriteLn(Format('Msg;%s;%s;%s',[UserId.Text,Edit3.Text, ChatMsg.Text]));
end;
procedure Tkloikm.IdTCPClient1Connected(Sender: TObject);
begin
    ChatMemo.Lines.Add('연결 되었습니다');

end;

procedure Tkloikm.IdTCPClient1Disconnected(Sender: TObject);

begin
    ChatMemo.Lines.Add('연결이 끊겼습니다.');
    ShowMessage('연결이 끊겼습니다');
    exit;
end;

 
end.
