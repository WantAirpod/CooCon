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
{날씨관련 함수}
function WetrText(Html : UTF8String): String;
var
  startline,endline : Integer;
begin
  startline := AnsiPos('"wetrTxt',Html);
  endline := AnsiPos(']});',Html);
  Html := Copy( Html,startline+Length('"wetrTxt')+4,4);
  Result := Html;
end;
{비교}
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
{현재기온}
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
    ShowMessage('동을 입력하시오');
    edt8.text:= ' ' ;
  end

  else if ComboBox3.ItemIndex <> -1 then
    begin
    edt8.Text:=ComboBox1.text+ ' ' + ComboBox2.Text+ ' ' + ComboBox3.Text ;
  end ;
 //모두 초기화
    edt1.Clear;
    edt2.Clear;
    edt3.Clear;
    edt4.Clear;
    edt5.Clear;
    edt6.Clear;
    edt7.Clear;
// 도시 정보 입력
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
      {Json 파싱 시간별}
      Memo1.clear;
      Html2:= UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305101'));
      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');

      for I := 0 to arrjObj.length - 1 do begin
        subjObj := TJSONObject.create(arrjObj.getString(I));
        Memo1.Lines.Add(
          Format('연도 :%s | 시간 : %s:00 | 기온 : %s도|   강수확률 : %s 퍼센트| 습도 : %s 퍼센트|',
            [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
            subjObj.getString('rainProb'),subjObj.getString('humd')]));
        subjObj.Free;
      end;
      jObj.Free;
      {현재 기후text}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt1.Text:=WetrText(Html);
      {어제보다}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt2.Text:=Comp(Html);
      {기온}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt3.Text:=TmprNow(Html);
      {강수 확률}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt4.Text:=rainAmt(Html);
      //내일
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt7.Text:=WetrTmText(Html);
      {내일날씨}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt6.Text:=WetrTm(Html);
      {내일 강수확률}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305101'));
      edt5.Text:=rainAmtTm(Html);
      end;
    1:
      begin
      {Json 파싱 시간별}
      Memo1.clear;
      Html2:= UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305534'));
      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');

      for I := 0 to arrjObj.length - 1 do
        begin
          subjObj := TJSONObject.create(arrjObj.getString(I));
          Memo1.Lines.Add(
            Format('연도 :%s | 시간 : %s:00 | 기온 : %s도|   강수확률 : %s 퍼센트| 습도 : %s 퍼센트|',
              [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
              subjObj.getString('rainProb'),subjObj.getString('humd')]));
          subjObj.Free;
        end;
      jObj.Free;
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt1.Text:=WetrText(Html);
      {어제보다}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt2.Text:=Comp(Html);
      {기온}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt3.Text:=TmprNow(Html);
      {강수 확률}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt4.Text:=rainAmt(Html);
      //내일
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt7.Text:=WetrTmText(Html);
      {내일날씨}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt6.Text:=WetrTm(Html);
      {내일 강수확률}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534'));
      edt5.Text:=rainAmtTm(Html);
      end;
    2:
      begin
      {Json 파싱 시간별}
      Memo1.clear;      
      Html2:= UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305103'));
      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');

      for I := 0 to arrjObj.length - 1 do
        begin
          subjObj := TJSONObject.create(arrjObj.getString(I));
          Memo1.Lines.Add(
            Format('연도 :%s | 시간 : %s:00 | 기온 : %s도|   강수확률 : %s 퍼센트| 습도 : %s 퍼센트|',
              [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
              subjObj.getString('rainProb'),subjObj.getString('humd')]));
          subjObj.Free;
        end;
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt1.Text:=WetrText(Html);
      {어제보다}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt2.Text:=Comp(Html);
      {기온}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt3.Text:=TmprNow(Html);
      {강수 확률}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt4.Text:=rainAmt(Html);
      //내일
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt7.Text:=WetrTmText(Html);
      {내일날씨}
      Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305103'));
      edt6.Text:=WetrTm(Html);
      {내일 강수확률}
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
      {시간별 날씨 Json 파싱}
      Memo1.clear;
      WebBrowser2.Navigate('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305101');
      Html2 := WebBrowser2.OleObject.document.documentElement.innerTEXT;

      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');

      for I := 0 to arrjObj.length - 1 do
        begin
          subjObj := TJSONObject.create(arrjObj.getString(I));
          Memo1.Lines.Add(
            Format('연도 :%s | 시간 : %s:00 | 기온 : %s도|   강수확률 : %s 퍼센트| 습도 : %s 퍼센트|',
              [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
              subjObj.getString('rainProb'),subjObj.getString('humd')]));
          subjObj.Free;
        end;
      {현재 기후text}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt1.Text:=WetrText(Html);
      {어제보다}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt2.Text:=Comp(Html);
      {기온}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt3.Text:=TmprNow(Html);
      {강수 확률}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt4.Text:=rainAmt(Html);
      //내일
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt7.Text:=WetrTmText(Html);
      {내일날씨}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt6.Text:=WetrTm(Html);
      {내일 강수확률}
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      edt5.Text:=rainAmtTm(Html);

      end;
    1:
      begin
      WebBrowser1.Navigate('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534');
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      {시간별 날씨 Json 파싱}
      Memo1.clear;
      WebBrowser2.Navigate('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305534');
      Html2 := WebBrowser2.OleObject.document.documentElement.innerTEXT;
      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');

      for I := 0 to arrjObj.length - 1 do
        begin
          subjObj := TJSONObject.create(arrjObj.getString(I));
          Memo1.Lines.Add(
            Format('연도 :%s | 시간 : %s:00 | 기온 : %s도|   강수확률 : %s 퍼센트| 습도 : %s 퍼센트|',
              [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
              subjObj.getString('rainProb'),subjObj.getString('humd')]));
          subjObj.Free;
        end;
      {현재 기후text}
      edt1.Text:=WetrText(Html);
      {어제보다}
      edt2.Text:=Comp(Html);
      {기온}
      edt3.Text:=TmprNow(Html);
      {강수 확률}
      edt4.Text:=rainAmt(Html);
      //내일
      edt7.Text:=WetrTmText(Html);
      {내일날씨}
      edt6.Text:=WetrTm(Html);
      {내일 강수확률}
      edt5.Text:=rainAmtTm(Html);

      end;
    2:
      begin
      WebBrowser1.Navigate('https://weather.naver.com/json/crntWetrDetail.nhn?_callback=window.__jindo2_callback._8166&naverRgnCd=09305534');
      Html := WebBrowser1.OleObject.document.documentElement.innerHTML;
      {시간별 날씨 Json 파싱}
      Memo1.clear;
      WebBrowser2.Navigate('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305103');
      Html2 := WebBrowser2.OleObject.document.documentElement.innerTEXT;
      jObj := TJSONObject.create( Html2 );
      arrjObj := jObj.getJSONArray('townWetrs');
      for I := 0 to arrjObj.length - 1 do
        begin
          subjObj := TJSONObject.create(arrjObj.getString(I));
          Memo1.Lines.Add(
            Format('연도 :%s | 시간 : %s:00 | 기온 : %s도|   강수확률 : %s 퍼센트| 습도 : %s 퍼센트|',
              [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
              subjObj.getString('rainProb'),subjObj.getString('humd')]));
          subjObj.Free;
        end;
      {현재 기후text}
      edt1.Text:=WetrText(Html);
      {어제보다}
      edt2.Text:=Comp(Html);
      {기온}
      edt3.Text:=TmprNow(Html);
      {강수 확률}
      edt4.Text:=rainAmt(Html);
      //내일
      edt7.Text:=WetrTmText(Html);
      {내일날씨}
      edt6.Text:=WetrTm(Html);
      {내일 강수확률}
      edt5.Text:=rainAmtTm(Html);
      end;
    end;

  end

  else
   ShowMessage('방식을 선택하세요');
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

{**********입력방지***********}
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

  {파싱 소스}
  Html : UTF8String ;
  startline,endline : Integer;
begin
  Html := UTF8Decode(GetWebBrowserHTML('https://weather.naver.com/flash/naverRgnTownFcast.nhn?m=jsonResult&naverRgnCd=09305101'));
  {시간대별 가져오기}
  {JSON 라이브러리 이용}
  begin
  jObj := TJSONObject.create( Html );
  arrjObj := jObj.getJSONArray('townWetrs');

  for I := 0 to arrjObj.length - 1 do begin
    subjObj := TJSONObject.create(arrjObj.getString(I));
    Memo1.Lines.Add(
      Format('연도 :%s | 시간 : %s:00 | 기온 : %s도|   강수확률 : %s 퍼센트| 습도 : %s 퍼센트|',
        [subjObj.getString('ymd'), subjObj.getString('hh'), subjObj.getString('tmpr'),
        subjObj.getString('rainProb'),subjObj.getString('humd')]));
    subjObj.Free;
  end;
  jObj.Free;
  end;
end;


end.
