unit SafeCryptLib_TLB;

// ************************************************************************ 				 
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 2017-12-08 오후 4:15:46 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files (x86)\Cabsoft\Commons\SafeCrypt.dll (1)                  {dll 파일 위치}
// LIBID: {46E9BC94-E88D-40F8-9995-6230C13651CB}
// LCID: 0
// Helpfile: 
// HelpString: SafeCrypt 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SafeCryptLibMajorVersion = 1;  			 //메이저 버전
  SafeCryptLibMinorVersion = 0;  			 //마이너 버전
	{Globally Unique Identifier 128 bit 크기의 정수 값(구조체로 정의), 전세계적으로 시간과 장소에 관계없이 고유하다고 보장하는 값,UUID 에서 유래, }  
  LIBID_SafeCryptLib: TGUID = '{46E9BC94-E88D-40F8-9995-6230C13651CB}';    
  

  IID_ICrypt: TGUID = '{0BA0BD4C-FE47-478F-A747-7FF23AE613F4}';   //인터페이스 ID(인터페이스 식별자)
  CLASS_Crypt: TGUID = '{62DBCEAA-02B6-4BFA-AC1D-E19D9AB4B779}';  //클래스 ID(COM 객체 식별자)
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICrypt = interface;       //인터페이스 
  ICryptDisp = dispinterface;     //디스패치 인터페이스 : COM 인터페이스가 아님->불변성X, 리턴할 필요x, 

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Crypt = ICrypt;       //CoClasses 선언 TLB  

 
// *********************************************************************//
// Interface: ICrypt
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0BA0BD4C-FE47-478F-A747-7FF23AE613F4}
// *********************************************************************//
  ICrypt = interface(IDispatch)    //ICrypt의 Interface fucntion 구현, 가상함수 테이블 인식문제 IDispatch로 해결
    ['{0BA0BD4C-FE47-478F-A747-7FF23AE613F4}']
    function AriaEncrypt(pwd: PChar; KeyLength: Integer; inData: PChar): WideString; safecall;
    function AriaDecrypt(pwd: PChar; KeyLength: Integer; inData: PChar): WideString; safecall;
    function SeedEncrypt(pwd: PChar; inData: PChar): WideString; safecall;
    function SeedDecrypt(pwd: PChar; inData: PChar): WideString; safecall;
    function EncodeToHex(inData: PChar): WideString; safecall;
    function DecodeFromHex(inData: PChar): WideString; safecall;
    function MD5(inData: OleVariant): WideString; safecall;
    function Sha160(inData: OleVariant): WideString; safecall;
    function Sha256(inData: OleVariant): WideString; safecall;
    function Sha384(inData: OleVariant): WideString; safecall;
    function Sha512(inData: OleVariant): WideString; safecall;
    function UrlEncode(inData: PChar): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  ICryptDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0BA0BD4C-FE47-478F-A747-7FF23AE613F4}
// *********************************************************************//
  ICryptDisp = dispinterface
    ['{0BA0BD4C-FE47-478F-A747-7FF23AE613F4}']
    function AriaEncrypt(pwd: {??PChar}OleVariant; KeyLength: Integer; inData: {??PChar}OleVariant): WideString; dispid 1;  //아리아암호화 함수
    function AriaDecrypt(pwd: {??PChar}OleVariant; KeyLength: Integer; inData: {??PChar}OleVariant): WideString; dispid 2;  //아리아복호화 함수
    function SeedEncrypt(pwd: {??PChar}OleVariant; inData: {??PChar}OleVariant): WideString; dispid 3;  //대칭키 암호화 알고리즘
    function SeedDecrypt(pwd: {??PChar}OleVariant; inData: {??PChar}OleVariant): WideString; dispid 4; //대칭키 복호화 알고리즘 
    function EncodeToHex(inData: {??PChar}OleVariant): WideString; dispid 5;  //16진수 인코딩 알고리즘 
    function DecodeFromHex(inData: {??PChar}OleVariant): WideString; dispid 6;  //16진수 디코딩 알고리즘
    function MD5(inData: OleVariant): WideString; dispid 7;  //128비트 암호화 해시함수.
    function Sha160(inData: OleVariant): WideString; dispid 8;   //다이제스트 패스워드 암호화
    function Sha256(inData: OleVariant): WideString; dispid 9;   //다이제스트 패스워드 암호화 
    function Sha384(inData: OleVariant): WideString; dispid 10;  //다이제스트 패스워드 암호화
    function Sha512(inData: OleVariant): WideString; dispid 11;  //다이제스트 패스워드 암호화
    function UrlEncode(inData: {??PChar}OleVariant): WideString; dispid 12;  //URL인코딩 함수
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TCrypt
// Help String      : Crypt Class
// Default Interface: ICrypt
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TCrypt = class(TOleControl)     //activex 컨트롤 코드 구현 방식 이며 임포트해올 때 자동 생성,,,  임포트가 아니면 코딩해줘야함
  private
    FIntf: ICrypt;    
    function  GetControlInterface: ICrypt;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public       //모든 가상함수는 Body를 가지지 못하고 public 으로 선언해야한다.
    function AriaEncrypt(pwd: PChar; KeyLength: Integer; inData: PChar): WideString;   //아리아암호화 함수
    function AriaDecrypt(pwd: PChar; KeyLength: Integer; inData: PChar): WideString;   //아리아복호화 함수
    function SeedEncrypt(pwd: PChar; inData: PChar): WideString;//대칭키 암호화 알고리즘
    function SeedDecrypt(pwd: PChar; inData: PChar): WideString;//대칭키 복호화 알고리즘 
    function EncodeToHex(inData: PChar): WideString;//16진수 인코딩 알고리즘 
    function DecodeFromHex(inData: PChar): WideString; //16진수 디코딩 알고리즘
    function MD5(inData: OleVariant): WideString;//128비트 암호화 해시함수.
    function Sha160(inData: OleVariant): WideString;//다이제스트 패스워드 암호화
    function Sha256(inData: OleVariant): WideString;//다이제스트 패스워드 암호화 
    function Sha384(inData: OleVariant): WideString;//다이제스트 패스워드 암호화
    function Sha512(inData: OleVariant): WideString;//다이제스트 패스워드 암호화
    function UrlEncode(inData: PChar): WideString;//URL인코딩 함수
    property  ControlInterface: ICrypt read GetControlInterface;  //getter
    property  DefaultInterface: ICrypt read GetControlInterface; //getter
  published          //속성 설정
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
  end;

