unit lmdconst;

interface

resourcestring
 IDS_PATH='Caminho:';
 IDS_ON='ON';
 IDS_OFF='OFF';

 //ButtonBar
 IDS_ADDSECTION='&Adicionar Seção';
 IDS_DELSECTION='&Excluir seção';
 IDS_RENSECTION='&Renomear seção';
 IDS_ADDITEM='&Adicionar Item';
 IDS_DELITEM='&Excluir Item';
 IDS_RENITEM='&Renomear Item';
 IDS_SMALLICONS='Ícone &pequeno';
 IDS_LARGEICONS='Ícone &grande';

 //EditControls
 IDS_INSERT='&Inserir';
 IDS_COPY='&Copiar';
 IDS_CUT='&Cortar';
 IDS_UNDO='&Desfazer';
 IDS_SELECTALL='Selecionar todos';
 IDS_DELETE='&Excluir';
 IDS_SEARCH='Procurar';
 IDS_SEARCHMSG1='No topo ... recomeçar do final?';
 IDS_SEARCHMSG2='No fim ... recomeçar do topo?';
 IDS_REPLACE='Substituir';
 IDS_WORDWRAP='Quebrar linha';
 IDS_LINED='Lined';
 IDS_REDO='Refazer';
 IDS_FONT='Fonte';
 IDS_CLEAR='Limpar';
 IDS_ALIGNLEFT='Alinhar a esquerda';
 IDS_ALIGNRIGHT='Alinhar a direita';
 IDS_ALIGNCENTER='Centralizar';
 IDS_STATISTICS='Estatística do texto';
 IDS_OPEN='Abrir';
 IDS_SAVE='Salvar';
 IDS_PRINT='Imprimir';
 IDS_PAGE='Página';

 // Component Messages
 IDS_MUSTSHOWONE='Um tipo de relógio deve estar ativo!';
 IDS_INVALIDOWNER='Owner inválido (<>TForm) ou segunda instância do form';
 IDS_INTERVALNOTFIT='Intervalo não compatível com a propriedade MinInterval!';

 // TLMDAssist
 IDS_NEXT='&Próximo >';
 IDS_BACK='< &Anterior';
 IDS_FINISH='&Fim';
 IDS_HELP='A&juda';
 IDS_CLOSE='&Fechar';
 IDS_CANCEL='Cancelar';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'Esta propriedade não está sendo mais usada pelo LMD-Tools!';

 // TLMDMRUList
 IDS_CLEARLIST = 'Limpar lista...';
 IDS_CLEARLISTHINT = 'Limpar a lista de arquivos recentes';
 IDS_CLEARLISTREQUEST = 'Quer limpar realmente a lista de arquivos recentes?';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='já foi iniciado...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Info ';
 IDS_AboutAvailMemory='Memória disponível:';
 IDS_AboutSysRes='Recursos do sistema:';
 IDS_AboutCompatible='ou compatível';
 IDS_AboutPlatform='Platforma, CPU:';
 IDS_FREE='livre';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Selecione o diretório...';
 IDS_DIRDRIVE='&Drive:';
 IDS_DIRPATH='&Diretório:';
 IDS_NEWPATH='&Novo diretório';

 {TLMDTipDlg}
 IDS_TIPERROR='Nenhuma dica disponível - A tela de diálogo não será mostrada...';
 IDS_SHOWATSTART='Sempre mostre as dicas ao iniciar';
 IDS_TIPNEXT='&Dica seguinte';
 IDS_TIPPREV='&Dica anterior';

 {TLMDWindowList}
 IDS_WLCAPTION='Windowlist...';
 IDS_WLDESC='&Janelas disponíveis:';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Calendário...';
 IDS_ACTUALDATE='Data real';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Não mostre de novo';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Entrada...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Editor de Texto';

 // LMDSYSIN
 // ****************************************************************************
 IDS_FILE='Arquivos';
 IDS_NOROOTDIR='sem diretório raiz';
 IDS_REMOVABLE='Disco removível';
 IDS_FIXEDDRIVE='Disco fixo';
 IDS_REMOTE='Disco da rede';
 IDS_CDROM='CD-ROM';
 IDS_RAMDISK='Disco virtual';
 IDS_USERNAME='Nome do usuário';
 IDS_WINDOWSDIR='Diretório do Windows';
 IDS_CURRDIR='Diretório corrente';
 IDS_FREESPACE='Espaço livre do disco corrente';
 IDS_DISKSIZE='Espaço total do disco corrente';
 IDS_SYSTEMDIR='Diretório do sistema';
 IDS_REGISTEREDOWNER='Usuário registrado';
 IDS_REGISTEREDCOMPANY='Compania registrada';
 IDS_VERSION='Versão';
 IDS_COLORDEPTH='Número de cores (in bits)';
 IDS_SCREENSAVERDELAY='Tempo para proteção de tela';
 IDS_MEMORYSIZE='Total de memória';
 IDS_FREESYSTEMRESOURCES='Recursos de sistema livres';
 IDS_FREEGDIRES='Recursos de GDI livres';
 IDS_FREEUSERRES='Recursos de usuário livres';
 IDS_COMPUTERNAME='Nome do computador';
 IDS_MAJORVERSION='Major version';
 IDS_BUILD='Build';
 IDS_MEMORYLOADED='Memória utilizada';
 IDS_MEMORYFREE='Memória livre';
 IDS_MEMORYFREEPAGES='Páginas de memória livres';
 IDS_MEMORYTOTALPAGES='Total de páginas de memória';
 IDS_MEMORYVIRTUALFREE='Memória virtual livre';
 IDS_MEMORYVIRTUALTOTAL='Total de memória virtual';
 IDS_PLATFORMID='ID Platforma';
 IDS_PLATFORM='Platforma';
 IDS_PROCESSORNUMBER='N.de processadores';
 IDS_PROCESSOR='Processador';
 IDS_TEMPPATH='Dir.Temporário';
 IDS_DOSVERSION='Versão DOS';
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
 IDS_COMMENTS='Comentários';
 IDS_CPUSPEED='CPU Speed';


implementation

end.
