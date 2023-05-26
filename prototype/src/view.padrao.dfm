inherited fPadrao: TfPadrao
  ClientHeight = 675
  ClientWidth = 1106
  ExplicitWidth = 1112
  ExplicitHeight = 704
  PixelsPerInch = 96
  TextHeight = 29
  inline Frame11: TfTitulo
    Left = 0
    Top = 0
    Width = 1106
    Height = 40
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 1106
    ExplicitHeight = 40
    inherited Label1: TLabel
      Width = 86
      Height = 40
      ParentFont = True
      ExplicitWidth = 86
      ExplicitHeight = 29
    end
    inherited lTituloTela: TLabel
      Left = 146
      Width = 9
      Height = 40
      ExplicitLeft = 146
      ExplicitWidth = 9
      ExplicitHeight = 29
    end
    inherited SpeedButton1: TSpeedButton
      Height = 40
      OnClick = Frame11SpeedButton1Click
      ExplicitHeight = 40
    end
    inherited SpeedButton2: TSpeedButton
      Left = 1061
      Height = 40
      OnClick = Frame11SpeedButton2Click
      ExplicitLeft = 1061
      ExplicitHeight = 40
    end
  end
  object svMenu: TSplitView
    Left = 0
    Top = 40
    Width = 250
    Height = 635
    OpenedWidth = 250
    ParentBackground = True
    ParentColor = True
    ParentDoubleBuffered = True
    Placement = svpLeft
    TabOrder = 1
    OnClosed = svMenuClosed
    OnOpened = svMenuOpened
    OnOpening = svMenuOpening
    object cbMenu: TCategoryButtons
      Left = 0
      Top = 0
      Width = 250
      Height = 449
      Align = alTop
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ButtonFlow = cbfVertical
      ButtonHeight = 40
      ButtonOptions = [boFullSize, boGradientFill, boShowCaptions]
      Categories = <>
      RegularButtonColor = clWhite
      SelectedButtonColor = 15132390
      TabOrder = 0
    end
  end
  object svUser: TSplitView
    AlignWithMargins = True
    Left = 1105
    Top = 41
    Width = 0
    Height = 633
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    BiDiMode = bdRightToLeft
    DockSite = True
    Locked = True
    Opened = False
    OpenedWidth = 200
    ParentBiDiMode = False
    ParentBackground = True
    ParentColor = True
    Placement = svpRight
    TabOrder = 2
    object cbUser: TCategoryButtons
      Left = 0
      Top = 0
      Width = 0
      Height = 233
      Align = alTop
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ButtonFlow = cbfVertical
      ButtonHeight = 40
      ButtonOptions = [boFullSize, boGradientFill, boShowCaptions]
      Categories = <>
      RegularButtonColor = clWhite
      SelectedButtonColor = 15132390
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 250
    Top = 40
    Width = 854
    Height = 635
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 3
  end
  object ActionList1: TActionList
    Left = 176
    object aPesquisa: TAction
      Category = 'Menu'
      Caption = '<aPesquisa>'
      OnExecute = aPesquisaExecute
    end
    object aPesquisaSM: TAction
      Category = 'Menu'
      Caption = '<aPesquisaSM>'
      OnExecute = aPesquisaSMExecute
    end
    object aCerimonia: TAction
      Category = 'Menu'
      Caption = '<aCerimonia>'
      OnExecute = aCerimoniaExecute
    end
    object aConfigUser: TAction
      Caption = '<aConfigUser>'
      OnExecute = aConfigUserExecute
    end
    object aCadEmpresa: TAction
      Category = 'Cadastros'
      Caption = '<aCadEmpresa>'
    end
    object aCadCargo: TAction
      Category = 'Cadastros'
      Caption = '<aCadCargo>'
    end
    object aCadFuncao: TAction
      Category = 'Cadastros'
      Caption = '<aCadFuncao>'
    end
    object aCadEquipe: TAction
      Category = 'Cadastros'
      Caption = '<aCadEquipe>'
    end
    object aCadColaborador: TAction
      Category = 'Cadastros'
      Caption = '<aCadColaborador>'
    end
    object aCadSprint: TAction
      Category = 'Cadastros'
      Caption = '<aCadSprint>'
    end
  end
end
