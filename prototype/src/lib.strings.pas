unit lib.strings;

interface

uses
  System.Generics.Collections,
  Vcl.CategoryButtons,
  System.DateUtils,
  Vcl.ActnList,
  Vcl.StdCtrls,
  Vcl.Buttons,
  System.SysUtils,
  System.Classes;

type
  iLibStrings = interface
    ['{D587A05E-C83F-47CC-88A3-1C9C829888D0}']
    procedure onCreate;
    function PegarTituloSistema: string;
    procedure ConverterLabel(aLabel: TLabel);
    procedure ConverterSpeedButton(aButton: TSpeedButton);
    procedure ConverterAction(aAction: TAction);
    procedure ConverterButtonCategory(aButton: TButtonCategory);
    function PegarVersaoSprint(IncMes: boolean = false): string;
  end;

  TLibStrings = class(TInterfacedObject, iLibStrings)
  private
    FArrayStrings: TDictionary<string, string>;

  protected
   { protected declarations }
  public
    destructor Destroy; override;

    procedure onCreate;
    function PegarVersaoSprint(IncMes: boolean = false): string;
    function PegarTituloSistema: string;
    procedure ConverterLabel(aLabel: TLabel);
    procedure ConverterSpeedButton(aButton: TSpeedButton);
    procedure ConverterAction(aAction: TAction);
    procedure ConverterButtonCategory(aButton: TButtonCategory);

    class function ObterInstancia: iLibStrings;
  end;

implementation

var
  FLibStrings: iLibStrings;

{ TLibString }

destructor TLibStrings.Destroy;
begin
  FreeAndNil(FArrayStrings);
  inherited;
end;

class function TLibStrings.ObterInstancia: iLibStrings;
begin
  if not Assigned(FLibStrings) then
  begin
    FLibStrings := Self.Create;
    FLibStrings.onCreate;
  end;

  Result := FLibStrings;
end;

procedure TLibStrings.onCreate;
begin
  FArrayStrings := TDictionary<string, string>.Create;

  with FArrayStrings do
  begin
    Add('-',                    '');
    Add('<titulo>',             'adminAgil');
    Add('<menu_index_0>',       'Retrospectiva');
    Add('<menu_index_1>',       'Cadastro');
    Add('<aCadEmpresa>',        'Empresa');
    Add('<aCadCargo>',          'Cargo');
    Add('<aCadFuncao>',         'Função');
    Add('<aCadEquipe>',         'Equipe');
    Add('<aCadColaborador>',    'Colaborador');
    Add('<aCadSprint>',         'Sprint');
    Add('<aPesquisa>',          'Pesquisa Felicidade');
    Add('<aPesquisaSM>',        'Gerenciar Pesquisa');
    Add('<aCerimonia>',         'Cerimonia');
    Add('<user_index_0>',       'Usuário');
    Add('<aConfigUser>',        'Configurações');
    Add('<Frase>',              'Não deixe que os obstáculos te impeçam de seguir em frente. '+sLineBreak+
                                'Você é capaz de superar qualquer desafio com determinação e coragem.'+sLineBreak+
                                'Acredite em si mesmo e em seus sonhos. Você tem o poder de transformar a sua vida.');
    Add('<titulo_pergunta_1>',  '- Informe algo que represente sua personalidade para esta sprint!');
    Add('<titulo_pergunta_2>',  '- Sua nota para pessoas?');
    Add('<titulo_pergunta_3>',  '- Sua nota para metodologia');
    Add('<titulo_pergunta_4>',  '- Sua nota para ferramentas');
    Add('<Pesquisa_realizada>', '*Pesquisa confirmada com sucesso');
    Add('<salvar>',             'Salvar');
    Add('<descr_sprint>',       'Sprint '+ PegarVersaoSprint);
    Add('<incPesquisa>',        'Incluir Pesquisa');
    Add('<cadastroSprint>',     'Cadastro de Sprint');
    Add('<cadEquipe>',          'Cadastro de Equipe');
    Add('<cadCargo>',           'Cadastro de Cargo');
    Add('<cadFuncao>',          'Cadastro de Função');
    Add('<cadEmpresa>',         'Cadastro de Empresa');
  end;
end;

function TLibStrings.PegarTituloSistema: string;
begin
  Result := FArrayStrings.Items['<titulo>'];
end;

function TLibStrings.PegarVersaoSprint(IncMes: boolean = false): string;
var
  Mes: TDateTime;
begin
  Mes := Now();
  if IncMes then
    Mes := IncMonth(Mes, 1);
  Result := IntToStr(YearOf(Now()))+'.'+IntToStr(MonthOf(Mes));
end;

procedure TLibStrings.ConverterAction(aAction: TAction);
begin
  if FArrayStrings.ContainsKey(aAction.Caption) then
    aAction.Caption := FArrayStrings.Items[aAction.Caption];
end;

procedure TLibStrings.ConverterButtonCategory(aButton: TButtonCategory);
begin
  if FArrayStrings.ContainsKey(aButton.Caption) then
    aButton.Caption := FArrayStrings.Items[aButton.Caption];
end;

procedure TLibStrings.ConverterLabel(aLabel: TLabel);
begin
  if FArrayStrings.ContainsKey(aLabel.Caption) then
    aLabel.Caption := FArrayStrings.Items[aLabel.Caption];
end;

procedure TLibStrings.ConverterSpeedButton(aButton: TSpeedButton);
begin
  if FArrayStrings.ContainsKey(aButton.Caption) then
    aButton.Caption := FArrayStrings.Items[aButton.Caption];
end;

end.
