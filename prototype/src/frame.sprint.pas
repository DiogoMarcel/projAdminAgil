unit frame.sprint;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, data.images,
  System.UITypes, Vcl.StdCtrls, Vcl.ExtCtrls, System.DateUtils;

type
  TfraSprint = class(TFrame)
    SpeedButton1: TSpeedButton;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    aDataAtual: TDateTime;
    function PegarVersaoSprint(aSomar: Boolean): string;
    function CadastrarSprint: boolean;

  public
    constructor Create(AOwner: TComponent); Override;
  end;

implementation

uses
  view.cad.sprint;

{$R *.dfm}

constructor TfraSprint.Create(AOwner: TComponent);
begin
  inherited;
  aDataAtual := now;
end;

function TfraSprint.PegarVersaoSprint(aSomar: Boolean): string;
begin
  if aSomar then
    aDataAtual := IncMonth(aDataAtual)
  else
    aDataAtual := IncMonth(aDataAtual, -1);

  Result := IntToStr(YearOf(aDataAtual))+'.'+IntToStr(MonthOf(aDataAtual))
end;

procedure TfraSprint.SpeedButton1Click(Sender: TObject);
begin
  Label6.Caption := 'Sprint '+ PegarVersaoSprint(false);
end;

procedure TfraSprint.SpeedButton2Click(Sender: TObject);
begin
  if CadastrarSprint then
    Label6.Caption := 'Sprint '+ PegarVersaoSprint(true);
end;

function TfraSprint.CadastrarSprint: boolean;
var
  fCadSprint: TfCadSprint;
begin
  Result := (MessageDlg('Deseja cadastrar sprint?', mtConfirmation, [mbyes, mbno], 0) = mrYes);

  if Result then
  begin
    fCadSprint := TfCadSprint.Create(Application);
    try
      fCadSprint.ShowModal;
    finally
      FreeAndNil(fCadSprint);
    end;
  end;
end;

end.
