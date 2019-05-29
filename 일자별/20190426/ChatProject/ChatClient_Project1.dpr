program ChatClient_Project1;

uses
  Forms,
  ChatClient in 'ChatClient.pas' {kloikm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tkloikm, kloikm);
  Application.Run;
end.