procedure Register;

resourcestring   //activeX 사용
  dtlServerPage = 'ActiveX';    //서버
  dtlOcxPage = 'ActiveX'; //페이지
implementation

uses ComObj;

procedure TCrypt.InitControlData;
const    // InitControlData 속성 설정 
  CControlData: TControlData2 = (
    ClassID: '{62DBCEAA-02B6-4BFA-AC1D-E19D9AB4B779}';  //COM객체 식별자
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004002*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;  //ActiveX 컨트롤을 만드는데 사용되는 설정
end;

procedure TCrypt.CreateControl; 

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as ICrypt; //TCrypt IUnknown 으로부터 상속 받아야만한다.
  end;

begin
  if FIntf = nil then DoCreate;
end;
ISequentialStream    //IUnknown으로부터 상속받음  -> 인터페이스 객체를 스트리밍 단순화 순차 액세스를 지원한다
function TCrypt.GetControlInterface: ICrypt;
begin
  CreateControl;
  Result := FIntf;
end;




//각각의 함수 구현
function TCrypt.AriaEncrypt(pwd: PChar; KeyLength: Integer; inData: PChar): WideString;
begin
  Result := DefaultInterface.AriaEncrypt(pwd, KeyLength, inData);
end;

function TCrypt.AriaDecrypt(pwd: PChar; KeyLength: Integer; inData: PChar): WideString;
begin
  Result := DefaultInterface.AriaDecrypt(pwd, KeyLength, inData);
end;

function TCrypt.SeedEncrypt(pwd: PChar; inData: PChar): WideString;
begin
  Result := DefaultInterface.SeedEncrypt(pwd, inData);
end;

function TCrypt.SeedDecrypt(pwd: PChar; inData: PChar): WideString;
begin
  Result := DefaultInterface.SeedDecrypt(pwd, inData);
end;

function TCrypt.EncodeToHex(inData: PChar): WideString;
begin
  Result := DefaultInterface.EncodeToHex(inData);
end;

function TCrypt.DecodeFromHex(inData: PChar): WideString;
begin
  Result := DefaultInterface.DecodeFromHex(inData);
end;

function TCrypt.MD5(inData: OleVariant): WideString;
begin
  Result := DefaultInterface.MD5(inData);
end;

function TCrypt.Sha160(inData: OleVariant): WideString;
begin
  Result := DefaultInterface.Sha160(inData);
end;

function TCrypt.Sha256(inData: OleVariant): WideString;
begin
  Result := DefaultInterface.Sha256(inData);
end;

function TCrypt.Sha384(inData: OleVariant): WideString;
begin
  Result := DefaultInterface.Sha384(inData);
end;

function TCrypt.Sha512(inData: OleVariant): WideString;
begin
  Result := DefaultInterface.Sha512(inData);
end;

function TCrypt.UrlEncode(inData: PChar): WideString;
begin
  Result := DefaultInterface.UrlEncode(inData);
end;

//레지스트리 등록 가장먼저 진행해야함.  In-process-server 기준 Regsvr32 DLL 파일명 으로 등록
procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TCrypt]);
end;

end.
