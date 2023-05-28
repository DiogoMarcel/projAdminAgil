unit lib.utils;

interface

type
  ILibUtil = interface
    ['{A6679B03-581E-4A5E-8704-4C2CCAD11F69}']
    //function IfThen<T>(Condicao: boolean; SeTrue, SeFalse: T): T;
  end;

  TLibUtil = class
  public
    class function IfThen<T>(Condicao: boolean; ResultadoTrue, ResultadoFalse: T): T;
  end;

implementation

{ TLibUtil }

class function TLibUtil.IfThen<T>(Condicao: boolean; ResultadoTrue, ResultadoFalse: T): T;
begin
  if Condicao then
    Result := ResultadoTrue
  else
    Result := ResultadoFalse;
end;

end.
