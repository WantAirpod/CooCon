program Calc_project1;

uses
  Forms,
  Calc_Unit in 'Calc_Unit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
