�
 TLMDFILLEDITORDLG 0�  TPF0TLMDFillEditorDlgLMDFillEditorDlgLeft� TopoBorderStylebsDialogClientHeight9ClientWidth�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterScaledShowHint	
OnActivateFormActivateOnCreate
FormCreatePixelsPerInch`
TextHeight TBevelBevel1LeftTop� Width�Height
ShapebsBottomLine  TLMDFilltestLeftTop
Width�Height� HintDisplays the current settings.
Bevel.Mode
bmStandardBevel.StandardStylelsSingleLoweredCaption.Font.CharsetDEFAULT_CHARSETCaption.Font.ColorclWindowTextCaption.Font.Height�Caption.Font.NameMS Sans SerifCaption.Font.Style FillObject.StylesfNone  TPageControlnbLeftTop� WidthXHeight� 
ActivePage	TabSheet1TabOrder  	TTabSheet	TabSheet1CaptionStyle TLabelLabel2LeftTopWidthHeightCaptionStyle:Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTransparent	  	TComboBoxcmbStyleLeftLTopWidth� HeightHintSpecifies the style of filling.StylecsDropDownList
ItemHeightItems.StringssfNonesfBrushBitmapsfBrushsfBitmapsfBitmapList
sfGradient TabOrder OnChange	cmbChange  	TCheckBoxck1Left
Top7Width"HeightCaption9FillInner (e.g. if Bitmap covers not complete dest. area)TabOrderOnClickck1Click  	TCheckBoxck2Left
TopIWidth"HeightCaption.QuickDraw (don't use palette ->bitmap drawing)TabOrder  	TCheckBoxck3Left
TopZWidth"HeightCaption3UseOffScreen (Gradient style uses offscreen bitmap)TabOrder   	TTabSheet	TabSheet2CaptionBitmap TLabelLabel4LeftTopZWidth/HeightCaption	TileMode:Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTransparent	  
TLMDNImageiTestLeft]Top
Width� HeightDBackFX.AlphaBlend.Strength     ����?"BackFX.AlphaBlend.FillObject.StylesfNone
Bevel.Mode
bmStandardBevel.StandardStylelsSingleLoweredStylesbKeepAspRatio  TButton	btnBitmapLeftTopWidth>HeightHint=Sets a bitmap for the "sfBitmap"
and "sfBrushBitmap"-styles.Caption	Bitmap >>Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder OnClickButton1Click  	TComboBoxcmbTileLeft\TopSWidth� HeightHintBSpecifies the style of clipping 
the bitmap into the destination.StylecsDropDownList
ItemHeightItems.StringstmNonetmCenter	tmStretchtmTile TabOrderOnChange	cmbChange   	TTabSheet	TabSheet3CaptionBrush TLMDFillbtestLeftPTopWidth� HeightJ
Bevel.Mode
bmStandardBevel.StandardStylelsSingleLoweredCaption.Font.CharsetDEFAULT_CHARSETCaption.Font.ColorclWindowTextCaption.Font.Height�Caption.Font.NameMS Sans SerifCaption.Font.Style FillObject.StylesfBrush  TLMDSimpleLabelinfoLeft[Top-Width� HeightAutoSizeFont.CharsetDEFAULT_CHARSET
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.Style 	MultiLine	
ParentFontVisibleCaption:TLMDShapeFill-object uses 
the brush of a parent control-Options   TButtonbtnbrushLeftTopWidth>HeightHint-Specifies the brush for the
"sfBrush"-style.CaptionBrush >>Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder OnClickButton1Click   	TTabSheet	TabSheet4CaptionGradient TLMDFillgTestLeftPTopWidth� HeightJ
Bevel.Mode
bmStandardBevel.StandardStylelsSingleLoweredCaption.Font.CharsetDEFAULT_CHARSETCaption.Font.ColorclWindowTextCaption.Font.Height�Caption.Font.NameMS Sans SerifCaption.Font.Style FillObject.Style
sfGradient  TButtonbtnGradientLeft	TopWidth@HeightHint1Specifies a gradient for the
"sfGradient"-style.CaptionGradient >>Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder OnClickButton1Click    TButtonokLeftdTop� WidthMHeightCaptionOKDefault	ModalResultTabOrder  TButtonButton1LeftdTop� WidthMHeightCancel	CaptionCancelModalResultTabOrder  TButtonresetLeftdTop� WidthMHeightCaptionResetTabOrderOnClick
resetClick  TLMDFormStylerfsFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsfsAdjustRectfsUseDefaultFontfsUseFormCaption Left�TopQ   