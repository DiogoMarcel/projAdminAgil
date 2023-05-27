unit view.padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, view.geral, frame.titulo,
  Vcl.CategoryButtons, Vcl.ExtCtrls, Vcl.WinXCtrls, System.Actions,
  System.Classes, Vcl.Graphics, Vcl.ActnList, Vcl.Buttons;

type
  TfPadrao = class(TfGeral)
    Frame11: TfTitulo;
    svMenu: TSplitView;
    cbMenu: TCategoryButtons;
    ActionList1: TActionList;
    aPesquisa: TAction;
    aPesquisaSM: TAction;
    aCerimonia: TAction;
    svUser: TSplitView;
    aConfigUser: TAction;
    cbUser: TCategoryButtons;
    Panel1: TPanel;
    aCadEmpresa: TAction;
    aCadCargo: TAction;
    aCadFuncao: TAction;
    aCadEquipe: TAction;
    aCadColaborador: TAction;
    aCadSprint: TAction;
    procedure FormShow(Sender: TObject);
    procedure aCerimoniaExecute(Sender: TObject);
    procedure aPesquisaExecute(Sender: TObject);
    procedure aPesquisaSMExecute(Sender: TObject);
    procedure aConfigUserExecute(Sender: TObject);
    procedure svMenuClosed(Sender: TObject);
    procedure svMenuOpened(Sender: TObject);
    procedure svMenuOpening(Sender: TObject);
    procedure ChamaSubMenu(aMenu, aSubMenuBt: TCategoryButtons ; aRect: TRect ) ;
    procedure Frame11SpeedButton2Click(Sender: TObject);
    procedure Frame11SpeedButton1Click(Sender: TObject);
    procedure aCadColaboradorExecute(Sender: TObject);
  private
    {FRec: TRect;}

    procedure AdicionarCategoriasMenu;
    procedure AdicionarCategoriasUsuario;

  protected
    procedure AbrirTelaSelf(aClassSelf: TfPadrao);

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfPadrao.AbrirTelaSelf(aClassSelf: TfPadrao);
begin
  try
    aClassSelf.ShowModal;
  finally
    FreeAndNil(aClassSelf);
  end;
end;

procedure TfPadrao.aCadColaboradorExecute(Sender: TObject);
begin
  inherited;
  Showmessage('aCadColaboradorExecute');
end;

procedure TfPadrao.aCerimoniaExecute(Sender: TObject);
begin
  inherited;
  Showmessage('aCerimoniaExecute');
end;

procedure TfPadrao.aConfigUserExecute(Sender: TObject);
begin
  inherited;
  Showmessage('aConfigUser');
end;

procedure TfPadrao.AdicionarCategoriasMenu;
begin
  with cbMenu.Categories.Add do
  begin
    Caption := '<menu_index_1>';
    with Items do
    begin
      Add.Action := aCadEmpresa;
      Add.Action := aCadCargo;
      Add.Action := aCadFuncao;
      Add.Action := aCadEquipe;
      Add.Action := aCadColaborador;
      Add.Action := aCadSprint;
    end;
  end;

  with cbMenu.Categories.Add do
  begin
    Caption := '<menu_index_0>';
    with Items do
    begin
      Add.Action := aPesquisaSM;
      Add.Action := aPesquisa;
      Add.Action := aCerimonia;
    end;
  end;

  cbMenu.Refresh;
end;

procedure TfPadrao.AdicionarCategoriasUsuario;
begin
  with cbUser.Categories.Add do
  begin
    Caption := '<user_index_0>';
    with Items do
    begin
      Add.Action := aConfigUser;
    end;
  end;

  cbUser.Refresh;
end;

procedure TfPadrao.aPesquisaExecute(Sender: TObject);
begin
  inherited;
  Showmessage('aPesquisaExecute');
end;

procedure TfPadrao.aPesquisaSMExecute(Sender: TObject);
begin
  inherited;
  Showmessage('aPesquisaSMExecute');
end;

procedure TfPadrao.FormShow(Sender: TObject);
begin
  AdicionarCategoriasMenu;
  AdicionarCategoriasUsuario;

  inherited;

  Self.Refresh;
end;

procedure TfPadrao.Frame11SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if svMenu.Opened then
    svMenu.Close
  else
    svMenu.Open;
end;

procedure TfPadrao.Frame11SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if svUser.Opened then
    svUser.Close
  else
    svUser.Open;
end;

procedure TfPadrao.svMenuClosed(Sender: TObject);
begin
  inherited;
  // When TSplitView is closed, adjust ButtonOptions and Width
  cbMenu.ButtonOptions := cbMenu.ButtonOptions - [boShowCaptions];
  if svMenu.CloseStyle = svcCompact then
    cbMenu.Width := svMenu.CompactWidth;
end;

procedure TfPadrao.svMenuOpened(Sender: TObject);
begin
  inherited;
  // When not animating, change size of cbMenu when TSplitView is opened
  cbMenu.ButtonOptions := cbMenu.ButtonOptions + [boShowCaptions];
  cbMenu.Width         := svMenu.OpenedWidth;
end;

procedure TfPadrao.svMenuOpening(Sender: TObject);
begin
  inherited;
  // When animating, change size of cbMenu at the beginning of open
  cbMenu.ButtonOptions := cbMenu.ButtonOptions + [boShowCaptions];
  cbMenu.Width := svMenu.OpenedWidth;
end;

procedure TfPadrao.ChamaSubMenu(aMenu, aSubMenuBt: TCategoryButtons; aRect: TRect);
var
  I: integer ;
begin
  // usar a Tag do SubMenu para Fechar quando abrir um Outro SubMenu
  for I:= 0 to ComponentCount -1 do
  begin
    if ( Components[I] is TCategoryButtons )  then
    begin
      if ( TCategoryButtons(Components[I]).Tag = 1 ) then
        TCategoryButtons(Components[I]).Visible := false  ;
    end;
  end;

  ARect := aMenu
             .Categories
               .CategoryButtons
                 .GetButtonRect(
                    aMenu.Categories.CategoryButtons.SelectedItem
                 );

  aSubMenuBt.Left    := aMenu.Categories[0].Items[0].CategoryButtons.width -
                        aMenu.Categories[0].Items[0].CategoryButtons.width ;

  aSubMenuBt.Top     := ARect.Top ;
  aSubMenuBt.Visible := true ;

  aSubMenuBt.Show ;
end;

end.
