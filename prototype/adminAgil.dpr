program adminAgil;

uses
  Vcl.Forms,
  view.geral in 'src\view.geral.pas' {fGeral},
  view.padrao in 'src\view.padrao.pas' {fPadrao},
  view.menu in 'src\view.menu.pas' {fMenu},
  view.login in 'src\view.login.pas' {fLogin},
  Vcl.Themes,
  Vcl.Styles,
  data.images in 'src\data.images.pas' {dataImages: TDataModule},
  frame.titulo in 'src\frame.titulo.pas' {fTitulo: TFrame},
  lib.strings in 'src\lib.strings.pas',
  view.pesquisa in 'src\view.pesquisa.pas' {fPesquisa},
  frame.sprint in 'src\frame.sprint.pas' {fraSprint: TFrame},
  view.pesquisa.gerente in 'src\view.pesquisa.gerente.pas' {fPesquisaGerente},
  frame.inc.pesquisa in 'src\frame.inc.pesquisa.pas' {fraIncPesquisa: TFrame},
  frame.inc.item.pesquisa in 'src\frame.inc.item.pesquisa.pas' {fraItemPesquisa: TFrame},
  view.cad.padrao in 'src\view.cad.padrao.pas' {fCadPadrao},
  view.cad.sprint in 'src\view.cad.sprint.pas' {fCadSprint},
  view.cad.equipe in 'src\view.cad.equipe.pas' {fCadEquipe},
  view.cad.cargo in 'src\view.cad.cargo.pas' {fCadCargo},
  view.cad.funcao in 'src\view.cad.funcao.pas' {fCadFuncao},
  view.cad.empresa in 'src\view.cad.empresa.pas' {fCadEmpresa},
  view.cad.colaborador in 'src\view.cad.colaborador.pas' {fCadColaborador},
  lib.utils in 'src\lib.utils.pas',
  frame.card.colab in 'src\frame.card.colab.pas' {fraCardColab: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Emerald Light Slate');
  Application.CreateForm(TdataImages, dataImages);
  if TfLogin.Login then
    Application.CreateForm(TfMenu, fMenu);
  Application.Run;
end.
