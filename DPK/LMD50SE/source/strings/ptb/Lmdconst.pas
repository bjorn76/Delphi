unit lmdconst;

interface

resourcestring
 IDS_PATH='Caminho:';
 IDS_ON='ON';
 IDS_OFF='OFF';

 //ButtonBar
 IDS_ADDSECTION='&Adicionar Se��o';
 IDS_DELSECTION='&Excluir se��o';
 IDS_RENSECTION='&Renomear se��o';
 IDS_ADDITEM='&Adicionar Item';
 IDS_DELITEM='&Excluir Item';
 IDS_RENITEM='&Renomear Item';
 IDS_SMALLICONS='�cone &pequeno';
 IDS_LARGEICONS='�cone &grande';

 //EditControls
 IDS_INSERT='&Inserir';
 IDS_COPY='&Copiar';
 IDS_CUT='&Cortar';
 IDS_UNDO='&Desfazer';
 IDS_SELECTALL='Selecionar todos';
 IDS_DELETE='&Excluir';
 IDS_SEARCH='Procurar';
 IDS_SEARCHMSG1='No topo ... recome�ar do final?';
 IDS_SEARCHMSG2='No fim ... recome�ar do topo?';
 IDS_REPLACE='Substituir';
 IDS_WORDWRAP='Quebrar linha';
 IDS_LINED='Lined';
 IDS_REDO='Refazer';
 IDS_FONT='Fonte';
 IDS_CLEAR='Limpar';
 IDS_ALIGNLEFT='Alinhar a esquerda';
 IDS_ALIGNRIGHT='Alinhar a direita';
 IDS_ALIGNCENTER='Centralizar';
 IDS_STATISTICS='Estat�stica do texto';
 IDS_OPEN='Abrir';
 IDS_SAVE='Salvar';
 IDS_PRINT='Imprimir';
 IDS_PAGE='P�gina';

 // Component Messages
 IDS_MUSTSHOWONE='Um tipo de rel�gio deve estar ativo!';
 IDS_INVALIDOWNER='Owner inv�lido (<>TForm) ou segunda inst�ncia do form';
 IDS_INTERVALNOTFIT='Intervalo n�o compat�vel com a propriedade MinInterval!';

 // TLMDAssist
 IDS_NEXT='&Pr�ximo >';
 IDS_BACK='< &Anterior';
 IDS_FINISH='&Fim';
 IDS_HELP='A&juda';
 IDS_CLOSE='&Fechar';
 IDS_CANCEL='Cancelar';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'Esta propriedade n�o est� sendo mais usada pelo LMD-Tools!';

 // TLMDMRUList
 IDS_CLEARLIST = 'Limpar lista...';
 IDS_CLEARLISTHINT = 'Limpar a lista de arquivos recentes';
 IDS_CLEARLISTREQUEST = 'Quer limpar realmente a lista de arquivos recentes?';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='j� foi iniciado...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Info ';
 IDS_AboutAvailMemory='Mem�ria dispon�vel:';
 IDS_AboutSysRes='Recursos do sistema:';
 IDS_AboutCompatible='ou compat�vel';
 IDS_AboutPlatform='Platforma, CPU:';
 IDS_FREE='livre';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Selecione o diret�rio...';
 IDS_DIRDRIVE='&Drive:';
 IDS_DIRPATH='&Diret�rio:';
 IDS_NEWPATH='&Novo diret�rio';

 {TLMDTipDlg}
 IDS_TIPERROR='Nenhuma dica dispon�vel - A tela de di�logo n�o ser� mostrada...';
 IDS_SHOWATSTART='Sempre mostre as dicas ao iniciar';
 IDS_TIPNEXT='&Dica seguinte';
 IDS_TIPPREV='&Dica anterior';

 {TLMDWindowList}
 IDS_WLCAPTION='Windowlist...';
 IDS_WLDESC='&Janelas dispon�veis:';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Calend�rio...';
 IDS_ACTUALDATE='Data real';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='N�o mostre de novo';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Entrada...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Editor de Texto';

 // LMDSYSIN
 // ****************************************************************************
 IDS_FILE='Arquivos';
 IDS_NOROOTDIR='sem diret�rio raiz';
 IDS_REMOVABLE='Disco remov�vel';
 IDS_FIXEDDRIVE='Disco fixo';
 IDS_REMOTE='Disco da rede';
 IDS_CDROM='CD-ROM';
 IDS_RAMDISK='Disco virtual';
 IDS_USERNAME='Nome do usu�rio';
 IDS_WINDOWSDIR='Diret�rio do Windows';
 IDS_CURRDIR='Diret�rio corrente';
 IDS_FREESPACE='Espa�o livre do disco corrente';
 IDS_DISKSIZE='Espa�o total do disco corrente';
 IDS_SYSTEMDIR='Diret�rio do sistema';
 IDS_REGISTEREDOWNER='Usu�rio registrado';
 IDS_REGISTEREDCOMPANY='Compania registrada';
 IDS_VERSION='Vers�o';
 IDS_COLORDEPTH='N�mero de cores (in bits)';
 IDS_SCREENSAVERDELAY='Tempo para prote��o de tela';
 IDS_MEMORYSIZE='Total de mem�ria';
 IDS_FREESYSTEMRESOURCES='Recursos de sistema livres';
 IDS_FREEGDIRES='Recursos de GDI livres';
 IDS_FREEUSERRES='Recursos de usu�rio livres';
 IDS_COMPUTERNAME='Nome do computador';
 IDS_MAJORVERSION='Major version';
 IDS_BUILD='Build';
 IDS_MEMORYLOADED='Mem�ria utilizada';
 IDS_MEMORYFREE='Mem�ria livre';
 IDS_MEMORYFREEPAGES='P�ginas de mem�ria livres';
 IDS_MEMORYTOTALPAGES='Total de p�ginas de mem�ria';
 IDS_MEMORYVIRTUALFREE='Mem�ria virtual livre';
 IDS_MEMORYVIRTUALTOTAL='Total de mem�ria virtual';
 IDS_PLATFORMID='ID Platforma';
 IDS_PLATFORM='Platforma';
 IDS_PROCESSORNUMBER='N.de processadores';
 IDS_PROCESSOR='Processador';
 IDS_TEMPPATH='Dir.Tempor�rio';
 IDS_DOSVERSION='Vers�o DOS';
 IDS_NUMLOCK='NumLock';
 IDS_CAPSLOCK='CapsLock';
 IDS_SCROLL='ScrollLock';
 IDS_DATETIME='Data e hora';
 IDS_COMPANYNAME='CompanyName';
 IDS_PRODUCTNAME='ProductName';
 IDS_PRODUCTVERSION='ProductVersion';
 IDS_LEGALCOPYRIGHT='LegalCopyright';
 IDS_TRADEMARK='LegalTrademark';
 IDS_FILEDESCRIPTION='FileDescription';
 IDS_COMMENTS='Coment�rios';
 IDS_CPUSPEED='CPU Speed';


implementation

end.
