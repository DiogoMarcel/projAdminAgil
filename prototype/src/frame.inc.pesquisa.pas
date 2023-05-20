unit frame.inc.pesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfraIncPesquisa = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Memo1: TMemo;
    Panel3: TPanel;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    ComboBox1: TComboBox;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
