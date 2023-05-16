object fraItemPesquisa: TfraItemPesquisa
  Left = 0
  Top = 0
  Width = 725
  Height = 100
  TabOrder = 0
  object Panel1: TPanel
    Left = 672
    Top = 0
    Width = 53
    Height = 100
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 88
    object SpeedButton2: TSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 57
      Width = 47
      Height = 40
      Align = alBottom
      ImageIndex = 8
      ImageName = 'lixeira'
      Images = dataImages.iListImages
      Flat = True
      OnClick = SpeedButton2Click
      ExplicitLeft = 96
      ExplicitTop = 44
      ExplicitWidth = 40
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 100
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 120
    ExplicitTop = 56
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 672
      Height = 13
      Align = alTop
      Caption = 'Label1'
      WordWrap = True
      ExplicitWidth = 31
    end
    object pVerdadeiro: TPanel
      Left = 529
      Top = 13
      Width = 96
      Height = 87
      Align = alLeft
      AutoSize = True
      BevelOuter = bvNone
      Caption = 'pVerdadeiro'
      ShowCaption = False
      TabOrder = 0
      ExplicitLeft = 521
      object RadioGroup1: TRadioGroup
        Left = 0
        Top = 0
        Width = 96
        Height = 87
        Align = alClient
        Items.Strings = (
          'Sim'
          'N'#227'o')
        TabOrder = 0
        ExplicitLeft = 32
        ExplicitWidth = 153
      end
    end
    object pTexto: TPanel
      Left = 0
      Top = 13
      Width = 366
      Height = 87
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 1
      ExplicitLeft = -22
      ExplicitTop = 6
      ExplicitHeight = 75
      object Edit2: TEdit
        Left = 0
        Top = 0
        Width = 366
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        TabOrder = 0
        ExplicitLeft = 15
        ExplicitTop = 34
        ExplicitWidth = 337
      end
    end
    object pNumerico: TPanel
      Left = 366
      Top = 13
      Width = 163
      Height = 87
      Align = alLeft
      AutoSize = True
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 2
      object Edit3: TEdit
        Left = 0
        Top = 0
        Width = 163
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        TabOrder = 0
        Text = '0,00'
        ExplicitWidth = 135
      end
    end
  end
end
