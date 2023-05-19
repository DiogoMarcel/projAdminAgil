unit view.pesquisa.gerente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, view.padrao, System.Actions, System.Generics.Collections,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.CategoryButtons, Vcl.WinXCtrls,
  frame.titulo, frame.sprint, Vcl.Buttons, frame.inc.pesquisa,
  frame.inc.item.pesquisa;

type
  TfPesquisaGerente = class(TfPadrao)
    fraSprint1: TfraSprint;
    aIncPesquisa: TAction;
    fraIncPesquisa1: TfraIncPesquisa;
    FlowPanel1: TFlowPanel;
    aDelPesquisa: TAction;
    procedure FormShow(Sender: TObject);
    procedure aIncPesquisaExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure aDelPesquisaExecute(Sender: TObject);
  private
    FListItemFrame: TDictionary<integer, TfraItemPesquisa>;

    procedure adicionarItemPesquisa;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfPesquisaGerente.aDelPesquisaExecute(Sender: TObject);
var
  AFraItem: TfraItemPesquisa;
begin
  inherited;

  FListItemFrame.TryGetValue(TSpeedButton(Sender).Owner.Tag, AFraItem);

  if assigned(AFraItem) then
  begin
    AFraItem.Free;
    AFraItem := nil;
  end;

end;

procedure TfPesquisaGerente.adicionarItemPesquisa;
var
  AFraItem: TfraItemPesquisa;
begin
  AFraItem := TfraItemPesquisa.Create(Self);
  AFraItem.Name := 'frameItem'+ integer(FListItemFrame.Count+1).ToString;
  AFraItem.Tag := FListItemFrame.Count+1;
  AFraItem.parent := FlowPanel1;
  AFraItem.Align := alTop;
  AFraItem.Label1.Caption      := fraIncPesquisa1.Memo1.Text;
  AFraItem.pTexto.Visible      := fraIncPesquisa1.RadioGroup1.ItemIndex = 0;
  AFraItem.pNumerico.Visible   := fraIncPesquisa1.RadioGroup1.ItemIndex = 1;
  AFraItem.pVerdadeiro.Visible := fraIncPesquisa1.RadioGroup1.ItemIndex = 2;
  AFraItem.SpeedButton2.OnClick := aDelPesquisaExecute;

  FListItemFrame.Add(FListItemFrame.Count+1, AFraItem);
end;

procedure TfPesquisaGerente.aIncPesquisaExecute(Sender: TObject);
begin
  inherited;
  if fraIncPesquisa1.Memo1.GetTextLen = 0 then
  begin
    ShowMessage('Preenchimento obrigatório da pergunta');
    Exit;
  end
  else if fraIncPesquisa1.RadioGroup1.ItemIndex < 0 then
  begin
    Showmessage('Opção de tipo de resposta obrigatório');
    Exit;
  end;

  adicionarItemPesquisa;

  fraIncPesquisa1.Memo1.Clear;
  fraIncPesquisa1.RadioGroup1.ItemIndex := -1;
end;

procedure TfPesquisaGerente.FormDestroy(Sender: TObject);
begin
  if Assigned(FListItemFrame) then
  begin

  end;

  inherited;
end;

procedure TfPesquisaGerente.FormShow(Sender: TObject);
begin
  FListItemFrame := TDictionary<integer, TfraItemPesquisa>.Create;

  svMenu.Close;

  inherited;
end;

end.
