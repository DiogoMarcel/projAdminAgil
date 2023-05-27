inherited fMenu: TfMenu
  Caption = 'fMenu'
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
  inherited ActionList1: TActionList
    inherited aCadEmpresa: TAction
      OnExecute = aCadEmpresaExecute
    end
    inherited aCadCargo: TAction
      OnExecute = aCadCargoExecute
    end
    inherited aCadFuncao: TAction
      OnExecute = aCadFuncaoExecute
    end
    inherited aCadEquipe: TAction
      OnExecute = aCadEquipeExecute
    end
    inherited aCadSprint: TAction
      OnExecute = aCadSprintExecute
    end
  end
end
