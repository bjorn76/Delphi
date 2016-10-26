unit lmdconst;
// Thanks to Patrick Richebé ;-)

interface

resourcestring
 IDS_PATH='Répertoire:';
 IDS_ON='ON';
 IDS_OFF='OFF';

 //ButtonBar
 IDS_ADDSECTION='Ajout Sect&ion';
 IDS_DELSECTION='Supprim&er Section';
 IDS_RENSECTION='Re&nommer Section';
 IDS_ADDITEM='&Ajout Article';
 IDS_DELITEM='Su&pprimer Article';
 IDS_RENITEM='&Renommer Article';
 IDS_SMALLICONS='Petite&s icônes';
 IDS_LARGEICONS='&Larges icônes';

 //EditControls
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
 IDS_EDIT='Edit';

 // Component Messages
 IDS_MUSTSHOWONE='Une horloge doît être active!';
 IDS_INVALIDOWNER='Propriétaire invalide(owner) (<>TForm) où seconde instance sur la fiche';
 IDS_INTERVALNOTFIT='Intervalle non compatible avec la propriété MinInterval!';

 // TLMDAssist
 IDS_NEXT='&Prochain >';
 IDS_BACK='< &Retour';
 IDS_FINISH='&Fin';
 IDS_HELP='&Aide';
 IDS_CLOSE='F&ermer';
 IDS_CANCEL='Abandonner';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'Cette propriété n''est plus utilisée dans LMD-Tools!';

 // TLMDMRUList
 IDS_CLEARLIST = 'Vider la Liste...';
 IDS_CLEARLISTHINT = 'Vider la Liste des fichiers récents';
 IDS_CLEARLISTREQUEST = 'Certain de vouloir vider la Liste des fichiers récents ?';

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
 IDS_DIRCAPTION='Sélectionner un répertoire...';
 IDS_DIRDRIVE='&Lecteur:';
 IDS_DIRPATH='&Répertoire:';
 IDS_NEWPATH='&Nouveau Répertoire';

 {TLMDTipDlg}
 IDS_TIPERROR='Pas de conseil(s)disponible(s) - La fenêtre ne sera pas affichée...';
 IDS_SHOWATSTART='Montrer le(s) conseil(s) à chaque démarrage';
 IDS_TIPNEXT='&Prochain conseil';
 IDS_TIPPREV='P&récédent conseil';

 {TLMDWindowList}
 IDS_WLCAPTION='Liste des fenêtres...';
 IDS_WLDESC='&Fenêtre(s) disponible(s):';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Calendrier...';
 IDS_ACTUALDATE='Date Actuelle';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Ne plus montrer';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Entrée...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Editeur de Texte';

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
 IDS_WINDOWSDIR='Répertoire de windows';
 IDS_CURRDIR='Répertoire courant';
 IDS_FREESPACE='Espace libre du disque courant';
 IDS_DISKSIZE='Taille du disque courant';
 IDS_SYSTEMDIR='Répertoire SYSTEM';
 IDS_REGISTEREDOWNER='Propriétaire enregistré';
 IDS_REGISTEREDCOMPANY='Compagnie enregistrée';
 IDS_VERSION='Version';
 IDS_COLORDEPTH='Nombre de couleurs (en bits)';
 IDS_SCREENSAVERDELAY='Delai avant l''économiseur d''écran';
 IDS_MEMORYSIZE='Résolution de l''écran';
 IDS_FREESYSTEMRESOURCES='Ressources systeme libres';
 IDS_FREEGDIRES='Ressources GDI libres';
 IDS_FREEUSERRES='Ressources utilisateur libre';
 IDS_COMPUTERNAME='Nom de l''ordinateur';
 IDS_MAJORVERSION='Verion majeure';
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
 IDS_NUMLOCK='NumLock';
 IDS_CAPSLOCK='CapsLock';
 IDS_SCROLL='ScrollLock';
 IDS_DATETIME='Date et heure';
 IDS_COMPANYNAME='Nom de la société';
 IDS_PRODUCTNAME='Nom du produit';
 IDS_PRODUCTVERSION='Version du produit';
 IDS_LEGALCOPYRIGHT='Droit d''auteur (Copyright)';
 IDS_TRADEMARK='Marque déposée';
 IDS_FILEDESCRIPTION='Description du fichier';
 IDS_COMMENTS='Commentaire';
 IDS_CPUSPEED='Vitesse CPU';


implementation

end.

