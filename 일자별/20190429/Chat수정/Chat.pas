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
    EndBtn: TButton;
    Label3: TLabel;
    Label4: TLabel;
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
    procedure IdTCPServer1Connect(AThread: TIdPeerThread);
    procedure IdTCPServer1Disconnect(AThread: TIdPeerThread);
    procedure EndBtnClick(Sender: TObject);
    procedure ChatMemoKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
//    Procedure doLogin(AThread: TIdPeerThread; Strings:TStringList);

//    Procedure doTalk(AThread: TIdPeerThread; Strings:TStringList);
//    Procedure doMsg(AThread: TIdPeerThread; Strings:TStringList);
  public
    { Public declarations }
    //procedure BroadCast(BroadMsg:string);
    //procedure BroadCastExceptOne(BroadMsg:string;ExceptId:string);
  end;

var
  Form1: TForm1;
  UserList :array[0..100] of String;  //������ ���̵� ��� �迭 ����
  stlTemp : TStringList;
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
 List : TList;  //ä���� ���� ��ü
 count: Integer;   //�����ο��� ���� ����
 stTemp :String;  //ä��
 Loop : Integer;
 stReceivedText : String;  //client���� �޾ƿ� ä��
 IdPeerThread : TIdPeerThread; //������
 ii : Integer;
