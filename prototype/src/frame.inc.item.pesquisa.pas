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
    SpeedButton2: TSpeedButton;
    pVerdadeiro: TPanel;
    pTexto: TPanel;
    Edit2: TEdit;
    pNumerico: TPanel;
    Edit3: TEdit;
    RadioGroup1: TRadioGroup;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
