unit Chat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdThreadMgr, IdThreadMgrDefault, IdBaseComponent, IdComponent,
  IdTCPServer, StdCtrls ;

type

  PClinetRecord = ^ClientRecord;
  ClientRecord = record
   UserId:String[100];
  // UserNick:String[100];
   Error : integer;
  end;

  TForm1 = class(TForm)
    IdTCPServer1: TIdTCPServer;
    IdThreadMgrDefault1: TIdThreadMgrDefault;
    ChatMemo: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;

    //...
    ServerPort: TEdit;
    Edit1: TEdit;
    EndBtn: TButton;
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
    procedure IdTCPServer1Connect(AThread: TIdPeerThread);
    procedure IdTCPServer1Disconnect(AThread: TIdPeerThread);
    procedure EndBtnClick(Sender: TObject);

  private
    { Private declarations }
    Procedure doLogin(AThread: TIdPeerThread; Strings:TStringList);

    Procedure doTalk(AThread: TIdPeerThread; Strings:TStringList);
    Procedure doMsg(AThread: TIdPeerThread; Strings:TStringList);
  public
    { Public declarations }
    //procedure BroadCast(BroadMsg:string);
    //procedure BroadCastExceptOne(BroadMsg:string;ExceptId:string);
  end;

var
  Form1: TForm1;
  UserList :array[0..100] of String;
implementation
type
  TClinetInfo= class(TObject)
  public
    UserID :String;
  end;
{$R *.dfm}
procedure TForm1.IdTCPServer1Execute(AThread: TIdPeerThread);
Var
 i : Integer;
 List : TList;  //채팅을 담을 객체
 count: Integer;   //참가인원을 담을 변수
 stTemp :String;  //채팅
 Loop : Integer;
 stReceivedText : String;  //client에서 받아온 채팅
 IdPeerThread : TIdPeerThread; //스레드
 stlTemp : TStringList;
 ii : Integer;
begin


 stlTemp:=TStringList.Create;
 stReceivedText:= AThread.Connection.ReadLn('',1);   // ReadLn 짧게 처리 함-> 바로바로 서버에서 받아옴
 If stReceivedText = '' then Exit;
 if pos('로그인',stReceivedText) <> 0 then
 ShowMessage('오긴왔어');

 for i:=0 to List.Count-2 do begin
  if UserList[i]=stReceivedText then
  begin
    ShowMessage('이미 존재하는 아이디입니다');
    Exit;
  end
  else
   begin
    UserList[List.Count-1]:=stReceivedText;
    stTemp:= StringReplace(stReceivedText, '#13' , ';' , [rfReplaceAll] ); //단순힌 읽어오면 엔터를 인식 못함
    ChatMemo.Lines.Add(stTemp);//채팅 쓰는 것 서버 메모에 작성
    List:= IdTCPServer1.Threads.LockList;  //목록을 잠그면서 목록을 Tlist 타입으로 반환하여 줌.  LockList로 잠긴 상태에서 클라이언트가 접속을 끊어도 서버는 해당 연결을 삭제하는 것을 유보함.

     Try
      For Loop:= 0 to List.Count-1 do Begin      //클라이언트 연결 수 만큼 반복을하면서 모든 연결된 클라이언트에 메시지를 전송
      IdPeerThread:= TIdPeerThread(List.Items[Loop]);
     Try
       IdPeerThread.Connection.WriteLn(stReceivedText);
     Except
       IdPeerThread.Stop;
     End;
   End;
 Finally
   IdTCPServer1.Threads.UnlockList;
 End;
