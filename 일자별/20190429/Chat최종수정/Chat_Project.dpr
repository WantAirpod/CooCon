program Chat_Project;

uses
  Forms,
  Chat in 'Chat.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
