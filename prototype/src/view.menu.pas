unit view.menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, view.padrao, frame.titulo, Vcl.CategoryButtons, Vcl.ExtCtrls,
  Vcl.WinXCtrls, System.Actions, Vcl.ActnList;

type
  TfMenu = class(TfPadrao)
    procedure aPesquisaExecute(Sender: TObject);
    procedure aPesquisaSMExecute(Sender: TObject);
    procedure aCadSprintExecute(Sender: TObject);
    procedure aCadEquipeExecute(Sender: TObject);
    procedure aCadCargoExecute(Sender: TObject);
    procedure aCadFuncaoExecute(Sender: TObject);
    procedure aCadEmpresaExecute(Sender: TObject);
    procedure aCadColaboradorExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMenu: TfMenu;

implementation

uses
  view.cad.equipe,
  view.cad.sprint,
  view.cad.cargo,
  view.cad.funcao,
  view.cad.empresa,
  view.cad.colaborador,
  view.pesquisa.gerente,
  view.pesquisa;

{$R *.dfm}

procedure TfMenu.aCadCargoExecute(Sender: TObject);
begin
  AbrirTelaSelf(TfCadCargo.Create(Self));
end;

procedure TfMenu.aCadColaboradorExecute(Sender: TObject);
begin
  AbrirTelaSelf(TfCadColaborador.Create(Self));
end;

procedure TfMenu.aCadEmpresaExecute(Sender: TObject);
begin
  AbrirTelaSelf(TfCadEmpresa.Create(Self));
end;

procedure TfMenu.aCadEquipeExecute(Sender: TObject);
begin
  AbrirTelaSelf(TfCadEquipe.Create(Self));
end;

procedure TfMenu.aCadFuncaoExecute(Sender: TObject);
begin
  AbrirTelaSelf(TfCadFuncao.Create(Self));
end;

procedure TfMenu.aCadSprintExecute(Sender: TObject);
begin
  AbrirTelaSelf(TfCadSprint.Create(Self));
end;

procedure TfMenu.aPesquisaExecute(Sender: TObject);
begin
  AbrirTelaSelf(TfPesquisa.Create(Self));
end;

procedure TfMenu.aPesquisaSMExecute(Sender: TObject);
begin
  AbrirTelaSelf(TfPesquisaGerente.Create(Self));
end;

end.
