unit lmdconst;

interface

resourcestring
 IDS_PATH='Путь:';
 IDS_ON='ВКЛ';
 IDS_OFF='ВЫКЛ';

 //ButtonBar
 IDS_ADDSECTION='Д&обавить секцию';
 IDS_DELSECTION='Уд&алить секцию';
 IDS_RENSECTION='П&ереименовать секцию';
 IDS_ADDITEM='&Добавить элемент';
 IDS_DELITEM='&Удалить элемент';
 IDS_RENITEM='&Переименовать элемент';
 IDS_SMALLICONS='&Маленькие иконки';
 IDS_LARGEICONS='&Большие иконки';

 //EditControls
 IDS_INSERT='&Вставить';
 IDS_COPY='&Копировать';
 IDS_CUT='Выр&езать';
 IDS_UNDO='&Отменить';
 IDS_SELECTALL='Выделить все';
 IDS_DELETE='&Удалить';
 IDS_SEARCH='Поиск';
 IDS_SEARCHMSG1='Начало ... повторить с конца?';
 IDS_SEARCHMSG2='Конец ... повторить сначала?';
 IDS_REPLACE='Заменить';
 IDS_WORDWRAP='Перенос текста';
 IDS_LINED='Выравнивание';
 IDS_REDO='Вернуть';
 IDS_FONT='Шрифт';
 IDS_CLEAR='Очистить';
 IDS_ALIGNLEFT='Левое выравнивание';
 IDS_ALIGNRIGHT='Правое выравнивание';
 IDS_ALIGNCENTER='По центру';
 IDS_STATISTICS='Статистика текста';
 IDS_OPEN='Открыть';
 IDS_SAVE='Сохранить';
 IDS_PRINT='Печать';
 IDS_PAGE='Страница';

 // Component Messages
 IDS_MUSTSHOWONE='Должен быть выбран хотя бы один стиль!';
 IDS_INVALIDOWNER='Неверный предок (<>TForm) или на форме второй экземпляр';
 IDS_INTERVALNOTFIT='Недопустимое значение в свойстве MinInterval!';

 // TLMDAssist
 IDS_NEXT='&Далее >';
 IDS_BACK='< &Назад';
 IDS_FINISH='&Готово';
 IDS_HELP='&Помощь';
 IDS_CLOSE='&Закрыть';
 IDS_CANCEL='Отмена';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'Это свойство больше не доступно в LMD-Tools!';

 // TLMDMRUList
 IDS_CLEARLIST = 'Очистить список...';
 IDS_CLEARLISTHINT = 'Очистить список последних файлов';
 IDS_CLEARLISTREQUEST = 'Вы действительно хотите очистить список последних файлов?';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='приложение уже запущено...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Информация ';
 IDS_AboutAvailMemory='Доступная память:';
 IDS_AboutSysRes='Системные ресурсы:';
 IDS_AboutCompatible='или совместимый';
 IDS_AboutPlatform='Платформа, процессор:';
 IDS_FREE='свободно';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Выбор каталога...';
 IDS_DIRDRIVE='&Диск:';
 IDS_DIRPATH='&Путь:';
 IDS_NEWPATH='&Новый каталог';

 {TLMDTipDlg}
 IDS_TIPERROR='Диалог не доступен - не заполнено свойство Tips...';
 IDS_SHOWATSTART='Показывать при каждом запуске программы';
 IDS_TIPNEXT='&Следущий совет';
 IDS_TIPPREV='&Предыдущий совет';

 {TLMDWindowList}
 IDS_WLCAPTION='Список окон...';
 IDS_WLDESC='Доступные &окна:';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Календарь...';
 IDS_ACTUALDATE='Реальная дата';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Больше не показывать это сообщение';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Ввод...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Текстовый редактор';

 // LMDSYSIN
 // ****************************************************************************
 IDS_FILE='Файлы';
 IDS_NOROOTDIR='нет корневой директории';
 IDS_REMOVABLE='сменный';
 IDS_FIXEDDRIVE='жесткий диск';
 IDS_REMOTE='удаленные (сетевые) диски';
 IDS_CDROM='CD-ROM';
 IDS_RAMDISK='виртуальный диск';
 IDS_USERNAME='Username';
 IDS_WINDOWSDIR='Каталог Windows';
 IDS_CURRDIR='Текущий каталог';
 IDS_FREESPACE='Свободное пространство на текущем диске';
 IDS_DISKSIZE='Объем текущего диска';
 IDS_SYSTEMDIR='Системная директория';
 IDS_REGISTEREDOWNER='Зарегистрированный пользователь';
 IDS_REGISTEREDCOMPANY='Зарегистрированная компания';
 IDS_VERSION='Версия';
 IDS_COLORDEPTH='Разрешение (в битах)';
 IDS_SCREENSAVERDELAY='Время простоя для запуска хранителя экрана';
 IDS_MEMORYSIZE='Размер памяти';
 IDS_FREESYSTEMRESOURCES='Свободные системные ресурсы';
 IDS_FREEGDIRES='Свободные ресурсы GDI';
 IDS_FREEUSERRES='Свободные ресурсы пользователя';
 IDS_COMPUTERNAME='Имя компьютера';
 IDS_MAJORVERSION='Основная версия';
 IDS_BUILD='Сборка';
 IDS_MEMORYLOADED='Загруженная память';
 IDS_MEMORYFREE='Свободная память';
 IDS_MEMORYFREEPAGES='Свободных страниц памяти';
 IDS_MEMORYTOTALPAGES='Всего страниц памяти';
 IDS_MEMORYVIRTUALFREE='Свободная виртуальная память';
 IDS_MEMORYVIRTUALTOTAL='Всего виртуальной памяти';
 IDS_PLATFORMID='ID платформы';
 IDS_PLATFORM='Платформа';
 IDS_PROCESSORNUMBER='Количество процессоров';
 IDS_PROCESSOR='Процессор';
 IDS_TEMPPATH='Временная директория';
 IDS_DOSVERSION='Версия DOS';
 IDS_NUMLOCK='NumLock';
 IDS_CAPSLOCK='CapsLock';
 IDS_SCROLL='ScrollLock';
 IDS_DATETIME='Дата и время';
 IDS_COMPANYNAME='Имя компании';
 IDS_PRODUCTNAME='Название продукта';
 IDS_PRODUCTVERSION='Версия продукта';
 IDS_LEGALCOPYRIGHT='Принадлежность прав';
 IDS_TRADEMARK='Зарегистрированная торговая марка';
 IDS_FILEDESCRIPTION='Описание файла';
 IDS_COMMENTS='Комментарии';
 IDS_CPUSPEED='Скорость процессора';


implementation

end.
