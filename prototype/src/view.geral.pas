unit view.geral;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.ActnList, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, Vcl.CategoryButtons, Vcl.StdCtrls,
  lib.strings, Vcl.Buttons;

type
  TfGeral = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    libString: iLibStrings;

    procedure AjustarComponentesRecursivo(aComponent: TComponent);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfGeral.AjustarComponentesRecursivo(aComponent: TComponent);
var
  J, I: integer;
begin
  for I := 0 to aComponent.ComponentCount - 1 do
  begin
    if (aComponent.Components[I] is TLabel) then
      libString.ConverterLabel(TLabel(aComponent.Components[I]))
    else if (aComponent.Components[I] is TSpeedButton) then
      libString.ConverterSpeedButton(TSpeedButton(aComponent.Components[I]))
    else if (aComponent.Components[I] is TAction) then
      libString.ConverterAction(TAction(aComponent.Components[I]))
    else if (aComponent.Components[I] is TFrame) then
      AjustarComponentesRecursivo(TFrame(aComponent.Components[I]))
    else if (aComponent.Components[I] is TCategoryButtons) then
    begin
      with TCategoryButtons(aComponent.Components[I]).Categories do
      begin
        for J := 0 to Count -1 do
          libString.ConverterButtonCategory(TButtonCategory(Items[J]));
      end;
    end;
  end;
end;

procedure TfGeral.FormShow(Sender: TObject);
begin
  libString := TLibStrings.ObterInstancia;

  Self.Caption := libString.PegarTituloSistema;
  AjustarComponentesRecursivo(Self);
end;

end.
