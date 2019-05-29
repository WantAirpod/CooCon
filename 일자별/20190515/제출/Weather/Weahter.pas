unit Weahter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StdCtrls,WinInet,HTTPApp, OleCtrls, SHDocVw,uJSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,JYJSON,
  Grids;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    WebBrowser1: TWebBrowser;
    Label2: TLabel;
    Button1: TButton;
    ComboBox1: TComboBox;
    IdHTTP1: TIdHTTP;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label3: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label4: TLabel;
    lbl3: TLabel;
    edt8: TEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    edt7: TEdit;
    Memo1: TMemo;
    WebBrowser2: TWebBrowser;
    function GetWebBrowserHTML(Url : PChar):String;
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure edt8KeyPress(Sender: TObject; var Key: Char);
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
    procedure edt2KeyPress(Sender: TObject; var Key: Char);
    procedure edt3KeyPress(Sender: TObject; var Key: Char);
    procedure edt4KeyPress(Sender: TObject; var Key: Char);
    procedure edt7KeyPress(Sender: TObject; var Key: Char);
    procedure edt6KeyPress(Sender: TObject; var Key: Char);
    procedure edt5KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox3KeyPress(Sender: TObject; var Key: Char);
    procedure TextBtnClick(Sender: TObject);



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
{�������� �Լ�}
function WetrText(Html : UTF8String): String;
var
  startline,endline : Integer;
begin
  startline := AnsiPos('"wetrTxt',Html);
  endline := AnsiPos(']});',Html);
  Html := Copy( Html,startline+Length('"wetrTxt')+4,4);
  Result := Html;
end;
{��}
function Comp(Html : UTF8String): String;
var
  startline,endline : Integer;
begin
  startline := AnsiPos('"ytmpr',Html);
  endline := AnsiPos(']});',Html);
  Html := Copy( Html,startline+Length('"ytmpr')+3,3);
  if Pos('-',Html) =0 then
  begin
  Result := '+' + Html;
  end;
end;
{������}
function TmprNow(Html : UTF8String): String;
var
  startline,endline : Integer;
begin
  startline := AnsiPos('"tmpr',Html);
  endline := AnsiPos(']});',Html);
  Html := Copy( Html,startline+Length('"tmpr')+3,5); 
  Result := Html; 
end;
function rainAmt(Html : UTF8String): String;
var
  startline,endline : Integer;
begin
  startline := AnsiPos('"amRainProbability',Html);
  endline := AnsiPos(']});',Html);
  Html := Copy( Html,startline+Length('"amRainProbability')+3,2);
  Result := Html;
end;
function WetrTmText(Html : UTF8String): String;
var
  startline,endline : Integer;
begin
  startline := AnsiPos('"amWeatherText',Html);
  endline := AnsiPos(']});',Html);
  Html := Copy( Html,startline+Length('"amWeatherText')+4,4);
  Result := Html;
end;
function WetrTm(Html : UTF8String): String;
var
  startline,endline : Integer;
begin
  startline := AnsiPos('"pmTemperature',Html);
  endline := AnsiPos(']});',Html);
  Html := Copy( Html,startline+Length('"pmTemperature')+2,6);
  Result := Html;
end;
function rainAmtTm(Html : UTF8String): String;
var
 startline,endline : Integer;
begin
  startline := AnsiPos('"pmRainProbability',Html);
  endline := AnsiPos(']});',Html);
  Html := Copy( Html,startline+Length('"pmRainProbability')+3,2);
  Result := Html; 
end;


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

procedure TForm1.Button1Click(Sender: TObject);
var
  Html,Html2 : UTF8String;
  startline : Integer;
  endline : integer;
  src :string;
  jobj:TJSONObject;
  subjObj: TJSONObject;
  arrjObj: TJSONArray;
  i, t: integer;
begin

  if ComboBox3.ItemIndex = -1 then
    begin
    ShowMessage('���� �Է��Ͻÿ�');
    edt8.text:= ' ' ;
  end

  else if ComboBox3.ItemIndex <> -1 then
    begin
    edt8.Text:=ComboBox1.text+ ' ' + ComboBox2.Text+ ' ' + ComboBox3.Text ;
  end ;
 //��� �ʱ�ȭ
    edt1.Clear;
    edt2.Clear;
    edt3.Clear;
    edt4.Clear;
    edt5.Clear;
    edt6.Clear;
    edt7.Clear;
