unit view.cad.colaborador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, view.cad.padrao, Data.DB, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, frame.card.colab,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.CategoryButtons, Vcl.WinXCtrls, frame.titulo;

type
  TfCadColaborador = class(TfCadPadrao)
    tableRegistrousuario: TStringField;
    tableRegistronome: TStringField;
    tableRegistrosenha: TStringField;
    tableRegistrogerenciaPesquisa: TBooleanField;
    tableRegistrogerenciaColaborador: TBooleanField;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    tabCards: TTabSheet;
    FlowPanel1: TFlowPanel;
    SpeedButton6: TSpeedButton;
    aCards: TAction;
    procedure aCardsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FContador: integer;
    FListCardFrame: TDictionary<integer, TfraCardColab>;

  public
    procedure AdicionarRegistroPadrao; override;
    procedure CarregarCampos; override;
    procedure LimparCampos; override;
    procedure SalvarCadastro; override;

  end;

implementation

uses
  lib.utils;

{$R *.dfm}

{ TfCadColaborador }

procedure TfCadColaborador.aCardsExecute(Sender: TObject);
var
  ItemCard: TfraCardColab;
begin
  inherited;

  for var i := 0 to Pred(flistcardframe.Count) do
  begin
    flistcardframe.TryGetValue(i, ItemCard);

    if assigned(ItemCard) then
    begin
      ItemCard.Free;
      ItemCard := nil;
    end;
  end;

  FlowPanel1.Repaint;

  tableregistro.first;
  while not tableregistro.Eof do
  begin
    Inc(FContador);

    ItemCard := TfraCardColab.Create(Self);
    ItemCard.Name := 'frameItem'+ integer(FListCardFrame.Count+1).ToString;
    ItemCard.Tag := FListCardFrame.Count+1;
    ItemCard.parent := FlowPanel1;
    itemcard.Align := alTop;
    itemcard.lId.caption := tableregistroid.AsInteger.ToString;
    itemcard.lNome.caption := tableregistronome.AsString;
    itemcard.lUsuario.caption := tableregistrousuario.AsString;
    itemcard.lSenha.Caption := tableregistrosenha.AsString;
    itemcard.lGerenciaPesquisa.Caption := TLibUtil.IfThen<string>(tableRegistrogerenciaPesquisa.AsBoolean, 'Sim', 'Não');
    itemcard.lGerenciaColab.Caption := TLibUtil.IfThen<string>(tableRegistrogerenciaColaborador.AsBoolean, 'Sim', 'Não');

    flistcardframe.Add(flistcardframe.Count+1, itemcard);

    tableregistro.next;
  end;

  PageControl1.ActivePage := tabCards;
end;

procedure TfCadColaborador.AdicionarRegistroPadrao;
begin
  inherited;
  tableRegistroNome.AsString := 'Colaborador Master';
  tableRegistrousuario.AsString := 'administrador';
  tableRegistrosenha.AsString := '*******';
  tableRegistrogerenciaPesquisa.AsBoolean := True;
  tableRegistrogerenciaColaborador.AsBoolean := True;
  tableRegistro.Post;
end;

procedure TfCadColaborador.CarregarCampos;
begin
  inherited;
  edit1.Text := tableRegistroNome.AsString;
  Edit2.Text := tableRegistrousuario.AsString;
  edit3.Text := tableRegistrosenha.AsString;
  RadioGroup1.ItemIndex := TLibUtil.IfThen<integer>(tableRegistrogerenciaPesquisa.AsBoolean, 1, 0);
  radiogroup2.ItemIndex := TLibUtil.IfThen<integer>(tableRegistrogerenciaColaborador.AsBoolean, 1, 0);
end;

procedure TfCadColaborador.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FListCardFrame) then
    FreeAndNil(FListCardFrame);
end;

procedure TfCadColaborador.FormShow(Sender: TObject);
begin
  inherited;
  FContador := 0;
  FListCardFrame := TDictionary<integer, TfraCardColab>.Create;
end;

procedure TfCadColaborador.LimparCampos;
begin
  inherited;
  edit1.Text := EmptyStr;
  Edit2.Text := EmptyStr;
  edit3.Text := EmptyStr;
  RadioGroup1.ItemIndex := -1;
  radiogroup2.ItemIndex := -1;
end;

procedure TfCadColaborador.SalvarCadastro;
begin
  inherited;
  if not (tableRegistro.State in [dsEdit]) then
  begin
    tableRegistro.Append;
    tableRegistroid.AsInteger := strtoInt(lIDKey.Caption);
  end;

  tableRegistroNome.AsString := edit1.Text;
  tableRegistrousuario.AsString := Edit2.text;
  tableRegistrosenha.AsString := edit3.Text;
  tableRegistrogerenciaPesquisa.AsBoolean := RadioGroup1.ItemIndex = 1;
  tableRegistrogerenciaColaborador.AsBoolean := RadioGroup2.ItemIndex = 1;
  tableRegistro.Post;
end;

end.
