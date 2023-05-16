object fraIncPesquisa: TfraIncPesquisa
  Left = 0
  Top = 0
  Width = 829
  Height = 93
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 829
    Height = 93
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 304
    ExplicitTop = 136
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 444
      Height = 93
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 0
      ExplicitWidth = 337
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 438
        Height = 13
        Align = alTop
        Caption = 'Digite sua pergunta aqui'
        ExplicitLeft = 4
        ExplicitTop = 4
        ExplicitWidth = 117
      end
      object Memo1: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 22
        Width = 438
        Height = 68
        Align = alClient
        TabOrder = 0
        ExplicitLeft = -32
        ExplicitTop = 17
        ExplicitWidth = 329
        ExplicitHeight = 72
      end
    end
    object Panel3: TPanel
      Left = 444
      Top = 0
      Width = 200
      Height = 93
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 1
      ExplicitLeft = 337
      object Label2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 194
        Height = 13
        Align = alTop
        Caption = 'Qual o tipo de resposta:'
        ExplicitLeft = 4
        ExplicitTop = 4
        ExplicitWidth = 116
      end
      object RadioGroup1: TRadioGroup
        AlignWithMargins = True
        Left = 3
        Top = 22
        Width = 194
        Height = 68
        Align = alClient
        Items.Strings = (
          'Texto'
          'Num'#233'rico'
          'Verdadeiro/Falso')
        TabOrder = 0
        ExplicitLeft = 32
        ExplicitWidth = 185
        ExplicitHeight = 105
      end
    end
    object Panel4: TPanel
      Left = 644
      Top = 0
      Width = 185
      Height = 93
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Panel4'
      ShowCaption = False
      TabOrder = 2
      ExplicitLeft = 560
      ExplicitTop = 24
      ExplicitHeight = 41
      object SpeedButton1: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 60
        Width = 179
        Height = 30
        Align = alBottom
        ExplicitLeft = 10
        ExplicitTop = 11
        ExplicitWidth = 175
      end
    end
  end
end