// ���� ���� �Է�
   {*****************************************************************************************************************************************************************}
   {*****************************************************************************************************************************************************************}
   {******************************************************************************WININET****************************************************************************}
   {*****************************************************************************************************************************************************************}
   {*****************************************************************************************************************************************************************}
  if RadioButton1.Checked then
  begin
    case ComboBox3.ItemIndex of
    0 :
      begin
      {Json �Ľ� �ð���}
      Memo1.clear;
      Html2:= UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305101'));
      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');

      for I := 0 to arrjObj.length - 1 do begin
        subjObj := TJSONObject.create(arrjObj.getString(I));
        Memo1.Lines.Add(
          Format('���� :%s | �ð� : %s:00 | ��� : %s��|   ����Ȯ�� : %s �ۼ�Ʈ| ���� : %s �ۼ�Ʈ|',
            [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
            subjObj.getString('rainProb'),subjObj.getString('humd')]));
        subjObj.Free;
      end;
      jObj.Free;
      {���� ����text}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt1.Text:=WetrText(Html);
      {��������}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt2.Text:=Comp(Html);
      {���}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt3.Text:=TmprNow(Html);
      {���� Ȯ��}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt4.Text:=rainAmt(Html);
      //����
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt7.Text:=WetrTmText(Html);
      {���ϳ���}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt6.Text:=WetrTm(Html);
      {���� ����Ȯ��}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt5.Text:=rainAmtTm(Html);
      end;
    1:
      begin
      {Json �Ľ� �ð���}
      Memo1.clear;
      Html2:= UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305534'));
      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');

      for I := 0 to arrjObj.length - 1 do
        begin
          subjObj := TJSONObject.create(arrjObj.getString(I));
          Memo1.Lines.Add(
            Format('���� :%s | �ð� : %s:00 | ��� : %s��|   ����Ȯ�� : %s �ۼ�Ʈ| ���� : %s �ۼ�Ʈ|',
              [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
              subjObj.getString('rainProb'),subjObj.getString('humd')]));
          subjObj.Free;
        end;
      jObj.Free;
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt1.Text:=WetrText(Html);
      {��������}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt2.Text:=Comp(Html);
      {���}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt3.Text:=TmprNow(Html);
      {���� Ȯ��}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt4.Text:=rainAmt(Html);
      //����
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt7.Text:=WetrTmText(Html);
      {���ϳ���}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt6.Text:=WetrTm(Html);
      {���� ����Ȯ��}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt5.Text:=rainAmtTm(Html);
      end;
    2:
      begin
      {Json �Ľ� �ð���}
      Memo1.clear;      
      Html2:= UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305103'));
      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');

      for I := 0 to arrjObj.length - 1 do
        begin
          subjObj := TJSONObject.create(arrjObj.getString(I));
          Memo1.Lines.Add(
            Format('���� :%s | �ð� : %s:00 | ��� : %s��|   ����Ȯ�� : %s �ۼ�Ʈ| ���� : %s �ۼ�Ʈ|',
              [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
              subjObj.getString('rainProb'),subjObj.getString('humd')]));
          subjObj.Free;
        end;
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt1.Text:=WetrText(Html);
      {��������}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt2.Text:=Comp(Html);
      {���}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt3.Text:=TmprNow(Html);
      {���� Ȯ��}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt4.Text:=rainAmt(Html);
      //����
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt7.Text:=WetrTmText(Html);
      {���ϳ���}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt6.Text:=WetrTm(Html);
      {���� ����Ȯ��}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt5.Text:=rainAmtTm(Html);
      end;
      end
  end
   {*****************************************************************************************************************************************************************}
   {*****************************************************************************************************************************************************************}
   {**********************************************************************************W.B****************************************************************************}
   {*****************************************************************************************************************************************************************}
   {*****************************************************************************************************************************************************************}

  else if RadioButton2.Checked then
  begin

       case ComboBox3.ItemIndex of
    0 :
      begin
      WebBrowser1.Navigate('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101');
      {�ð��� ���� Json �Ľ�}
      Memo1.clear;
      WebBrowser2.Navigate('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305101');
      Html2 := WebBrowser2.OleObject.document.documentElement.innerTEXT;

      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');

      for I := 0 to arrjObj.length - 1 do
        begin
          subjObj := TJSONObject.create(arrjObj.getString(I));
          Memo1.Lines.Add(
            Format('���� :%s | �ð� : %s:00 | ��� : %s��|   ����Ȯ�� : %s �ۼ�Ʈ| ���� : %s �ۼ�Ʈ|',
              [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
              subjObj.getString('rainProb'),subjObj.getString('humd')]));
          subjObj.Free;
        end;
      {���� ����text}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt1.Text:=WetrText(Html);
      {��������}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt2.Text:=Comp(Html);
      {���}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt3.Text:=TmprNow(Html);
      {���� Ȯ��}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt4.Text:=rainAmt(Html);
      //����
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt7.Text:=WetrTmText(Html);
      {���ϳ���}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt6.Text:=WetrTm(Html);
      {���� ����Ȯ��}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt5.Text:=rainAmtTm(Html);

      end;
    1:
      begin
      WebBrowser1.Navigate('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534');
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      {�ð��� ���� Json �Ľ�}
      Memo1.clear;
      WebBrowser2.Navigate('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305534');
      Html2 := WebBrowser2.OleObject.document.documentElement.innerTEXT;
      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');

      for I := 0 to arrjObj.length - 1 do
        begin
          subjObj := TJSONObject.create(arrjObj.getString(I));
          Memo1.Lines.Add(
            Format('���� :%s | �ð� : %s:00 | ��� : %s��|   ����Ȯ�� : %s �ۼ�Ʈ| ���� : %s �ۼ�Ʈ|',
              [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
              subjObj.getString('rainProb'),subjObj.getString('humd')]));
          subjObj.Free;
        end;
      {���� ����text}
      edt1.Text:=WetrText(Html);
      {��������}
      edt2.Text:=Comp(Html);
      {���}
      edt3.Text:=TmprNow(Html);
      {���� Ȯ��}
      edt4.Text:=rainAmt(Html);
      //����
      edt7.Text:=WetrTmText(Html);
      {���ϳ���}
      edt6.Text:=WetrTm(Html);
      {���� ����Ȯ��}
      edt5.Text:=rainAmtTm(Html);

      end;
    2:
      begin
      WebBrowser1.Navigate('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534');
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      {�ð��� ���� Json �Ľ�}
      Memo1.clear;
      WebBrowser2.Navigate('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305103');
      Html2 := WebBrowser2.OleObject.document.documentElement.innerTEXT;
      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');
      for I := 0 to arrjObj.length - 1 do
        begin
          subjObj := TJSONObject.create(arrjObj.getString(I));
          Memo1.Lines.Add(
            Format('���� :%s | �ð� : %s:00 | ��� : %s��|   ����Ȯ�� : %s �ۼ�Ʈ| ���� : %s �ۼ�Ʈ|',
              [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
              subjObj.getString('rainProb'),subjObj.getString('humd')]));
          subjObj.Free;
        end;
      {���� ����text}
      edt1.Text:=WetrText(Html);
      {��������}
      edt2.Text:=Comp(Html);
      {���}
      edt3.Text:=TmprNow(Html);
      {���� Ȯ��}
      edt4.Text:=rainAmt(Html);
      //����
      edt7.Text:=WetrTmText(Html);
      {���ϳ���}
      edt6.Text:=WetrTm(Html);
      {���� ����Ȯ��}
      edt5.Text:=rainAmtTm(Html);
      end;
    end;

  end

  else
   ShowMessage('����� �����ϼ���');
  end;