end;

 if pos('talk',stReceivedText) <> 0 then
  begin
   stTemp:= StringReplace(stReceivedText, '#13' , ';' , [rfReplaceAll] ); //단순힌 읽어오면 엔터를 인식 못함
    ChatMemo.Lines.Add(stTemp);//채팅 쓰는 것 서버 메모에 작성
    List:= IdTCPServer1.Threads.LockList;  //목록을 잠그면서 목록을 Tlist 타입으로 반환하여 줌.  LockList로 잠긴 상태에서 클라이언트가 접속을 끊어도 서버는 해당 연결을 삭제하는 것을 유보함.
     Try
      For Loop:= 0 to List.Count-1 do Begin      //클라이언트 연결 수 만큼 반복을하면서 모든 연결된 클라이언트에 메시지를 전송
      IdPeerThread:= TIdPeerThread(List.Items[Loop]);
     Try
       IdPeerThread.Connection.WriteLn(stReceivedText);
     Except
       IdPeerThread.Stop;
     End;
   End;
 Finally
   IdTCPServer1.Threads.UnlockList;
 End;
 end;


end;







 //채팅 처리

 stTemp:= StringReplace(stReceivedText, '#13' , ';' , [rfReplaceAll] ); //단순힌 읽어오면 엔터를 인식 못함
 ChatMemo.Lines.Add(stTemp);//채팅 쓰는 것 서버 메모에 작성
 List:= IdTCPServer1.Threads.LockList;  //목록을 잠그면서 목록을 Tlist 타입으로 반환하여 줌.  LockList로 잠긴 상태에서 클라이언트가 접속을 끊어도 서버는 해당 연결을 삭제하는 것을 유보함.
 Try
  For Loop:= 0 to List.Count-1 do Begin      //클라이언트 연결 수 만큼 반복을하면서 모든 연결된 클라이언트에 메시지를 전송
     IdPeerThread:= TIdPeerThread(List.Items[Loop]);
     Try
       IdPeerThread.Connection.WriteLn(stReceivedText);
     Except
       IdPeerThread.Stop;
     End;
   End;
 Finally
   IdTCPServer1.Threads.UnlockList;
 End;



 // if UserList[1] <> '' then
 // begin
 // ShowMessage(UserList[0]);
 //  ShowMessage(UserList[1]);
 // end;
  //if UserList[1] <> '' then
  //begin
 // ShowMessage(UserList[1]);
 // end;



 //Temp:= AThread.Connection.ReadLn; //단순히 읽어오면 에러
 //여기서 마무리 하면 된다.!!!!
 //내 생각 메모의 전줄을 쭉 읽어서 지금쓰는 텍스트랑 아예 동일한 텍스트가 있으면 접속 차단
 //그전에 로그인 단어 쓰여있는 것에서 분기 태우고
 //그 다음에 메모 전줄에 동일한 텍스트 있으면 접속 차단 !
 //stlTemp:=TStringList.Create;
 //stlTemp.Text:= StringReplace(stTemp, ':' , #13 , [rfReplaceAll] );
 //ii:=pos('Log',stTemp);   // log라는 것이 나왔을 때 로그인 아이디 처리 !!
 //if ii <> 0 then
 //stlTemp.Add(stTemp);
 // For Loop:= 0 to List.Count-1 do Begin
 // if stTemp(Loop) = stTemp(Loop+1)




// List:=IdTCPServer1.Threads.LockList;

// stReceivedText:=AThread.Connection.ReadLn('',5);
 //if stReceivedText ='' then Exit;

 //try
 // for Loop:= 0 to List.Count-1 do Begin
 //   IdPeerThread:= TIdPeerThread(List.Items[Loop]);
 // end;
// Finally
 // IdTCPServer1.Threads.UnlockList;
   // try
     //IdPeerThread.Connection.WriteLn(stReceivedText);
    //Except
    // IdPeerThread.Stop;
// stTemp:= AThread.Connection.ReadLn;
// Memo1.Lines.Add(stTemp);
 //로그인 처리
 //stlTemp:=TStringList.Create;
 // ; 찾아서 모두 #13으로 바꾸기 #13=Enter
 //stlTemp.Text:= StringReplace(stTemp, ':' , #13 , [rfReplaceAll] ) ;
 //소문자 처리
// If LowerCase(stlTemp.Strings[0]) = 'login' then doLogin(AThread,stlTemp)
// else If LowerCase(stlTemp.Strings[0]) = 'talk' then doTalk(AThread,stlTemp)
 //1:1메시지 처리
