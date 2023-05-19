unit frame.inc.item.pesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, data.images,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TfraItemPesquisa = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    pVerdadeiro: TPanel;
    pTexto: TPanel;
    Edit2: TEdit;
    pNumerico: TPanel;
    Edit3: TEdit;
    RadioGroup1: TRadioGroup;
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfraItemPesquisa.SpeedButton2Click(Sender: TObject);
begin
  //
end;

end.