procedure TForm1.FormCreate(Sender: TObject);
begin
      WebBrowser1.Navigate('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101');
      WebBrowser2.Navigate('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305101');
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
var
  Html,Html2 : UTF8String ;
begin
  case ComboBox3.ItemIndex of
  0:
  begin
    WebBrowser1.Navigate('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101');
    Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
    WebBrowser2.Navigate('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305101');
    Html2 := WebBrowser2.OleObject.document.documentElement.innerHTML;
  end;
  1:
  begin
    WebBrowser1.Navigate('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534');
    Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
    WebBrowser2.Navigate('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305534');
    Html2 := WebBrowser2.OleObject.document.documentElement.innerHTML;
  end;
  2:
  begin
    WebBrowser1.Navigate('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103');
    Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
    WebBrowser2.Navigate('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305103');
    Html2 := WebBrowser2.OleObject.document.documentElement.innerHTML;
  end;
end;
end;

{**********�Է¹���***********}
procedure TForm1.edt8KeyPress(Sender: TObject; var Key: Char);
begin
    key := #0;
end;

procedure TForm1.edt1KeyPress(Sender: TObject; var Key: Char);
begin
    key := #0;
end;

procedure TForm1.edt2KeyPress(Sender: TObject; var Key: Char);
begin
    key := #0;
end;

procedure TForm1.edt3KeyPress(Sender: TObject; var Key: Char);
begin
    key := #0;
end;

procedure TForm1.edt4KeyPress(Sender: TObject; var Key: Char);
begin
        key := #0;
end;

procedure TForm1.edt7KeyPress(Sender: TObject; var Key: Char);
begin
    key := #0;
end;

procedure TForm1.edt6KeyPress(Sender: TObject; var Key: Char);
begin
    key := #0;
end;

procedure TForm1.edt5KeyPress(Sender: TObject; var Key: Char);
begin
    key := #0;
end;

procedure TForm1.ComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
    key := #0;
end;

procedure TForm1.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
    key := #0;
end;

procedure TForm1.ComboBox3KeyPress(Sender: TObject; var Key: Char);
begin
    key := #0;
end;

procedure TForm1.TextBtnClick(Sender: TObject);
var
  jobj:TJSONObject;
  subjObj: TJSONObject;
  arrjObj: TJSONArray;
  i, t: integer;

  {�Ľ� �ҽ�}
  Html : UTF8String ;
  startline,endline : Integer;
begin
  Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305101'));
  {�ð��뺰 ��������}
  {JSON ���̺귯�� �̿�}
  begin
  jObj := TJSONObject.create( Html );
  arrjObj := jObj.getJSONArray('townWetrs');

  for I := 0 to arrjObj.length - 1 do begin
    subjObj := TJSONObject.create(arrjObj.getString(I));
    Memo1.Lines.Add(
      Format('���� :%s | �ð� : %s:00 | ��� : %s��|   ����Ȯ�� : %s �ۼ�Ʈ| ���� : %s �ۼ�Ʈ|',
        [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
        subjObj.getString('rainProb'),subjObj.getString('humd')]));
    subjObj.Free;
  end;
  jObj.Free;
  end;
end;


end.
