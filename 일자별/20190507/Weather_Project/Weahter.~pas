unit Weahter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StdCtrls,WinInet,HTTPApp, OleCtrls, SHDocVw;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    WebBrowser1: TWebBrowser;
    Label2: TLabel;
    Button1: TButton;
    ClearBtn: TButton;
    function GetWebBrowserHTML(Url : PChar):String;
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

function TForm1.GetWebBrowserHTML(Url: PChar): String; //URL을 매개변수로 받음
var
  hNet  : HINTERNET;
  hURL  : HINTERNET;
  StrBuf : UTF8String;
  Buffer : array [0..2047]of Char;
  BytesRead : DWORD;  //읽는 데이터의 크기
begin
  Result := '';
  hNet  := InternetOpen('User Agent',INTERNET_OPEN_TYPE_PRECONFIG,nil,nil,0);
 {[InternetOpen : 인터넷 연결 환경 구현하는 함수] 참고 : https://docs.microsoft.com/en-us/windows/desktop/api/wininet/nf-wininet-internetopena
  2.INTERNET_OPEN_TYPE_PRECONFIG : 인터넷 연결 방식->레지스트리에서 프록시 또는 직접 구성을 검색합니다.
  3,4.nil -> 프록시를 사용할 때 지정 
  5.네트워크 연결 방식...->0(방식 지정 없음)}
  if Assigned(hNet) then begin
    try
    hURL := InternetOpenUrl(hNet,Url,nil,0,INTERNET_FLAG_RELOAD,0);
    {[InternetOpenUrl function] 참고 : https://docs.microsoft.com/en-us/windows/desktop/api/wininet/nf-wininet-internetopenurla
     <FTP 또는 HTTP URL로 지정된 리소스를 엽니다.>
     1.현재 인터넷 세션의 핸들입니다 = hNet
     2.읽기 시작하는 URL을 지정 =Url
     3.HTTP 서버에 보낼 헤더를 지정  -> nil
     4.TCHAR 의 추가 헤더 크기 -> 0
     5.INTERNET_FLAG_RELOAD :	캐시가 아닌 원본 서버에서 요청 된 파일, 개체 또는 디렉토리 목록을 강제로 다운로드합니다.
     6.반환 된 핸들과 함께 전달되는 응용 프로그램 정의 값을 모든 콜백 함수에 지정하는 변수에 대한 포인터입니다. -> 0 }
      if Assigned(hURL) then
      begin
       try
         repeat
            InternetReadFile(hURL,@Buffer, SizeOf(Buffer), BytesRead);
            {[InternetReadFile :InternetOpenUrl , FtpOpenFile 또는 HttpOpenRequest 함수에 의해 열린 핸들에서 데이터를 읽습니다.] 참고 : https://docs.microsoft.com/en-us/windows/desktop/api/wininet/nf-wininet-internetreadfile
          1.InternetOpenUrl , FtpOpenFile 또는 HttpOpenRequest에 대한 이전 호출에서 반환 된 핸들 입니다. = hURL
          2.데이터를받는 버퍼의 포인터. ->@Buffer
          3.읽는 바이트 수 -> SizeOf(Buffer)
          4.읽은 바이트 수를받는 변수의 포인터 ->BytesRead
            }
            SetString(StrBuf,PChar(@Buffer[0]),BytesRead);
            Result := Result + StrBuf;
         until BytesRead = 0;
        finally
          InternetCloseHandle(hURL) ;
          //단일 인터넷 핸들을 닫습니다.-->nURL 닫음
        end; //try2 end
      end
      else begin
        raise Exception.CreateFmt('Cannot Open URL %s', [Url]);
   end;
    finally
      InternetCloseHandle(hNet);
      //단일 인터넷 핸들을 닫습니다. -> hNet 닫음
    end; //try1 end
  end
  else begin
    raise Exception.Create('Unable to Initialize WinInet');

  end;
end;

procedure TForm1.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
Key := #0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   WebBrowser1.Navigate('http://weather.naver.com');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Html : UTF8String;
  startline : Integer;
  endline : integer;
  src :string;
begin
  if RadioButton1.Checked then
  begin
    Memo1.Clear;
    Html := UTF8Decode(GetWebBrowserHTML('http://weather.naver.com'));
    //Html := UTF8Decode(GetWebBrowserHTML(PChar(InputEdit.Text)));  만약 사이트 입력 시..
    startline := AnsiPos('<html',Html);
    //ShowMessage(IntToStr(startline));
    endline := AnsiPos('</html>',Html);
    //ShowMessage(IntToStr(Finalline));
    Html := Copy(Html,startline, endline - startline);
    Memo1.Text := Html;
  end
  else if RadioButton2.Checked then
  begin
   Memo1.Clear;
   src := WebBrowser1.OleObject.document.documentElement.outerHtml;
   //WebBrowser component 연결 방식 
   Memo1.Lines.Add(src);
  end;
end;

procedure TForm1.ClearBtnClick(Sender: TObject);
begin
 Memo1.Clear;
end;

end.
