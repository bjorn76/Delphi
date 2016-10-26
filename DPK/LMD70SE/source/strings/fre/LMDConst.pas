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
 IDS_SELECT='Sélectionner...';
 IDS_SELECTOPTIONS='Cochez le(s) bonne(s) option(s)...';

 //ButtonBar
 IDS_ADDSECTION='Ajouter sect&ion';
 IDS_DELSECTION='Supprim&er section';
 IDS_RENSECTION='Re&nommer section';
 IDS_ADDITEM='&Ajouter élément';
 IDS_DELITEM='&Supprimer élément';
 IDS_RENITEM='&Renommer élément';
 IDS_SMALLICONS='&Petites icônes';
 IDS_LARGEICONS='&Grandes icônes';

//TLMDCalendarDlg, 4.2
 IDS_CALCAPTION='Calendrier';
 IDS_ACTUALDATE='Aujourd''hui';

 //EditControls      ---IDS_EDIT='&Edition';
 IDS_INSERT='&Insérer';
 IDS_COPY='&Copier';
 IDS_CUT='&Couper';
 IDS_UNDO='&Défaire';
 IDS_SELECTALL='Sélectionner tout';
 IDS_DELETE='&Supprimer';
 IDS_SEARCH='Chercher';
 IDS_SEARCHMSG1='Début de texte ... relancer à partir de la fin ?';
 IDS_SEARCHMSG2='Fin de texte ... relancer à partir du début ?';
 IDS_REPLACE='Remplacer';
 IDS_WORDWRAP='Retour à la ligne automatique';
 IDS_LINED='Lignes';
 IDS_REDO='&Refaire';
 IDS_FONT='Police';
 IDS_CLEAR='Nettoyer';
 IDS_ALIGNLEFT='Aligner à gauche';
 IDS_ALIGNRIGHT='Aligner à droite';
 IDS_ALIGNCENTER='Centrer';
 IDS_STATISTICS='Statistiques sur le texte';
 IDS_OPEN='Ouvrir';
 IDS_SAVE='Sauvegarder';
 IDS_PRINT='Imprimer';
 IDS_PAGE='Page';
 IDS_EDIT='Editer';

 // Component Messages
 IDS_MUSTSHOWONE='Un style d''horloge doît être actif !';
 IDS_INVALIDOWNER='Propriétaire non valide(owner) (<>TForm) ou seconde instance sur la fiche';
 IDS_INTERVALNOTFIT='Intervalle non compatible avec la propriété MinInterval!';

 // TLMDAssist
 IDS_NEXT='&Suivant >';
 IDS_BACK='< &Précédent';
 IDS_FINISH='&Terminer';
 IDS_HELP='&Aide';
 IDS_CLOSE='&Quitter';
 IDS_CANCEL='Annuler';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'Cette propriété n''est plus utilisée dans LMD-Tools!';

 // TLMDMRUList
 IDS_CLEARLIST = 'Vider la liste...';
 IDS_CLEARLISTHINT = 'Vider la liste des fichiers récents';
 IDS_CLEARLISTREQUEST = 'Vider vraiment la liste des fichiers récents ?';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='a déjà été démarré...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Info ';
 IDS_AboutAvailMemory='Mémoire disponible:';
 IDS_AboutSysRes='Ressources Système:';
 IDS_AboutCompatible='ou compatible';
 IDS_AboutPlatform='Plate-forme, CPU:';
 IDS_FREE='libre';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Sélectionner un dossier...';
 IDS_DIRDRIVE='&Lecteur:';
 IDS_DIRPATH='&Chemin:';
 IDS_NEWPATH='&Nouveau dossier';

 {TLMDTipDlg}
 IDS_TIPERROR='Pas de conseil disponible - La fenêtre ne sera pas affichée...';
 IDS_SHOWATSTART='Montrer le(s) conseil(s) à chaque démarrage';
 IDS_TIPNEXT='Conseil &suivant';
 IDS_TIPPREV='Conseil &précédent';

 {TLMDWindowList}
 IDS_WLCAPTION='Liste des fenêtres';
 IDS_WLDESC='&Fenêtre(s) disponible(s):';

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
 IDS_NOROOTDIR='pas de répertoire racine';
 IDS_REMOVABLE='amovible';
 IDS_FIXEDDRIVE='lecteur fixe';
 IDS_REMOTE='lecteur réseau';
 IDS_CDROM='CD-ROM';
 IDS_RAMDISK='mémoire virtuelle';
 IDS_USERNAME='Nom d''utilisateur';
 IDS_WINDOWSDIR='Répertoire WINDOWS';
 IDS_CURRDIR='Répertoire courant';
 IDS_FREESPACE='Espace libre du disque courant';
 IDS_DISKSIZE='Taille du disque courant';
 IDS_SYSTEMDIR='Répertoire SYSTEM';
 IDS_REGISTEREDOWNER='Propriétaire enregistré';
 IDS_REGISTEREDCOMPANY='Compagnie enregistrée';
 IDS_VERSION='Version';
 IDS_COLORDEPTH='Nombre de couleurs (en bits)';
 IDS_SCREENSAVERDELAY='Délai pour l''économiseur d''écran';
 IDS_MEMORYSIZE='Mémoire installée';
 IDS_FREESYSTEMRESOURCES='Ressources système libres';
 IDS_FREEGDIRES='Ressources GDI libres';
 IDS_FREEUSERRES='Ressources utilisateur libre';
 IDS_COMPUTERNAME='Nom de l''ordinateur';
 IDS_MAJORVERSION='Version majeure';
 IDS_BUILD='Version mineure';
 IDS_MEMORYLOADED='Mémoire utilisée';
 IDS_MEMORYFREE='Mémoire libre';
 IDS_MEMORYFREEPAGES='Pages mémoire libres';
 IDS_MEMORYTOTALPAGES='Total des pages mémoires';
 IDS_MEMORYVIRTUALFREE='Mémoire virtuelle totale libre';
 IDS_MEMORYVIRTUALTOTAL='Mémoire virtuelle totale';
 IDS_PLATFORMID='Plate-forme ID';
 IDS_PLATFORM='Plate-forme';
 IDS_PROCESSORNUMBER='Nombre de processeurs';
 IDS_PROCESSOR='Processeur';
 IDS_TEMPPATH='Répertoire temporaire';
 IDS_DOSVERSION='Version DOS';
 IDS_NUMLOCK='Verr num';
 IDS_CAPSLOCK='Verr maj';
 IDS_SCROLL='Arrêt défil';
 IDS_DATETIME='Date et heure';
 IDS_COMPANYNAME='Nom de la société';
 IDS_PRODUCTNAME='Nom du produit';
 IDS_PRODUCTVERSION='Version du produit';
 IDS_LEGALCOPYRIGHT='Droit d''auteur (Copyright)';
 IDS_TRADEMARK='Marque déposée';
 IDS_FILEDESCRIPTION='Description du fichier';
 IDS_COMMENTS='Commentaires';
 IDS_CPUSPEED='Vitesse CPU';


implementation

end.
