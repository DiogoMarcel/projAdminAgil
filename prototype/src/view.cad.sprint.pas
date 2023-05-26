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
  private
    { Private declarations }
  public
    procedure AdicionarRegistroPadrao; override;

  end;

implementation

{$R *.dfm}

{ TfCadSprint }

procedure TfCadSprint.AdicionarRegistroPadrao;
begin
  inherited;
  tableRegistro.Open;

  tableRegistro.Append;
  tableRegistroid.AsInteger := 1;
  tableRegistroNome.AsString := TLibStrings.ObterInstancia.PegarVersaoSprint;
  tableRegistroDataInicial.AsDateTime := Now();
  tableRegistroDataFinal.AsDateTime := Now()+14;
  tableRegistro.Post;
end;

end.
