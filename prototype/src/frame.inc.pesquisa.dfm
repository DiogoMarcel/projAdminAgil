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
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 438
        Height = 13
        Align = alTop
        Caption = 'Digite sua pergunta aqui'
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
      object Label2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 194
        Height = 13
        Align = alTop
        Caption = 'Qual o tipo de resposta:'
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
      DesignSize = (
        185
        93)
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
      object Label3: TLabel
        Left = 20
        Top = 3
        Width = 32
        Height = 13
        Caption = 'Equipe'
      end
      object ComboBox1: TComboBox
        Left = 20
        Top = 22
        Width = 145
        Height = 21
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemIndex = 0
        TabOrder = 0
        Text = 'The Big Bang'
        Items.Strings = (
          'The Big Bang'
          'Midas')
      end
    end
  end
end
