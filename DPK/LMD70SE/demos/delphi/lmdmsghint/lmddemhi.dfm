�
 TFRMSMSGHINT 0�  TPF0TfrmsmsgHintfrmsmsgHintLeft� Top� ActiveControlMemo1BorderStylebsDialogCaptionTLMDMessageHint-DemoClientHeightVClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
KeyPreview	OldCreateOrder	PositionpoScreenCenterScaledShowHint	OnCreate
FormCreate
OnKeyPressFormKeyPressPixelsPerInch`
TextHeight TPageControlPageControl1Left Top Width�HeightU
ActivePage	TabSheet1TabOrder 	TTabSheet	TabSheet1CaptionTest TLMDSimpleLabelLMDSimpleLabel8LeftTopWidth� HeightFont.CharsetDEFAULT_CHARSET
Font.ColorclNavyFont.Height�	Font.NameArial
Font.StylefsBold Font3D.StyletdSunken
ParentFontCaptionTLMDMessageHintOptions   TLMDSimpleLabelLMDSimpleLabel9LeftTop(Width�HeightAutoSize	MultiLine	Caption�The TLMDMessagehint component offers all properties of TLMDShapeHint and allows you to display popup hints at runtime programmatically.Options   TLMDSimpleLabelLMDSimpleLabel10LeftTopKWidth�Height+AutoSize	MultiLine	Caption�Mousehandling is done automatically (at any time the user clicks the mouse the window is removed, key handling must be included manually with a single line (check source of this demo).Options   TLMDSpeedButtonLMDSpeedButton3LeftTop� Width� HeightICaptionfTest 1: Displays hint above the small shape. Window will be removed when any mouse(button) is clicked.OnClickLMDSpeedButton3Click
EnterColorclNavyEnterColorChange		MultiLine	  TLMDSpeedButtonLMDSpeedButton4LeftTop� Width� HeightICaptionDisplays hint above the memo.OnClickLMDSpeedButton4Click
EnterColorclNavyEnterColorChange		MultiLine	  TShapeShape1LeftTop� WidthHeight	Brush.StylebsClear  TMemoMemo1Left� Top� Width� Height0Lines.StringsMemo1 ReadOnly	TabOrder    	TTabSheet	TabSheet2CaptionSettings TLabelLabel1LeftTopWidth:Height'Caption'HintText for
'Try with me'
Component:  TLabelLabel2LeftTopcWidth>HeightCaptionHint Position:  TLabelLabel3LeftTop� Width4HeightCaption
BackColor:  TLabelLabel4LeftTop� Width:HeightCaptionBorderColor:  TLabelLabel5LeftTop~Width0HeightCaptionHint Style:  TMemomemoLeftoTopWidth� HeightEColor��� Lines.StringsThis is the demo text fordemonstrating the MessageHint TabOrder   	TComboBoxcmbLeftoTopcWidth� HeightHintChange Hint Position
ItemHeightTabOrderTexthpAboveRightOnChange	cmbChangeItems.StringshpAboveLefthpAboveRighthpBelowLefthpBelowRight   TLMDColorComboBoxccmbLeftoTop� Width� HeightHintChange backcolor of hintwindow
DlgOptions DlgHelpContext OptionscoDefaultColorscoSystemColorscoAllowAnyColor TabOrderOnChange
ccmbChange  TLMDColorComboBoxbcmbLeftoTop� Width� HeightHintChange border color
DlgOptions DlgHelpContext OptionscoDefaultColorscoSystemColorscoAllowAnyColor TabOrderOnChange
ccmbChange  	TComboBoxcmbstyleLeftoTop~Width� HeightHintChange Hint Style
ItemHeightTabOrderTexthsNoseRoundRectOnChange	cmbChangeItems.StringshsRecthsRoundRect	hsEllipse
hsNoseRecthsNoseRoundRecthsNoseEllipse     TButtonButton1Left�Top WidthAHeightCaptionExitTabOrder OnClickButton1Click  TLMDFormStylerLMDFormStyler1Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style LeftjTop  TLMDMessageHintshintFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style Shadow.Style
hssTracingStylehsNoseEllipseLeftATop   