inherited fPesquisaGerente: TfPesquisaGerente
  Caption = 'fPesquisaGerente'
  OnDestroy = FormDestroy
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
  inherited svMenu: TSplitView
    UseAnimation = False
  end
  inherited svUser: TSplitView
    UseAnimation = False
  end
  inherited Panel1: TPanel
    ExplicitLeft = 354
    ExplicitTop = 176
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
        ExplicitWidth = 163
        ExplicitHeight = 29
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 854
        ExplicitHeight = 145
        inherited Panel2: TPanel
          Width = 389
          Height = 145
          ExplicitWidth = 389
          ExplicitHeight = 145
          inherited Label1: TLabel
            Width = 383
            Height = 29
            ExplicitWidth = 260
            ExplicitHeight = 29
          end
          inherited Memo1: TMemo
            Top = 38
            Width = 383
            Height = 104
            ExplicitLeft = 3
            ExplicitTop = 38
            ExplicitWidth = 383
            ExplicitHeight = 104
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
            Height = 29
            ExplicitWidth = 257
            ExplicitHeight = 29
          end
          inherited RadioGroup1: TRadioGroup
            Top = 38
            Width = 274
            Height = 104
            ExplicitLeft = 3
            ExplicitTop = 38
            ExplicitWidth = 274
            ExplicitHeight = 104
          end
        end
        inherited Panel4: TPanel
          Left = 669
          Height = 145
          ExplicitLeft = 669
          ExplicitTop = 0
          ExplicitHeight = 145
          inherited SpeedButton1: TSpeedButton
            Top = 112
            Action = aIncPesquisa
            ExplicitLeft = 6
            ExplicitTop = 76
            ExplicitWidth = 179
          end
        end
      end
    end
    object FlowPanel1: TFlowPanel
      AlignWithMargins = True
      Left = 15
      Top = 188
      Width = 836
      Height = 444
      Margins.Left = 15
      Align = alClient
      BevelOuter = bvNone
      Caption = 'FlowPanel1'
      FlowStyle = fsTopBottomLeftRight
      Locked = True
      ShowCaption = False
      TabOrder = 2
      ExplicitLeft = 0
      ExplicitTop = 48
      ExplicitWidth = 854
      ExplicitHeight = 296
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
  end
end
