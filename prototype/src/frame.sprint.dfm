object fraSprint: TfraSprint
  Left = 0
  Top = 0
  Width = 535
  Height = 40
  TabOrder = 0
  object SpeedButton1: TSpeedButton
    Left = 0
    Top = 0
    Width = 40
    Height = 40
    Align = alLeft
    ImageIndex = 4
    ImageName = 'L'
    Images = dataImages.iListImages
    Flat = True
    OnClick = SpeedButton1Click
    ExplicitLeft = -6
  end
  object Label6: TLabel
    Left = 40
    Top = 0
    Width = 75
    Height = 13
    Align = alClient
    Alignment = taCenter
    Caption = '<descr_sprint>'
    Layout = tlCenter
  end
  object SpeedButton2: TSpeedButton
    Left = 495
    Top = 0
    Width = 40
    Height = 40
    Align = alRight
    ImageIndex = 3
    ImageName = 'R'
    Images = dataImages.iListImages
    Flat = True
    OnClick = SpeedButton2Click
    ExplicitLeft = 512
  end
end
