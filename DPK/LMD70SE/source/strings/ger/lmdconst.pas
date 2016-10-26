unit lmdconst;
{$I lmdcmps.inc}
{
  ##############################################################################
  # Author: LMD Innovative (--)
  # Created: 1996
  # Description: Unit containing resource strings used by the components
  # State: release
  # Comments: already available in several other languages!
  #---------------------------------- CHANGES ----------------------------------
  # Author:		RM
  # Date:		23-Jan-2003
  # Description:	+ IDS_SELECTOPTIONS
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}
interface

resourcestring
 IDS_PATH='Pfad:';
 IDS_ON='An';
 IDS_OFF='Aus';

 // TLMDCheckListBoxDlg
 IDS_SELECT='Auswählen...';
 IDS_SELECTOPTIONS='Bitte die gewünschte(n) Option(en) wählen...';

 //ButtonBar
 IDS_ADDSECTION='&Neue Gruppe hinzufügen';
 IDS_DELSECTION='Gruppe &entfernen';
 IDS_RENSECTION='Gruppe &umbenennen';
 IDS_ADDITEM='Neues Element &hinzufügen';
 IDS_DELITEM='Element ent&fernen';
 IDS_RENITEM='Element um&bennen';
 IDS_SMALLICONS='&Kleine Symbole';
 IDS_LARGEICONS='&Große Symbole';

 //EditControls
 IDS_INSERT='&Einfügen';
 IDS_COPY='&Kopieren';
 IDS_CUT='&Ausschneiden';
 IDS_UNDO='&Rückgängig';
 IDS_SELECTALL='Alles auswä&hlen';
 IDS_DELETE='&Löschen';
 IDS_SEARCH='Suchen';
 IDS_SEARCHMSG1='Textanfang erreicht - weiter vom Ende des Textes?';
 IDS_SEARCHMSG2='Textende erreicht - weiter vom Anfang des Textes?';
 IDS_REPLACE='Ersetzen';
 IDS_WORDWRAP='Zeilenumbruch';
 IDS_LINED='Liniert';
 IDS_REDO='Wiederherstellen';
 IDS_FONT='Schriftart';
 IDS_CLEAR='Löschen';
 IDS_ALIGNLEFT='Links ausrichten';
 IDS_ALIGNRIGHT='Rechts ausrichten';
 IDS_ALIGNCENTER='Zentrieren';
 IDS_STATISTICS='Text Statistiken';
 IDS_OPEN='Öffnen';
 IDS_SAVE='Speichern';
 IDS_PRINT='Drucken';
 IDS_PAGE='Seite';
 IDS_EDIT='Bearbeiten';

 // Component Messages
 IDS_MUSTSHOWONE='Mindestens eine Uhranzeige muß aktiviert sein!!';
 IDS_INVALIDOWNER='Ungültiger Owner-Objekt (nicht TForm) oder zweite Instanz auf einer Form!';
 IDS_INTERVALNOTFIT='Angegebenes Intervall paßt nicht zum gesetzten MinimalIntervall!';

 // TLMDAssist
 IDS_NEXT='&Weiter >';
 IDS_BACK='< &Zurück';
 IDS_FINISH='&Beenden';
 IDS_HELP='&Hilfe';
 IDS_CLOSE='&Schließen';
 IDS_CANCEL='Abbrechen';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'This property is no longer used in LMD-Tools!';

 // TLMDMRUList
 IDS_CLEARLIST = 'Dateiliste löschen...';
 IDS_CLEARLISTHINT = 'Liste der zuletzt bearbeiteten Dateien löschen?';
 IDS_CLEARLISTREQUEST = 'Soll die Dateiliste wirklich gelöscht werden?';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='wurde schon gestartet...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Programminfo ';
 IDS_AboutAvailMemory='Verfügbarer Arbeitsspeicher:';
 IDS_AboutSysRes='Systemressourcen:';
 IDS_AboutCompatible='oder kompatibel';
 IDS_AboutPlatform='Plattform, Prozessor:';
 IDS_FREE='frei';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Pfad auswählen...';
 IDS_DIRDRIVE='&Laufwerk:';
 IDS_DIRPATH='&Verzeichnis:';
 IDS_NEWPATH='&Neues Verz.';

 {TLMDTipDlg}
 IDS_TIPERROR='Keine Tips verfügbar - der Dialog wird nicht angezeigt...';
 IDS_SHOWATSTART='Tips bei jedem Programmstart zeigen';
 IDS_TIPNEXT='&Nächster Tip';
 IDS_TIPPREV='&Vorheriger Tip';

 {TLMDWindowList}
 IDS_WLCAPTION='Fensterliste...';
 IDS_WLDESC='Verfügbare &Fenster:';

  {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Kalender...';
 IDS_ACTUALDATE='Akt. Datum';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Nicht wieder anzeigen';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Eingabe...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Text Editor';

 // LMDSYSIN
 // ****************************************************************************
 IDS_FILE='Dateien';
 IDS_NOROOTDIR='Kein Wurzelverzeichnis';
 IDS_REMOVABLE='removable';
 IDS_FIXEDDRIVE='fixed drive';
 IDS_REMOTE='remote (network) drive';
 IDS_CDROM='CD-ROM';
 IDS_RAMDISK='RAM-Disk';
 IDS_USERNAME='Username';
 IDS_WINDOWSDIR='Windowsverzeichnis';
 IDS_CURRDIR='Aktueller Ordner';
 IDS_FREESPACE='Freier Speicher aktuelle Disk';
 IDS_DISKSIZE='Insg. Speicher aktuelle Disk';
 IDS_SYSTEMDIR='Systemordner';
 IDS_REGISTEREDOWNER='Registrierter Eigentümer';
 IDS_REGISTEREDCOMPANY='Registrierte Firma';
 IDS_VERSION='Version';
 IDS_COLORDEPTH='Farbtiefe (in Bit)';
 IDS_SCREENSAVERDELAY='Screensaver Verzögerung';
 IDS_MEMORYSIZE='Größe des Hauptspeichers';
 IDS_FREESYSTEMRESOURCES='Freie Systemressourcen';
 IDS_FREEGDIRES='Freie GDI-Ressourcen';
 IDS_FREEUSERRES='reie User-Ressourcen';
 IDS_COMPUTERNAME='Computername';
 IDS_MAJORVERSION='Hauptversionsnummer';
 IDS_BUILD='Build';
 IDS_MEMORYLOADED='Benutzter Hauptspeicher';
 IDS_MEMORYFREE='Verfügbarer Hauptspeicher';
 IDS_MEMORYFREEPAGES='Freie Speicherseiten';
 IDS_MEMORYTOTALPAGES='Insg. verfügbare Speicherseiten';
 IDS_MEMORYVIRTUALFREE='Freier virtueller Speicher';
 IDS_MEMORYVIRTUALTOTAL='Insg. verfügbarer virtueller Speicher';
 IDS_PLATFORMID='Plattform ID';
 IDS_PLATFORM='Plattform';
 IDS_PROCESSORNUMBER='Anzahl Prozessoren';
 IDS_PROCESSOR='Prozessor';
 IDS_TEMPPATH='Temp-Verzeichnis';
 IDS_DOSVERSION='DOS Version';
 IDS_NUMLOCK='NumLock';
 IDS_CAPSLOCK='CapsLock';
 IDS_SCROLL='ScrollLock';
 IDS_DATETIME='Datum/Zeit';
 IDS_COMPANYNAME='Firmenname';
 IDS_PRODUCTNAME='Produktname';
 IDS_PRODUCTVERSION='Produktversion';
 IDS_LEGALCOPYRIGHT='LegalCopyright';
 IDS_TRADEMARK='LegalTrademark';
 IDS_FILEDESCRIPTION='Dateibeschreibung';
 IDS_COMMENTS='Bemerkungen';
 IDS_CPUSPEED='CPU Geschwindigkeit';


implementation

end.