begin
 stlTemp:=TStringList.Create;
 stlTemp.Text:= StringReplace(stTemp, ':' , #13 , [rfReplaceAll] );  // :�� #13���� ��ȯ
 stReceivedText:= AThread.Connection.ReadLn('',1);   // ReadLn ª�� ó�� ��-> �ٷιٷ� �������� �޾ƿ�
  If stReceivedText = '' then exit;    //�޾ƿ��� ���� ���ٸ� exit
 //ä�� ó��
 stTemp:= StringReplace(stReceivedText, '#13' , ';' , [rfReplaceAll] ); //�ܼ��� �о���� ���͸� �ν� ����
 ChatMemo.Lines.Add(stTemp);//ä�� ���� �� ���� �޸� �ۼ�
 List:= IdTCPServer1.Threads.LockList;  //����� ��׸鼭 ����� Tlist Ÿ������ ��ȯ�Ͽ� ��.  LockList�� ��� ���¿��� Ŭ���̾�Ʈ�� ������ ��� ������ �ش� ������ �����ϴ� ���� ������.
 Try
  For Loop:= 0 to List.Count-1 do Begin      //Ŭ���̾�Ʈ ���� �� ��ŭ �ݺ����ϸ鼭 ��� ����� Ŭ���̾�Ʈ�� �޽����� ����
     IdPeerThread:= TIdPeerThread(List.Items[Loop]);
     Try
       IdPeerThread.Connection.WriteLn(stReceivedText);    //Client���� �ѷ��ִ� �ڵ�
     Except
       IdPeerThread.Stop;
     End;
   End;
 Finally
   IdTCPServer1.Threads.UnlockList;  //�� ����
 End;
//�α��� ó��
if (pos('�α���',stReceivedText) <> 0) And (pos('talk',stReceivedText)=0) then    //Text���� �α��� �̶�� �ܾ ã����...
begin
 if UserList[0]='' then
 UserList[0]:=stReceivedText
 else
 for i:=0 to List.Count-1 do begin
  if UserList[i]=stReceivedText then
  begin
   // ShowMessage('�̹� �����ϴ� ���̵��Դϴ�');
    Exit;
  end
  else
   begin
    UserList[List.Count-1]:=stReceivedText;
  end;
 end;



 // if UserList[1] <> '' then
 // begin
 // ShowMessage(UserList[0]);
 //  ShowMessage(UserList[1]);
 // end;
  //if UserList[1] <> '' then
  //begin
 // ShowMessage(UserList[1]);
 // end;



 //Temp:= AThread.Connection.ReadLn; //�ܼ��� �о���� ����
 //���⼭ ������ �ϸ� �ȴ�.!!!!
 //�� ���� �޸��� ������ �� �о ���ݾ��� �ؽ�Ʈ�� �ƿ� ������ �ؽ�Ʈ�� ������ ���� ����
 //������ �α��� �ܾ� �����ִ� �Ϳ��� �б� �¿��
 //�� ������ �޸� ���ٿ� ������ �ؽ�Ʈ ������ ���� ���� !
 //stlTemp:=TStringList.Create;
 //stlTemp.Text:= StringReplace(stTemp, ':' , #13 , [rfReplaceAll] );
 //ii:=pos('Log',stTemp);   // log��� ���� ������ �� �α��� ���̵� ó�� !!
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
 //�α��� ó��
 //stlTemp:=TStringList.Create;
 // ; ã�Ƽ� ��� #13���� �ٲٱ� #13=Enter
 //stlTemp.Text:= StringReplace(stTemp, ':' , #13 , [rfReplaceAll] ) ;
 //�ҹ��� ó��
// If LowerCase(stlTemp.Strings[0]) = 'login' then doLogin(AThread,stlTemp)
// else If LowerCase(stlTemp.Strings[0]) = 'talk' then doTalk(AThread,stlTemp)
 //1:1�޽��� ó��
// else If LowerCase(stlTemp.Strings[0]) = 'msg' then doMsg(AThread,stlTemp)
end;
end;

//����
procedure TForm1.IdTCPServer1Connect(AThread: TIdPeerThread);
var
 Client : TClinetInfo;
begin
 Client := TClinetInfo.Create;
 AThread.Data:= Client;
end;
//���� ����
procedure TForm1.IdTCPServer1Disconnect(AThread: TIdPeerThread);
var
 Client : TClinetInfo;
 stTemp :String;
 stReceivedText : String;
 IdPeerThread : TIdPeerThread;

begin
 stReceivedText:= AThread.Connection.ReadLn('', 5);
 If stReceivedText = '' then exit;

 Client:=Pointer(AThread.Data);
 //���� Nil �̸� exit���ش�.
 If Client = Nil then Exit;

 AThread.Data:=Nil;
 //� client�� ������ �ٸ�����ڿ���  �����ٰ� �˷��ִ� ��
 //IdTCPServer1.SendToOhter...9�� 6��
 Client.Free; //�Ҵ� �� ����
end;
//���� ��ư
procedure TForm1.EndBtnClick(Sender: TObject);

 begin
 //IdTCPServer1.Threads.Destroy;
 IdTCPServer1.Threads.Remove(IdTCPServer1);
 ShowMessage('������ ���� �Ǿ����ϴ�.');
 ChatMemo.Lines.Add('������ ������ϴ�.');
 Close;
 end;

procedure TForm1.ChatMemoKeyPress(Sender: TObject; var Key: Char);
begin
Key := #0;
end;

end.
{ �α��� �κ� �б�
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
    ShowMessage('�̹� �����ϴ� ���̵��Դϴ�');
    IdTCPServer1.Threads.Remove(IdTCPServer1);
    Exit;
    end
   end
  Finally
 end;
end;  }
{��ȭ �б�
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
 List:= IdTCPServer1.Threads.LockList; //���ο����� ���� ���ӵ� Ŭ���̾�Ʈ ���ؼ��� ����� �޾ƿ��鼭 �ش� ����� �ᰡ��.
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

{ 1:1 ä�� �б�
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
   //Nil�� �� �������ֱ�
    if Client = Nil then Continue;
   //Ư���� ����ڰ� �ƴϸ� Loop�� ����
    if Client.UserID <> Strings.Strings[2] then Continue;
   //Ư�� ������� �������� ��� Msg ����

   TIdPeerThread(List.Items[Loop]).Connection.Writeln(stTemp);
  end;
 Finally
  IdTCPServer1.Threads.UnlockList;
 end;
end;
}

