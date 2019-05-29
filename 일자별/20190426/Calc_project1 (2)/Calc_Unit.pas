unit Calc_Unit;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ClearBtn: TButton;
    Button11: TButton;
    Button12: TButton;
    MinusBtn: TButton;
    DivBtn: TButton;
    Button17: TButton;
    Button0: TButton;
    Button19: TButton;
    EqBtn: TButton;
    Edit1: TEdit;
    MulBtn: TButton;
    PlusBtn: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button0Click(Sender: TObject);
    procedure PlusBtnClick(Sender: TObject);
    procedure Calculate();
    procedure EqBtnClick(Sender: TObject);
    procedure OperatorClick();
    procedure MinusBtnClick(Sender: TObject);
    procedure MulBtnClick(Sender: TObject);
    procedure DivBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure Init();
    procedure Button19Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);

 
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
 
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var

  Form1: TForm1;
  result:real=0;
  val1:real=0; //피연산자1
  val2:real=0; //피연산자2
  check:integer;
  totalString:string;
  flag:boolean=true;
  delNum:string;
  OFlag:boolean=true; 
implementation

{$R *.dfm}

procedure TForm1.Init();
begin
result:=0;
val1:=0;
val2:=0;
Edit1.Text:='';
totalString:='';
flag:=true;


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'1';
  EqBtn.SetFocus;
  OFlag:=false;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'2';
  EqBtn.SetFocus;
  OFlag:=false;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'3';
  EqBtn.SetFocus;
  OFlag:=false;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'4';
  EqBtn.SetFocus;
  OFlag:=false;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'5';
  EqBtn.SetFocus;
  OFlag:=false;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'6';
  EqBtn.SetFocus;
  OFlag:=false;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'7';
  EqBtn.SetFocus;
  OFlag:=false;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'8';
  EqBtn.SetFocus;
  OFlag:=false;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'9';
  EqBtn.SetFocus;
  OFlag:=false;
end;

procedure TForm1.Button0Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'0';
  EqBtn.SetFocus;
  OFlag:=false;
end;



procedure TForm1.OperatorClick();
begin
if(flag=true) then
begin
val2:=StrToFloat(Edit1.Text);
val1:=val2;
Edit1.Text:='';
flag:=false;
end
else
begin
val2:=StrToFloat(Edit1.Text);
Calculate();
val1:=result;
Edit1.Text:='';
end;
end;
procedure TForm1.Calculate();
begin
  case check of
0: begin
result:=val1+val2;//check가 0이면 더하기
end;
1: begin
result:=val1-val2;//check가 1이면 빼기
end;
2: begin
result:=val1*val2;//check가 2이면 곱하기
end;
3: begin
if(val2=0) then//val2이 0이면 못 나눔          
begin
exit;
end
else
begin
result:=val1/val2;//check가 3이면 나누기
end;
end;
end;
end;

procedure TForm1.EqBtnClick(Sender: TObject);
begin
if(val1=0) then
begin
ShowMessage('숫자를 입력하시오');
exit;
end;

  case check of
0: Edit1.Text:=FloatToStr(val1+StrToFloat(Edit1.text));
1: Edit1.Text:=FloatToStr(val1-StrToFloat(Edit1.text));
2: Edit1.Text:=FloatToStr(val1*StrToFloat(Edit1.Text));
3: if(val1=0)then
begin
ShowMessage('나눌수 없음');
exit;
end
else if (StrToFloat(Edit1.Text)=0) then
begin
ShowMessage('나눌수 없음');
exit;
end
else
begin
Edit1.Text:=FloatToStr(val1/StrToFloat(Edit1.Text));
end;
end;
//Init();
end;
procedure TForm1.PlusBtnClick(Sender: TObject);
begin

 if(OFlag=true) then
  begin
   Edit1.Text:='+';
   EqBtn.SetFocus;
   end
  else if(OFlag=false) then
  begin
  OperatorClick();
  check:=0;
  totalString:=totalString+ConCat(FloatToStr(val2));
  end

end;
procedure TForm1.MinusBtnClick(Sender: TObject);
begin
  if(OFlag=true) then
  begin
  Edit1.Text:='-';
  EqBtn.SetFocus;
  end
  else if(OFlag=false) then
  begin
  OperatorClick();
  check:=1;
  totalString:=totalString+ConCat(FloatToStr(val2));
  end
end;

procedure TForm1.MulBtnClick(Sender: TObject);
begin

  if(OFlag=true) then
  begin
  Edit1.Text:='x';
  check:=2;
  EqBtn.SetFocus;
  end
  else if(OFlag=false) then
  begin
  OperatorClick();
  check:=2;
  totalString:=totalString+ConCat(FloatToStr(val2));
  end
end;

procedure TForm1.DivBtnClick(Sender: TObject);
begin
  if(OFlag=true) then
  begin
  Edit1.Text:='/';
  EqBtn.SetFocus;
  end
  else if(OFlag=false) then
  begin
  OperatorClick();
  check:=3;
  totalString:=totalString+ConCat(FloatToStr(val2));
  end 
end;

procedure TForm1.ClearBtnClick(Sender: TObject);
begin
Edit1.Clear;

Edit1.text:='0';
Init();

end;

procedure TForm1.Button19Click(Sender: TObject);
begin
   Edit1.Text:=Edit1.Text+'.';
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
delNum:=Edit1.Text;
Delete(delNum,length(delNum),1);
Edit1.Text:=delNum;//delete메소드는 리턴값이 없음
end;




procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
const
  Bksp=#08;
begin
  if not (Key in ['0'..'9',Bksp]) then key := #0;
end;

end.
