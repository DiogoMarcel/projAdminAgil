inherited fPesquisaGerente: TfPesquisaGerente
  Caption = 'fPesquisaGerente'
  Font.Height = -20
  PixelsPerInch = 96
  TextHeight = 24
  inherited Frame11: TfTitulo
    inherited Label1: TLabel
      Width = 76
      Height = 40
      ExplicitWidth = 76
      ExplicitHeight = 24
    end
    inherited lTituloTela: TLabel
      Left = 136
      Width = 7
      Height = 40
      ExplicitLeft = 136
      ExplicitWidth = 7
      ExplicitHeight = 24
    end
  end
  inherited svMenu: TSplitView
    UseAnimation = False
  end
  inherited svUser: TSplitView
    UseAnimation = False
  end
  inherited Panel1: TPanel
    ExplicitLeft = 250
    inline fraSprint1: TfraSprint
      Left = 0
      Top = 0
      Width = 854
      Height = 40
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 854
      inherited SpeedButton1: TSpeedButton
        ExplicitLeft = 0
        ExplicitTop = -21
        ExplicitHeight = 34
      end
      inherited Label6: TLabel
        AlignWithMargins = True
        Left = 43
        Top = 3
        Width = 768
        Height = 34
        ExplicitLeft = 43
        ExplicitTop = 3
        ExplicitWidth = 138
        ExplicitHeight = 24
      end
      inherited SpeedButton2: TSpeedButton
        Left = 814
        ExplicitLeft = 814
      end
    end
    inline fraIncPesquisa1: TfraIncPesquisa
      Left = 0
      Top = 40
      Width = 854
      Height = 145
      Align = alTop
      TabOrder = 1
      ExplicitTop = 40
      ExplicitWidth = 854
      ExplicitHeight = 145
      inherited Panel1: TPanel
        Width = 854
        Height = 145
        ExplicitWidth = 854
        ExplicitHeight = 145
        inherited Panel2: TPanel
          Width = 389
          Height = 145
          ExplicitWidth = 389
          ExplicitHeight = 145
          inherited Label1: TLabel
            Width = 383
            Height = 24
            ExplicitWidth = 220
            ExplicitHeight = 24
          end
          inherited Memo1: TMemo
            Top = 33
            Width = 383
            Height = 109
            ExplicitTop = 33
            ExplicitWidth = 383
            ExplicitHeight = 109
          end
        end
        inherited Panel3: TPanel
          Left = 389
          Width = 280
          Height = 145
          ExplicitLeft = 389
          ExplicitWidth = 280
          ExplicitHeight = 145
          inherited Label2: TLabel
            Width = 274
            Height = 24
            ExplicitWidth = 215
            ExplicitHeight = 24
          end
          inherited RadioGroup1: TRadioGroup
            Top = 33
            Width = 274
            Height = 109
            ExplicitTop = 33
            ExplicitWidth = 274
            ExplicitHeight = 109
          end
        end
        inherited Panel4: TPanel
          Left = 669
          Height = 145
          ExplicitLeft = 669
          ExplicitHeight = 145
          inherited SpeedButton1: TSpeedButton
            Top = 112
            Action = aIncPesquisa
            ExplicitLeft = 6
            ExplicitTop = 76
            ExplicitWidth = 179
          end
          inherited Label3: TLabel
            Width = 60
            Height = 24
            ExplicitWidth = 60
            ExplicitHeight = 24
          end
          inherited ComboBox1: TComboBox
            Top = 38
            Height = 32
            Font.Height = -20
            ParentFont = False
            ExplicitTop = 38
            ExplicitHeight = 32
          end
        end
      end
    end
    object FlowPanel1: TFlowPanel
      AlignWithMargins = True
      Left = 15
      Top = 200
      Width = 836
      Height = 432
      Margins.Left = 15
      Margins.Top = 15
      Align = alClient
      BevelOuter = bvNone
      Caption = 'FlowPanel1'
      FlowStyle = fsTopBottomLeftRight
      Locked = True
      ShowCaption = False
      TabOrder = 2
    end
  end
  inherited ActionList1: TActionList
    object aIncPesquisa: TAction
      Category = 'Menu'
      Caption = '<incPesquisa>'
      OnExecute = aIncPesquisaExecute
    end
    object aDelPesquisa: TAction
      Category = 'Menu'
      Caption = 'aDelPesquisa'
      OnExecute = aDelPesquisaExecute
    end
    object aEdtPesquisa: TAction
      Category = 'Menu'
      Caption = 'aEdtPesquisa'
      OnExecute = aEdtPesquisaExecute
    end
  end
end
