inherited fCadSprint: TfCadSprint
  Caption = 'fCadSprint'
  PixelsPerInch = 96
  TextHeight = 29
  inherited Frame11: TfTitulo
    inherited lTituloTela: TLabel
      Width = 186
      Caption = '<cadastroSprint>'
      ExplicitWidth = 186
    end
  end
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
        inherited Panel2: TPanel
          inherited SpeedButton2: TSpeedButton
            OnClick = nil
          end
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
        object Label3: TLabel [1]
          Left = 93
          Top = 95
          Width = 64
          Height = 29
          Alignment = taRightJustify
          Caption = 'In'#237'cio:'
        end
        object Label4: TLabel [2]
          Left = 111
          Top = 138
          Width = 46
          Height = 29
          Alignment = taRightJustify
          Caption = 'Fim:'
        end
        object Edit1: TEdit
          Left = 163
          Top = 44
          Width = 454
          Height = 37
          MaxLength = 50
          TabOrder = 2
          TextHint = 'Digite o nome da Sprint'
        end
        object DateTimePicker1: TDateTimePicker
          Left = 163
          Top = 87
          Width = 186
          Height = 37
          Date = 45073.000000000000000000
          Time = 0.480405729169433500
          TabOrder = 3
        end
        object DateTimePicker2: TDateTimePicker
          Left = 163
          Top = 130
          Width = 186
          Height = 37
          Date = 45073.000000000000000000
          Time = 0.480405729169433500
          TabOrder = 4
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
