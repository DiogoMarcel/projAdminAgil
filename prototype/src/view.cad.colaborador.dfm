inherited fCadColaborador: TfCadColaborador
  Caption = 'fCadColaborador'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 29
  inherited Frame11: TfTitulo
    inherited Label1: TLabel
      Height = 40
    end
    inherited lTituloTela: TLabel
      Width = 199
      Height = 40
      Caption = '<cadColaborador>'
      ExplicitWidth = 199
    end
  end
  inherited Panel1: TPanel
    inherited PageControl1: TPageControl
      ActivePage = tabCards
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
            end
            item
              Expanded = False
              FieldName = 'usuario'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'senha'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'gerenciaPesquisa'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'gerenciaColaborador'
              Visible = True
            end>
        end
        inherited Panel2: TPanel
          object SpeedButton6: TSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 45
            Height = 44
            Action = aCards
            Align = alLeft
            ImageIndex = 12
            ImageName = 'card-icon'
            Images = dataImages.iListImages
            Flat = True
            ExplicitLeft = 739
            ExplicitTop = 6
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
          Left = 69
          Top = 95
          Width = 88
          Height = 29
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio:'
        end
        object Label4: TLabel [2]
          Left = 84
          Top = 138
          Width = 73
          Height = 29
          Alignment = taRightJustify
          Caption = 'Senha:'
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
          TextHint = 'Digite o nome do Colaborador'
        end
        object Edit2: TEdit
          Left = 163
          Top = 87
          Width = 454
          Height = 37
          MaxLength = 50
          TabOrder = 3
          TextHint = 'Digite o usu'#225'rio'
        end
        object Edit3: TEdit
          Left = 163
          Top = 130
          Width = 454
          Height = 37
          MaxLength = 50
          TabOrder = 4
          TextHint = 'Digite a senha'
        end
        object RadioGroup1: TRadioGroup
          Left = 163
          Top = 173
          Width = 313
          Height = 105
          Caption = 'Gerencia Pesquisa'
          Columns = 2
          Items.Strings = (
            'N'#227'o'
            'Sim')
          TabOrder = 5
        end
        object RadioGroup2: TRadioGroup
          Left = 163
          Top = 284
          Width = 313
          Height = 105
          Caption = 'Gerencia Colaborador'
          Columns = 2
          Items.Strings = (
            'N'#227'o'
            'Sim')
          TabOrder = 6
        end
      end
      object tabCards: TTabSheet
        Caption = 'Cards'
        ImageIndex = 2
        object FlowPanel1: TFlowPanel
          Left = 0
          Top = 0
          Width = 840
          Height = 585
          Align = alClient
          BevelOuter = bvNone
          Caption = 'FlowPanel1'
          ShowCaption = False
          TabOrder = 0
        end
      end
    end
  end
  inherited ActionList1: TActionList
    object aCards: TAction
      Category = 'NoCadastro'
      OnExecute = aCardsExecute
    end
  end
  inherited tableRegistro: TFDMemTable
    object tableRegistronome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object tableRegistrousuario: TStringField
      FieldName = 'usuario'
      Size = 50
    end
    object tableRegistrosenha: TStringField
      FieldName = 'senha'
      Size = 50
    end
    object tableRegistrogerenciaPesquisa: TBooleanField
      FieldName = 'gerenciaPesquisa'
    end
    object tableRegistrogerenciaColaborador: TBooleanField
      FieldName = 'gerenciaColaborador'
    end
  end
end
