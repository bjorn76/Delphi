unit LMDConst;
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
 IDS_PATH='Chemin:';
 IDS_ON='ON';
 IDS_OFF='OFF';

 // TLMDCheckListBoxDlg
 IDS_SELECT='S�lectionner...';
 IDS_SELECTOPTIONS='Cochez le(s) bonne(s) option(s)...';

 //ButtonBar
 IDS_ADDSECTION='Ajouter sect&ion';
 IDS_DELSECTION='Supprim&er section';
 IDS_RENSECTION='Re&nommer section';
 IDS_ADDITEM='&Ajouter �l�ment';
 IDS_DELITEM='&Supprimer �l�ment';
 IDS_RENITEM='&Renommer �l�ment';
 IDS_SMALLICONS='&Petites ic�nes';
 IDS_LARGEICONS='&Grandes ic�nes';

//TLMDCalendarDlg, 4.2
 IDS_CALCAPTION='Calendrier';
 IDS_ACTUALDATE='Aujourd''hui';

 //EditControls      ---IDS_EDIT='&Edition';
 IDS_INSERT='&Ins�rer';
 IDS_COPY='&Copier';
 IDS_CUT='&Couper';
 IDS_UNDO='&D�faire';
 IDS_SELECTALL='S�lectionner tout';
 IDS_DELETE='&Supprimer';
 IDS_SEARCH='Chercher';
 IDS_SEARCHMSG1='D�but de texte ... relancer � partir de la fin ?';
 IDS_SEARCHMSG2='Fin de texte ... relancer � partir du d�but ?';
 IDS_REPLACE='Remplacer';
 IDS_WORDWRAP='Retour � la ligne automatique';
 IDS_LINED='Lignes';
 IDS_REDO='&Refaire';
 IDS_FONT='Police';
 IDS_CLEAR='Nettoyer';
 IDS_ALIGNLEFT='Aligner � gauche';
 IDS_ALIGNRIGHT='Aligner � droite';
 IDS_ALIGNCENTER='Centrer';
 IDS_STATISTICS='Statistiques sur le texte';
 IDS_OPEN='Ouvrir';
 IDS_SAVE='Sauvegarder';
 IDS_PRINT='Imprimer';
 IDS_PAGE='Page';
 IDS_EDIT='Editer';

 // Component Messages
 IDS_MUSTSHOWONE='Un style d''horloge do�t �tre actif !';
 IDS_INVALIDOWNER='Propri�taire non valide(owner) (<>TForm) ou seconde instance sur la fiche';
 IDS_INTERVALNOTFIT='Intervalle non compatible avec la propri�t� MinInterval!';

 // TLMDAssist
 IDS_NEXT='&Suivant >';
 IDS_BACK='< &Pr�c�dent';
 IDS_FINISH='&Terminer';
 IDS_HELP='&Aide';
 IDS_CLOSE='&Quitter';
 IDS_CANCEL='Annuler';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'Cette propri�t� n''est plus utilis�e dans LMD-Tools!';

 // TLMDMRUList
 IDS_CLEARLIST = 'Vider la liste...';
 IDS_CLEARLISTHINT = 'Vider la liste des fichiers r�cents';
 IDS_CLEARLISTREQUEST = 'Vider vraiment la liste des fichiers r�cents ?';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='a d�j� �t� d�marr�...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Info ';
 IDS_AboutAvailMemory='M�moire disponible:';
 IDS_AboutSysRes='Ressources Syst�me:';
 IDS_AboutCompatible='ou compatible';
 IDS_AboutPlatform='Plate-forme, CPU:';
 IDS_FREE='libre';

 {TLMDDirDlg}
 IDS_DIRCAPTION='S�lectionner un dossier...';
 IDS_DIRDRIVE='&Lecteur:';
 IDS_DIRPATH='&Chemin:';
 IDS_NEWPATH='&Nouveau dossier';

 {TLMDTipDlg}
 IDS_TIPERROR='Pas de conseil disponible - La fen�tre ne sera pas affich�e...';
 IDS_SHOWATSTART='Montrer le(s) conseil(s) � chaque d�marrage';
 IDS_TIPNEXT='Conseil &suivant';
 IDS_TIPPREV='Conseil &pr�c�dent';

 {TLMDWindowList}
 IDS_WLCAPTION='Liste des fen�tres';
 IDS_WLDESC='&Fen�tre(s) disponible(s):';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Calendrier';
 IDS_ACTUALDATE='Aujourd''hui';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Ne plus montrer';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Saisie';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Editeur de texte';

 // LMDSYSIN
 // ****************************************************************************
 IDS_FILE='Fichiers';
 IDS_NOROOTDIR='pas de r�pertoire racine';
 IDS_REMOVABLE='amovible';
 IDS_FIXEDDRIVE='lecteur fixe';
 IDS_REMOTE='lecteur r�seau';
 IDS_CDROM='CD-ROM';
 IDS_RAMDISK='m�moire virtuelle';
 IDS_USERNAME='Nom d''utilisateur';
 IDS_WINDOWSDIR='R�pertoire WINDOWS';
 IDS_CURRDIR='R�pertoire courant';
 IDS_FREESPACE='Espace libre du disque courant';
 IDS_DISKSIZE='Taille du disque courant';
 IDS_SYSTEMDIR='R�pertoire SYSTEM';
 IDS_REGISTEREDOWNER='Propri�taire enregistr�';
 IDS_REGISTEREDCOMPANY='Compagnie enregistr�e';
 IDS_VERSION='Version';
 IDS_COLORDEPTH='Nombre de couleurs (en bits)';
 IDS_SCREENSAVERDELAY='D�lai pour l''�conomiseur d''�cran';
 IDS_MEMORYSIZE='M�moire install�e';
 IDS_FREESYSTEMRESOURCES='Ressources syst�me libres';
 IDS_FREEGDIRES='Ressources GDI libres';
 IDS_FREEUSERRES='Ressources utilisateur libre';
 IDS_COMPUTERNAME='Nom de l''ordinateur';
 IDS_MAJORVERSION='Version majeure';
 IDS_BUILD='Version mineure';
 IDS_MEMORYLOADED='M�moire utilis�e';
 IDS_MEMORYFREE='M�moire libre';
 IDS_MEMORYFREEPAGES='Pages m�moire libres';
 IDS_MEMORYTOTALPAGES='Total des pages m�moires';
 IDS_MEMORYVIRTUALFREE='M�moire virtuelle totale libre';
 IDS_MEMORYVIRTUALTOTAL='M�moire virtuelle totale';
 IDS_PLATFORMID='Plate-forme ID';
 IDS_PLATFORM='Plate-forme';
 IDS_PROCESSORNUMBER='Nombre de processeurs';
 IDS_PROCESSOR='Processeur';
 IDS_TEMPPATH='R�pertoire temporaire';
 IDS_DOSVERSION='Version DOS';
 IDS_NUMLOCK='Verr num';
 IDS_CAPSLOCK='Verr maj';
 IDS_SCROLL='Arr�t d�fil';
 IDS_DATETIME='Date et heure';
 IDS_COMPANYNAME='Nom de la soci�t�';
 IDS_PRODUCTNAME='Nom du produit';
 IDS_PRODUCTVERSION='Version du produit';
 IDS_LEGALCOPYRIGHT='Droit d''auteur (Copyright)';
 IDS_TRADEMARK='Marque d�pos�e';
 IDS_FILEDESCRIPTION='Description du fichier';
 IDS_COMMENTS='Commentaires';
 IDS_CPUSPEED='Vitesse CPU';


implementation

end.
