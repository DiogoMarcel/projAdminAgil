inherited fCadEmpresa: TfCadEmpresa
  Caption = 'fCadEmpresa'
  PixelsPerInch = 96
  TextHeight = 29
  inherited Frame11: TfTitulo
    inherited Label1: TLabel
      Height = 40
    end
    inherited lTituloTela: TLabel
      Width = 163
      Height = 40
      Caption = '<cadEmpresa>'
      ExplicitWidth = 163
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
        inherited Panel4: TPanel
          inherited lIDKey: TLabel
            Height = 35
          end
        end
        object Edit1: TEdit
          Left = 163
          Top = 44
          Width = 454
          Height = 37
          MaxLength = 50
          TabOrder = 2
          TextHint = 'Digite o nome da Empresa'
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
