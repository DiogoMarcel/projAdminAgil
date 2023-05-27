unit view.cad.padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, view.padrao, System.Actions, System.Generics.Collections,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.CategoryButtons, Vcl.WinXCtrls,
  frame.titulo, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls;

type
  TfCadPadrao = class(TfPadrao)
    PageControl1: TPageControl;
    tabConsulta: TTabSheet;
    tabCadastro: TTabSheet;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    dsRegistro: TDataSource;
    tableRegistro: TFDMemTable;
    tableRegistroid: TIntegerField;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    aInserir: TAction;
    aAlterar: TAction;
    aCancelar: TAction;
    aSalvar: TAction;
    aExcluir: TAction;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Panel4: TPanel;
    lIDKey: TLabel;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure aInserirExecute(Sender: TObject);
    procedure aCancelarExecute(Sender: TObject);
    procedure aSalvarExecute(Sender: TObject);
    procedure aAlterarExecute(Sender: TObject);
    procedure aExcluirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AdicionarRegistroPadrao; virtual;
    procedure CarregarCampos; virtual; abstract;
    procedure LimparCampos; virtual; abstract;
    procedure SalvarCadastro; virtual; abstract;

  end;

implementation

{$R *.dfm}

procedure TfCadPadrao.aAlterarExecute(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage := tabCadastro;
  lidkey.caption := tableRegistroid.AsInteger.ToString;
  tableRegistro.Edit;
  CarregarCampos;
end;

procedure TfCadPadrao.aCancelarExecute(Sender: TObject);
begin
  inherited;
  tableRegistro.Cancel;
  PageControl1.ActivePage := tabConsulta;
  LimparCampos;
end;

procedure TfCadPadrao.AdicionarRegistroPadrao;
begin
  tableRegistro.Open;

  tableRegistro.Append;
  tableRegistroid.AsInteger := 1;
end;

procedure TfCadPadrao.aExcluirExecute(Sender: TObject);
begin
  inherited;
  if tableRegistro.IsEmpty then
    Exit;

  tableRegistro.Delete;
end;

procedure TfCadPadrao.aInserirExecute(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage := tabCadastro;
  lidkey.caption := integer(tableRegistro.RecordCount +1).ToString;
end;

procedure TfCadPadrao.aSalvarExecute(Sender: TObject);
begin
  SalvarCadastro;
  inherited;
  PageControl1.ActivePage := tabConsulta;
  LimparCampos;
end;

procedure TfCadPadrao.FormShow(Sender: TObject);
begin
  svMenu.Close;
  inherited;
  AdicionarRegistroPadrao;
  LimparCampos;
  PageControl1.ActivePage := tabConsulta;
end;

end.
