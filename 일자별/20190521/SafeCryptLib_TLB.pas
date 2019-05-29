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
// File generated on 2017-12-08 ���� 4:15:46 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files (x86)\Cabsoft\Commons\SafeCrypt.dll (1)                  {dll ���� ��ġ}
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
  SafeCryptLibMajorVersion = 1;  			 //������ ����
  SafeCryptLibMinorVersion = 0;  			 //���̳� ����
	{Globally Unique Identifier 128 bit ũ���� ���� ��(����ü�� ����), ������������ �ð��� ��ҿ� ������� �����ϴٰ� �����ϴ� ��,UUID ���� ����, }  
  LIBID_SafeCryptLib: TGUID = '{46E9BC94-E88D-40F8-9995-6230C13651CB}';    
  

  IID_ICrypt: TGUID = '{0BA0BD4C-FE47-478F-A747-7FF23AE613F4}';   //�������̽� ID(�������̽� �ĺ���)
  CLASS_Crypt: TGUID = '{62DBCEAA-02B6-4BFA-AC1D-E19D9AB4B779}';  //Ŭ���� ID(COM ��ü �ĺ���)
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICrypt = interface;       //�������̽� 
  ICryptDisp = dispinterface;     //����ġ �������̽� : COM �������̽��� �ƴ�->�Һ���X, ������ �ʿ�x, 

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Crypt = ICrypt;       //CoClasses ���� TLB  

 
// *********************************************************************//
// Interface: ICrypt
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0BA0BD4C-FE47-478F-A747-7FF23AE613F4}
// *********************************************************************//
  ICrypt = interface(IDispatch)    //ICrypt�� Interface fucntion ����, �����Լ� ���̺� �νĹ��� IDispatch�� �ذ�
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
    function AriaEncrypt(pwd: {??PChar}OleVariant; KeyLength: Integer; inData: {??PChar}OleVariant): WideString; dispid 1;  //�Ƹ��ƾ�ȣȭ �Լ�
    function AriaDecrypt(pwd: {??PChar}OleVariant; KeyLength: Integer; inData: {??PChar}OleVariant): WideString; dispid 2;  //�Ƹ��ƺ�ȣȭ �Լ�
    function SeedEncrypt(pwd: {??PChar}OleVariant; inData: {??PChar}OleVariant): WideString; dispid 3;  //��ĪŰ ��ȣȭ �˰���
    function SeedDecrypt(pwd: {??PChar}OleVariant; inData: {??PChar}OleVariant): WideString; dispid 4; //��ĪŰ ��ȣȭ �˰��� 
    function EncodeToHex(inData: {??PChar}OleVariant): WideString; dispid 5;  //16���� ���ڵ� �˰��� 
    function DecodeFromHex(inData: {??PChar}OleVariant): WideString; dispid 6;  //16���� ���ڵ� �˰���
    function MD5(inData: OleVariant): WideString; dispid 7;  //128��Ʈ ��ȣȭ �ؽ��Լ�.
    function Sha160(inData: OleVariant): WideString; dispid 8;   //��������Ʈ �н����� ��ȣȭ
    function Sha256(inData: OleVariant): WideString; dispid 9;   //��������Ʈ �н����� ��ȣȭ 
    function Sha384(inData: OleVariant): WideString; dispid 10;  //��������Ʈ �н����� ��ȣȭ
    function Sha512(inData: OleVariant): WideString; dispid 11;  //��������Ʈ �н����� ��ȣȭ
    function UrlEncode(inData: {??PChar}OleVariant): WideString; dispid 12;  //URL���ڵ� �Լ�
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
  TCrypt = class(TOleControl)     //activex ��Ʈ�� �ڵ� ���� ��� �̸� ����Ʈ�ؿ� �� �ڵ� ����,,,  ����Ʈ�� �ƴϸ� �ڵ��������
  private
    FIntf: ICrypt;    
    function  GetControlInterface: ICrypt;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public       //��� �����Լ��� Body�� ������ ���ϰ� public ���� �����ؾ��Ѵ�.
    function AriaEncrypt(pwd: PChar; KeyLength: Integer; inData: PChar): WideString;   //�Ƹ��ƾ�ȣȭ �Լ�
    function AriaDecrypt(pwd: PChar; KeyLength: Integer; inData: PChar): WideString;   //�Ƹ��ƺ�ȣȭ �Լ�
    function SeedEncrypt(pwd: PChar; inData: PChar): WideString;//��ĪŰ ��ȣȭ �˰���
    function SeedDecrypt(pwd: PChar; inData: PChar): WideString;//��ĪŰ ��ȣȭ �˰��� 
    function EncodeToHex(inData: PChar): WideString;//16���� ���ڵ� �˰��� 
    function DecodeFromHex(inData: PChar): WideString; //16���� ���ڵ� �˰���
    function MD5(inData: OleVariant): WideString;//128��Ʈ ��ȣȭ �ؽ��Լ�.
    function Sha160(inData: OleVariant): WideString;//��������Ʈ �н����� ��ȣȭ
    function Sha256(inData: OleVariant): WideString;//��������Ʈ �н����� ��ȣȭ 
    function Sha384(inData: OleVariant): WideString;//��������Ʈ �н����� ��ȣȭ
    function Sha512(inData: OleVariant): WideString;//��������Ʈ �н����� ��ȣȭ
    function UrlEncode(inData: PChar): WideString;//URL���ڵ� �Լ�
    property  ControlInterface: ICrypt read GetControlInterface;  //getter
    property  DefaultInterface: ICrypt read GetControlInterface; //getter
  published          //�Ӽ� ����
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

resourcestring   //activeX ���
  dtlServerPage = 'ActiveX';    //����
  dtlOcxPage = 'ActiveX'; //������
implementation

uses ComObj;

procedure TCrypt.InitControlData;
const    // InitControlData �Ӽ� ���� 
  CControlData: TControlData2 = (
    ClassID: '{62DBCEAA-02B6-4BFA-AC1D-E19D9AB4B779}';  //COM��ü �ĺ���
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004002*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;  //ActiveX ��Ʈ���� ����µ� ���Ǵ� ����
end;

procedure TCrypt.CreateControl; 

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as ICrypt; //TCrypt IUnknown ���κ��� ��� �޾ƾ߸��Ѵ�.
  end;

begin
  if FIntf = nil then DoCreate;
end;
ISequentialStream    //IUnknown���κ��� ��ӹ���  -> �������̽� ��ü�� ��Ʈ���� �ܼ�ȭ ���� �׼����� �����Ѵ�
function TCrypt.GetControlInterface: ICrypt;
begin
  CreateControl;
  Result := FIntf;
end;




//������ �Լ� ����
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

//������Ʈ�� ��� ������� �����ؾ���.  In-process-server ���� Regsvr32 DLL ���ϸ� ���� ���
procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TCrypt]);
end;

end.