// else If LowerCase(stlTemp.Strings[0]) = 'msg' then doMsg(AThread,stlTemp)
end;
 procedure TForm1.doLogin(AThread: TIdPeerThread;Strings: TStringList);
var
 Client : TClinetInfo;
 Packet,PacketDetail : TStringList;
 i,j : integer;
 tmpClientData: PClinetRecord;
begin

 Client := Pointer(AThread.Data);
 Client.UserID:=Strings.Strings[1];
 Packet := TStringList.Create;
 PacketDetail := TStringList.Create;
 try
  Packet.Clear;
  for i:=0 to Packet.Count-1 do
  begin
  if(tmpClientData^.UserId = PacketDetail[1]) then
    begin
    ShowMessage('이미 존재하는 아이디입니다');
    Exit;
    end
   end
  Finally
 end;
end;
procedure TForm1.doTalk(AThread: TIdPeerThread; Strings: TStringList);
var
 List : TList;
 Loop : Integer;
 stTemp :String;
 stReceivedText : String;
 IdPeerThread : TIdPeerThread;

begin
stReceivedText:= AThread.Connection.ReadLn('', 5);
If stReceivedText = '' then Exit;





 stTemp:= StringReplace(Strings.Text, '#13' , ';' , [rfReplaceAll] ) ;
 List:= IdTCPServer1.Threads.LockList; //라인에서는 현재 접속된 클라이언트 컨넥션의 목록을 받아오면서 해당 목록을 잠가둠.
 try
  For Loop :=0 to List.Count-1 do Begin
  IdPeerThread :=  TIdPeerThread(List.Items[Loop]);
  try
   IdPeerThread.Connection.WriteLn(stReceivedText);
  Except
   IdPeerThread.Stop;
  end;
   //TIdPeerThread(List.Items[Loop]).Connection.Writeln(stTemp);
  end;
 Finally
  IdTCPServer1.Threads.UnlockList;
 end;
end;

//연결
procedure TForm1.IdTCPServer1Connect(AThread: TIdPeerThread);
var
 Client : TClinetInfo;
begin
 Client := TClinetInfo.Create;
 AThread.Data:= Client;
end;
//연결 종료
procedure TForm1.IdTCPServer1Disconnect(AThread: TIdPeerThread);
var
 Client : TClinetInfo;
begin
 Client:=Pointer(AThread.Data);
 //값이 Nil 이면 exit해준다.
 If Client = Nil then Exit;

 AThread.Data:=Nil;


 //어떤 client가 나가면 다른사용자에게  나갔다고 알려주는 것
 //IdTCPServer1.SendToOhter...9분 6초
 Client.Free; //할당 후 해지
end;

procedure TForm1.doMsg(AThread: TIdPeerThread; Strings: TStringList);
var
 List : TList;
 Loop : Integer;
 stTemp :String;
 Client : TClinetInfo;
begin
 stTemp:= StringReplace(Strings.Text, '#13' , ';' , [rfReplaceAll] ) ;
 List:= IdTCPServer1.Threads.LockList;
 try
  For Loop :=0 to List.Count-1 do Begin
    Client:=Pointer(TIdPeerThread(List.Items[Loop]).Data);
   //Nil일 때 무시해주기
    if Client = Nil then Continue;
   //특정한 사용자가 아니면 Loop를 무시
    if Client.UserID <> Strings.Strings[2] then Continue;
   //특정 사용자의 스레드인 경우 Msg 전송

   TIdPeerThread(List.Items[Loop]).Connection.Writeln(stTemp);
  end;
 Finally
  IdTCPServer1.Threads.UnlockList;
 end;
end;

procedure TForm1.EndBtnClick(Sender: TObject);

 begin
 //IdTCPServer1.Threads.Destroy;
 IdTCPServer1.Threads.Remove(IdTCPServer1);
 ShowMessage('접속이 종료 되었습니다.');
 ChatMemo.Lines.Add('연결이 끊겼습니다.');

 end;

end.
