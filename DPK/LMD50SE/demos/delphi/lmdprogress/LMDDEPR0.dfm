�
 TFRMPRG 0n+  TPF0TfrmprgfrmprgLeft*Top� BorderIconsbiSystemMenu BorderStylebsDialogCaption)Demo of TLMDProgress and TLMDProgressFillClientHeight�ClientWidthiColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoScreenCenterPixelsPerInch`
TextHeight TPageControlnoteLeft Top WidthiHeight�
ActivePagepage1AlignalClientFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder  	TTabSheetpage1CaptionTLMDProgress TLMDSimpleLabelLMDSimpleLabel1Left
TopWidthxHeight	MultiLine	Caption&Scroll around and watch the effects...Options   
TScrollBar
ScrollBar1Left� Top	Width?HeightLargeChangePageSize Position2TabOrder OnChangeScrollBar1Change  TLMDGroupBoxLMDGroupBox1LeftTop(WidthYHeight�	Alignment
gcaLeftTopBackFX.AlphaBlend.Strength     ����?
Bevel.Mode
bmStandardBevel.StandardStylelsFrameInsetCaptiondemo componentsCaptionFont.CharsetDEFAULT_CHARSETCaptionFont.ColorclNavyCaptionFont.Height�CaptionFont.NameArialCaptionFont.StylefsBold CaptionFont3D.ShadowDepthCaptionFont3D.StyletdShadowCaptionFont3D.TracingCaptionParentFontTabOrder 	TLMDLabel	LMDLabel1LeftTopWidthHeight� 
Bevel.ModebmCustomFontFX.StyletdSunkenShadowFontFX.AngleZFontFX.PosXFontFX.PosY� Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold Options 
ParentFontCaptionvertical meters are possible...  TLMDProgressp2Left'TopWidth(HeightrBarColorclGreenBar3DlsDoubleRaisedBevel.StyleOuter	bvLoweredBevel.WidthInnerBevel.WidthOuterBevel.BorderWidth
Bevel.ModebmCustom	DirectionmdVerticalReverseFont3D.LightDepthOptionsText	toPercentStylepgBarPosition2	UserValue2  TLMDSimpleLabelLMDSimpleLabel2LeftqTopWidth� Height)	MultiLine	CaptionTUse your own caption and the bevel property you already know from other components !Options   TLMDProgressp3LeftTopWidth1Height;Bevel.StyleInnerbvShadowBevel.StyleOuterbvShadowBevel.WidthOuter
Bevel.ModebmCustomCaptionHello World !Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style Font3D.StyletdRaisedShadowOptionsText	toCaption
ParentFontSmallBar.BarColorclGrayPosition2	UserValue2  TLMDProgressp4LeftTopTWidthHeightBevel.StyleOuter	bvLowered
Bevel.ModebmCustomFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsText	toPercent
ParentFontSmallBar.BarCount(StylepgSmallBarColorUseFontColor	
OnGetColor
p4GetColorPosition2	UserValue2  TLMDProgressp5LeftTopyWidth/HeightBevel.StyleOuterbvFrameLowered
Bevel.ModebmCustomSmallBar.BarColorclTealSmallBar.BarCountSmallBar.HSpaceSmallBar.VSpacePosition2	UserValue2  TLMDProgressp1LeftTop� Width1HeightBevel.StyleOuter	bvLowered
Bevel.ModebmCustomPosition2	UserValue2  TLMDSimpleLabelLMDSimpleLabel4LeftLTop� Width� Height	MultiLine	Caption(Make your app's look like the big ones !Options   TLMDProgressp6LeftTop� Width3HeightBarColorclGreenBevel.StyleOuterbvNormalBevel.BorderColorclBtnShadowBevel.LightColor	clBtnFace
Bevel.ModebmCustomBevel.ShadowColor	clBtnFaceColorclRed	DirectionmdHorizontalReverseParentColorSmallBar.BarColorclTealSmallBar.BarCountSmallBar.HSpaceSmallBar.VSpaceStylepgBarPosition2	UserValue2  TLMDProgressp7LeftTop� Width2HeightBevel.StyleOuter	bvLowered
Bevel.Mode
bmStandardBevel.StandardStylelsLoweredspbSmallBar.BarCount2SmallBar.HSpaceStylepgSmallBarColor
OnGetColor
p7GetColorPosition2	UserValue2  TLMDSimpleLabelLMDSimpleLabel5LeftzTop� Width� HeightAutoSize	MultiLine	Caption>use event GetColor to have different colors for the display...Options   TLMDDrawEdgeLMDDrawEdge1LeftMTop� Width.Height0
FrameSidesfsLeft Style
esDiagonal  TLMDDrawEdgeLMDDrawEdge2LeftLTop� Width.Height
FrameSidesfsLeft Style
esStandard  TMemoMemo1LeftTop� Width3Height� Lines.Strings7procedure Tfrmprg.p7GetColor(Sender: TObject; nr: Byte;  var aColor: TColor);begin  case nr of    0..4:  aColor:=clMaroon;    5..14: aColor:=clRed;    15..35: aColor:=clYellow;    36..45: aColor:=clLime;    46..49: aColor:=clGreen;  end;end; TabOrder     	TTabSheetpage2CaptionTLMDProgressFill TLMDSimpleLabelLMDSimpleLabel10Left
TopWidthxHeight	MultiLine	Caption&Scroll around and watch the effects...Options   
TScrollBar
ScrollBar2Left� Top	Width?HeightLargeChangePageSize Position2TabOrder OnChangeScrollBar1Change  TLMDGroupBoxLMDGroupBox2LeftTop(WidthYHeight�	Alignment
gcaLeftTopBackFX.AlphaBlend.Strength     ����?
Bevel.Mode
bmStandardBevel.StandardStylelsFrameInsetCaptiondemo componentsCaptionFont.CharsetDEFAULT_CHARSETCaptionFont.ColorclNavyCaptionFont.Height�CaptionFont.NameArialCaptionFont.StylefsBold CaptionFont3D.ShadowDepthCaptionFont3D.StyletdShadowCaptionFont3D.TracingCaptionParentFontTabOrder TLMDProgressFillp10Left TopWidthHeightBevel.StyleOuter	bvLowered
Bevel.ModebmCustomFillObject.Bitmap.Data
:  6  BM6      6   (                                  �     �     �     �     �     �     �     �     �  �     �     �     �     �     �     �     �  �  �  �     �     �     �     �     �     �  �  �  �  �  �     �     �     �     �     �  �  �  �  �  �  �  �     �     �     �     �  �  �  �  �  �  �  �  �  �     �     �     �  �  �  �  �  �  �  �  �  �  �  �     �     �  �  �  �  �  �  �  �  �  �  �  �  �  �     �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �� �  �  �  �  �  �  �  �  �  �  �  �  �  �  �� �  �� �  �  �  �  �  �  �  �  �  �  �  �  �� �  �� �  �� �  �  �  �  �  �  �  �  �  �  �� �  �� �  �� �  �� �  �  �  �  �  �  �  �  �� �  �� �  �� �  �� �  �� �  �  �  �  �  �  �� �  �� �  �� �  �� �  �� �  �� �  �  �  �  �� �  �� �  �� �  �� �  �� �  �� �  �� �  FillObject.StylesfBitmapOptionsText	toPercentPosition2	UserValue2  TLMDProgressFillp11Left Top,WidthHeight!Bevel.StyleInnerbvRaisedBevel.StyleOuter	bvLowered
Bevel.ModebmCustomFillObject.Bitmap.Data
:  6  BM6      6   (                                  �     �     �     �     �     �     �     �     �  �     �     �     �     �     �     �     �  �  �  �     �     �     �     �     �     �  �  �  �  �  �     �     �     �     �     �  �  �  �  �  �  �  �     �     �     �     �  �  �  �  �  �  �  �  �  �     �     �     �  �  �  �  �  �  �  �  �  �  �  �     �     �  �  �  �  �  �  �  �  �  �  �  �  �  �     �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �� �  �  �  �  �  �  �  �  �  �  �  �  �  �  �� �  �� �  �  �  �  �  �  �  �  �  �  �  �  �� �  �� �  �� �  �  �  �  �  �  �  �  �  �  �� �  �� �  �� �  �� �  �  �  �  �  �  �  �  �� �  �� �  �� �  �� �  �� �  �  �  �  �  �  �� �  �� �  �� �  �� �  �� �  �� �  �  �  �  �� �  �� �  �� �  �� �  �� �  �� �  �� �  FillObject.StylesfBitmapFillObject.TileMode	tmStretchOptionsText	toPercentPosition2	UserValue2  TLMDProgressFillp12Left TopSWidthHeightBevel.StyleOuterbvRaisedBevel.WidthOuter
Bevel.ModebmCustomBrushBackColorclAquaCaptionHello !FillObject.Bitmap.Data
:  6  BM6      6   (                                  �     �     �     �     �     �     �     �     �  �     �     �     �     �     �     �     �  �  �  �     �     �     �     �     �     �  �  �  �  �  �     �     �     �     �     �  �  �  �  �  �  �  �     �     �     �     �  �  �  �  �  �  �  �  �  �     �     �     �  �  �  �  �  �  �  �  �  �  �  �     �     �  �  �  �  �  �  �  �  �  �  �  �  �  �     �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �� �  �  �  �  �  �  �  �  �  �  �  �  �  �  �� �  �� �  �  �  �  �  �  �  �  �  �  �  �  �� �  �� �  �� �  �  �  �  �  �  �  �  �  �  �� �  �� �  �� �  �� �  �  �  �  �  �  �  �  �� �  �� �  �� �  �� �  �� �  �  �  �  �  �  �� �  �� �  �� �  �� �  �� �  �� �  �  �  �  �� �  �� �  �� �  �� �  �� �  �� �  �� �  FillObject.StylesfBitmapFillObject.TileModetmCenterFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.StylefsBoldfsItalic OptionsText	toCaption
ParentFontPosition2	UserValue2  TLMDSimpleLabelLMDSimpleLabel6Left2Top)Width� Height6	MultiLine	CaptiondAny bitmap can be tiled, stretched or centered into the progress bar. Bevels can be used, of course.Options   TLMDProgressFillp16Left TopWidth$HeighteBevel.StyleOuter	bvLowered
Bevel.ModebmCustom	DirectionmdVerticalReverseFillObject.Style
sfGradientFillObject.Gradient.ColorclBlackFillObject.Gradient.StylegstEllipticFillObject.Gradient.EndColorclBlueOptionsText	toPercentPosition2	UserValue2  TLMDProgressFillp13Left� Top� WidthHeight!Bevel.StyleOuter	bvLowered
Bevel.ModebmCustomFillObject.Style
sfGradientOptionsText	toPercentPosition2	UserValue2  TLMDProgressFillp14Left� Top� WidthHeightCBevel.StyleInnerbvShadowBevel.StyleOuterbvShadowBevel.WidthOuter
Bevel.ModebmCustom	DirectionmdHorizontalReverseFillObject.Style
sfGradientFillObject.Gradient.Style	gstSquareOptionsText	toPercentPosition2	UserValue2  TLMDProgressFillp15Left� Top� WidthHeight2Bevel.StyleInner	bvLoweredBevel.StyleOuterbvRaised
Bevel.ModebmCustomFillObject.Style
sfGradientFillObject.Gradient.ColorclBlackFillObject.Gradient.StylegstHorizontalFillObject.Gradient.EndColorclBlueOptionsText	toPercentPosition2	UserValue2  TLMDSimpleLabelLMDSimpleLabel8Left:TopFWidthHeight	MultiLine	CaptionChange anything you like !Options   TLMDProgressFillp17Left%TopAWidthHeightBevel.StyleInner	bvLoweredBevel.StyleOuterbvRaised
Bevel.ModebmCustomColorclBlueFillObject.Style
sfGradientFillObject.Gradient.ColorclBlackFillObject.Gradient.StylegstHorizontalFillObject.Gradient.EndColorclNavyOptionsText	toPercentParentColorPosition2	UserValue2  TLMDSimpleLabelLMDSimpleLabel7Left"Top� WidthyHeight)	MultiLine	CaptionIUse many different kinds of gradients. This really looks professionally !Options   	TLMDLabel	LMDLabel2LeftTopWidthHeight� 
Bevel.ModebmCustomFontFX.StyletdSunkenShadowFontFX.AngleZFontFX.PosXFontFX.PosY� Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold Options 
ParentFontCaptionvertical meters are possible...     
TLMDButtonexitbtnLeft,Top Width<HeightCaptionExitTabOrderVisible	OnClickexitbtnClick   