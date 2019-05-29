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

function TForm1.GetWebBrowserHTML(Url: PChar): String; //URL�� �Ű������� ����
var
  hNet  : HINTERNET;
  hURL  : HINTERNET;
  StrBuf : UTF8String;
  Buffer : array [0..2047]of Char;
  BytesRead : DWORD;  //�д� �������� ũ��
begin
  Result := '';
  hNet  := InternetOpen('User Agent',INTERNET_OPEN_TYPE_PRECONFIG,nil,nil,0);
 {[InternetOpen : ���ͳ� ���� ȯ�� �����ϴ� �Լ�] ���� : https://docs.microsoft.com/en-us/windows/desktop/api/wininet/nf-wininet-internetopena
  2.INTERNET_OPEN_TYPE_PRECONFIG : ���ͳ� ���� ���->������Ʈ������ ���Ͻ� �Ǵ� ���� ������ �˻��մϴ�.
  3,4.nil -> ���Ͻø� ����� �� ���� 
  5.��Ʈ��ũ ���� ���...->0(��� ���� ����)}
  if Assigned(hNet) then begin
    try
    hURL := InternetOpenUrl(hNet,Url,nil,0,INTERNET_FLAG_RELOAD,0);
    {[InternetOpenUrl function] ���� : https://docs.microsoft.com/en-us/windows/desktop/api/wininet/nf-wininet-internetopenurla
     <FTP �Ǵ� HTTP URL�� ������ ���ҽ��� ���ϴ�.>
     1.���� ���ͳ� ������ �ڵ��Դϴ� = hNet
     2.�б� �����ϴ� URL�� ���� =Url
     3.HTTP ������ ���� ����� ����  -> nil
     4.TCHAR �� �߰� ��� ũ�� -> 0
     5.INTERNET_FLAG_RELOAD :	ĳ�ð� �ƴ� ���� �������� ��û �� ����, ��ü �Ǵ� ���丮 ����� ������ �ٿ�ε��մϴ�.
     6.��ȯ �� �ڵ�� �Բ� ���޵Ǵ� ���� ���α׷� ���� ���� ��� �ݹ� �Լ��� �����ϴ� ������ ���� �������Դϴ�. -> 0 }
      if Assigned(hURL) then
      begin
       try
         repeat
            InternetReadFile(hURL,@Buffer, SizeOf(Buffer), BytesRead);
            {[InternetReadFile :InternetOpenUrl , FtpOpenFile �Ǵ� HttpOpenRequest �Լ��� ���� ���� �ڵ鿡�� �����͸� �н��ϴ�.] ���� : https://docs.microsoft.com/en-us/windows/desktop/api/wininet/nf-wininet-internetreadfile
          1.InternetOpenUrl , FtpOpenFile �Ǵ� HttpOpenRequest�� ���� ���� ȣ�⿡�� ��ȯ �� �ڵ� �Դϴ�. = hURL
          2.�����͸��޴� ������ ������. ->@Buffer
          3.�д� ����Ʈ �� -> SizeOf(Buffer)
          4.���� ����Ʈ �����޴� ������ ������ ->BytesRead
            }
            SetString(StrBuf,PChar(@Buffer[0]),BytesRead);
            Result := Result + StrBuf;
         until BytesRead = 0;
        finally
          InternetCloseHandle(hURL) ;
          //���� ���ͳ� �ڵ��� �ݽ��ϴ�.-->nURL ����
        end; //try2 end
      end
      else begin
        raise Exception.CreateFmt('Cannot Open URL %s', [Url]);
   end;
    finally
      InternetCloseHandle(hNet);
      //���� ���ͳ� �ڵ��� �ݽ��ϴ�. -> hNet ����
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
    //Html := UTF8Decode(GetWebBrowserHTML(PChar(InputEdit.Text)));  ���� ����Ʈ �Է� ��..
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
   //WebBrowser component ���� ��� 
   Memo1.Lines.Add(src);
  end;
end;

procedure TForm1.ClearBtnClick(Sender: TObject);
begin
 Memo1.Clear;
end;

end.
