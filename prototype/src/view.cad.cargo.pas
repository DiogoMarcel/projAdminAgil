unit view.cad.cargo;

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
  TfCadCargo = class(TfCadPadrao)
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

{ TfCadCargo }

procedure TfCadCargo.AdicionarRegistroPadrao;
begin
  inherited;
  tableRegistroNome.AsString := 'Desenvolvedor';
  tableRegistro.Post;

  tableRegistro.Append;
  tableRegistroid.AsInteger := tableRegistro.RecordCount +1;
  tableRegistronome.AsString := 'Analista';
  tableRegistro.post;
end;

procedure TfCadCargo.CarregarCampos;
begin
  inherited;
  edit1.Text := tableRegistroNome.AsString;
end;

procedure TfCadCargo.LimparCampos;
begin
  inherited;
  edit1.Text := EmptyStr;
end;

procedure TfCadCargo.SalvarCadastro;
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
