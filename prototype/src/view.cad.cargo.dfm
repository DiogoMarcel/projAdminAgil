inherited fCadCargo: TfCadCargo
  Caption = 'fCadCargo'
  PixelsPerInch = 96
  TextHeight = 29
  inherited Frame11: TfTitulo
    inherited lTituloTela: TLabel
      Width = 133
      Caption = '<cadCargo>'
      ExplicitWidth = 133
    end
  end
  inherited Panel1: TPanel
    inherited PageControl1: TPageControl
      ActivePage = tabCadastro
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
              FieldName = 'nome'
              Visible = True
            end>
        end
      end
      inherited tabCadastro: TTabSheet
        object Label2: TLabel [0]
          Left = 87
          Top = 52
          Width = 70
          Height = 29
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object Edit1: TEdit
          Left = 163
          Top = 44
          Width = 454
          Height = 37
          MaxLength = 50
          TabOrder = 2
          TextHint = 'Digite o nome da Cargo'
        end
      end
    end
  end
  inherited tableRegistro: TFDMemTable
    object tableRegistronome: TStringField
      FieldName = 'nome'
      Size = 50
    end
  end
end
