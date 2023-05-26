unit data.images;

interface

uses
  System.SysUtils, System.Classes, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList;

type
  TdataImages = class(TDataModule)
    iListImages: TVirtualImageList;
    iCollection: TImageCollection;
    iListImages20: TVirtualImageList;
    iListImages10: TVirtualImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dataImages: TdataImages;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
