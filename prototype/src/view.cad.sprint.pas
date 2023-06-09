unit view.cad.sprint;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, view.cad.padrao, Data.DB, lib.strings,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.CategoryButtons, Vcl.WinXCtrls, frame.titulo;

type
  TfCadSprint = class(TfCadPadrao)
    tableRegistroNome: TStringField;
    tableRegistroDataInicial: TDateField;
    tableRegistroDataFinal: TDateField;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
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

{ TfCadSprint }

procedure TfCadSprint.AdicionarRegistroPadrao;
begin
  inherited;

  tableRegistroNome.AsString := TLibStrings.ObterInstancia.PegarVersaoSprint;
  tableRegistroDataInicial.AsDateTime := Now();
  tableRegistroDataFinal.AsDateTime := Now()+14;
  tableRegistro.Post;
end;

procedure TfCadSprint.CarregarCampos;
begin
  inherited;
  edit1.Text := tableRegistroNome.AsString;
  DateTimePicker1.DateTime := tableRegistroDataInicial.AsDateTime;
  DateTimePicker2.DateTime := tableRegistroDataFinal.AsDateTime;
end;

procedure TfCadSprint.LimparCampos;
begin
  inherited;
  edit1.Text := EmptyStr;
  DateTimePicker1.DateTime := Now;
  DateTimePicker2.DateTime := Now;
end;

procedure TfCadSprint.SalvarCadastro;
begin
  inherited;
  if not (tableRegistro.State in [dsEdit]) then
  begin
    tableRegistro.Append;
    tableRegistroid.AsInteger := strtoInt(lIDKey.Caption);
  end;

  tableRegistroNome.AsString := edit1.Text;
  tableRegistroDataInicial.AsDateTime := DateTimePicker1.DateTime;
  tableRegistroDataFinal.AsDateTime := DateTimePicker2.DateTime;
  tableRegistro.Post;
end;

end.
