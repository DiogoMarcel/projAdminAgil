inherited fCadPadrao: TfCadPadrao
  Caption = 'fCadPadrao'
  PixelsPerInch = 96
  TextHeight = 29
  inherited Frame11: TfTitulo
    inherited Label1: TLabel
      Height = 40
    end
    inherited lTituloTela: TLabel
      Height = 40
    end
  end
  inherited Panel1: TPanel
    object PageControl1: TPageControl
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 848
      Height = 629
      ActivePage = tabConsulta
      Align = alClient
      MultiLine = True
      TabOrder = 0
      object tabConsulta: TTabSheet
        Caption = 'Consulta'
        object DBGrid1: TDBGrid
          Left = 0
          Top = 0
          Width = 840
          Height = 529
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsRegistro
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -24
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'id'
              Visible = True
            end>
        end
        object Panel2: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 532
          Width = 834
          Height = 50
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'Panel2'
          ShowCaption = False
          TabOrder = 1
          object SpeedButton2: TSpeedButton
            AlignWithMargins = True
            Left = 786
            Top = 3
            Width = 45
            Height = 44
            Action = aExcluir
            Align = alRight
            ImageIndex = 8
            ImageName = 'lixeira'
            Images = dataImages.iListImages
            Flat = True
            ExplicitLeft = 794
            ExplicitHeight = 41
          end
          object SpeedButton4: TSpeedButton
            AlignWithMargins = True
            Left = 684
            Top = 3
            Width = 45
            Height = 44
            Action = aAlterar
            Align = alRight
            ImageIndex = 9
            ImageName = 'editar'
            Images = dataImages.iListImages
            Flat = True
            ExplicitLeft = 739
            ExplicitTop = 6
          end
          object SpeedButton5: TSpeedButton
            AlignWithMargins = True
            Left = 735
            Top = 3
            Width = 45
            Height = 44
            Action = aInserir
            Align = alRight
            ImageIndex = 10
            ImageName = 'incluir'
            Images = dataImages.iListImages
            Flat = True
            ExplicitLeft = 739
            ExplicitTop = 6
          end
        end
      end
      object tabCadastro: TTabSheet
        Caption = 'Cadastro'
        ImageIndex = 1
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 532
          Width = 834
          Height = 50
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'Panel3'
          ShowCaption = False
          TabOrder = 0
          object SpeedButton1: TSpeedButton
            AlignWithMargins = True
            Left = 786
            Top = 3
            Width = 45
            Height = 44
            Action = aSalvar
            Align = alRight
            ImageIndex = 7
            ImageName = 'save-icon-icons-png'
            Images = dataImages.iListImages
            Flat = True
            ExplicitLeft = 785
            ExplicitTop = 6
          end
          object SpeedButton3: TSpeedButton
            AlignWithMargins = True
            Left = 735
            Top = 3
            Width = 45
            Height = 44
            Action = aCancelar
            Align = alRight
            ImageIndex = 11
            ImageName = 'cancelar'
            Images = dataImages.iListImages
            Flat = True
            ExplicitLeft = 794
            ExplicitHeight = 41
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 840
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel4'
          ShowCaption = False
          TabOrder = 1
          object lIDKey: TLabel
            AlignWithMargins = True
            Left = 163
            Top = 3
            Width = 69
            Height = 35
            Align = alLeft
            Alignment = taRightJustify
            Caption = 'lIDKey'
            Layout = tlCenter
            ExplicitHeight = 29
          end
          object Label1: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 154
            Height = 35
            Align = alLeft
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'digo:'
            Layout = tlCenter
          end
        end
      end
    end
  end
  inherited ActionList1: TActionList
    object aInserir: TAction
      Category = 'NoCadastro'
      OnExecute = aInserirExecute
    end
    object aAlterar: TAction
      Category = 'NoCadastro'
      OnExecute = aAlterarExecute
    end
    object aCancelar: TAction
      Category = 'NoCadastro'
      OnExecute = aCancelarExecute
    end
    object aSalvar: TAction
      Category = 'NoCadastro'
      OnExecute = aSalvarExecute
    end
    object aExcluir: TAction
      Category = 'NoCadastro'
      OnExecute = aExcluirExecute
    end
  end
  object dsRegistro: TDataSource
    DataSet = tableRegistro
    Left = 257
    Top = 3
  end
  object tableRegistro: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 313
    Top = 3
    object tableRegistroid: TIntegerField
      FieldName = 'id'
    end
  end
end
