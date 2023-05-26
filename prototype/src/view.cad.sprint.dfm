inherited fCadSprint: TfCadSprint
  Caption = 'fCadSprint'
  PixelsPerInch = 96
  TextHeight = 29
  inherited Panel1: TPanel
    inherited PageControl1: TPageControl
      inherited tabConsulta: TTabSheet
        inherited DBGrid1: TDBGrid
          Columns = <
            item
              Expanded = False
              FieldName = 'id'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Nome'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DataInicial'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DataFinal'
              Visible = True
            end>
        end
      end
      inherited tabCadastro: TTabSheet
        inherited Panel4: TPanel
          inherited lIDKey: TLabel
            ExplicitLeft = 163
            ExplicitTop = 3
            ExplicitHeight = 29
          end
        end
      end
    end
  end
  inherited tableRegistro: TFDMemTable
    object tableRegistroNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object tableRegistroDataInicial: TDateField
      FieldName = 'DataInicial'
    end
    object tableRegistroDataFinal: TDateField
      FieldName = 'DataFinal'
    end
  end
end
