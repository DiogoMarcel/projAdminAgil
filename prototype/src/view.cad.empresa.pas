unit view.cad.empresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, view.cad.padrao, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.CategoryButtons, Vcl.WinXCtrls, frame.titulo;

type
  TfCadEmpresa = class(TfCadPadrao)
    tableRegistronome: TStringField;
    Label2: TLabel;
    Edit1: TEdit;
  private
    { Private declarations }
  public
    procedure AdicionarRegistroPadrao; override;
    procedure CarregarCampos; override;
    procedure LimparCampos; override;
    procedure SalvarCadastro; override;
  end;

implementation

{$R *.dfm}

{ TfCadEmpresa }

procedure TfCadEmpresa.AdicionarRegistroPadrao;
begin
  inherited;
  tableRegistroNome.AsString := 'Empresa Padrão';
  tableRegistro.Post;
end;

procedure TfCadEmpresa.CarregarCampos;
begin
  inherited;
  edit1.Text := tableRegistroNome.AsString;
end;

procedure TfCadEmpresa.LimparCampos;
begin
  inherited;
  edit1.Text := EmptyStr;
end;

procedure TfCadEmpresa.SalvarCadastro;
begin
  inherited;
  if not (tableRegistro.State in [dsEdit]) then
  begin
    tableRegistro.Append;
    tableRegistroid.AsInteger := strtoInt(lIDKey.Caption);
  end;

  tableRegistroNome.AsString := edit1.Text;
  tableRegistro.Post;
end;

end.
