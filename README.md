##  Managed Forms
 Управляемые Формы (Чистов)

### Курс УФ Чистов

#####  01.Введение. Устройство клиент-серверного механизма платформы

Задача Клиент-Серверного взаимодействия
 - Сервер обрабатывает клиентские запросы к ИБ
 - необходимость в Данных Сеансов (пользователей)   

##### 02.Стандартное поведение форм на примере констант

8.3.18 - курс
[]()

- Дефолтные формы ОК в большинстве случаев на примере :
- Создание Констант :
    - `НазваниеОрганизации` 
        -  строка  60 символов 

    - `АдресОрганизации`
        - строка НЕ ограниченной длины  
        - Закладка *Представление*
            - [√] Многострочный режим
            - [√] Расширенное Редактирование (+ Hot Keys)

##### 03.Создание формы констант, конструктор управляемых форм

- Ограничения дефолтных Форм:
    - Необходимость открывать обе константы в одной форме
    - Создание Формы Констант (дефолтно в Общих Формах) Конструктором

        1. Конструктор Общих Форм
           - ТИП Формы →  [√]  Форма Констант (определит ОСНОВНОЙ  Реквизит Формы)
           - Имя Формы → `ФормаКонстант` 
           - Синоним → "Сведения об Организации"
           - [√]  Использовать стандартные  команды

        2. Реквизиты Формы
            - `НазваниеОрганизации` 
            - `АдресОрганизации`

        3. Готово →  Коструктор  Управляемой Формы
            - Область Реквизитов:  Данные, потенциально  видимые
            - Область Элементы & Командный интерфейс:  видимые Данные & Команды
               - Вид
               - Путь к данным → Реквизиты   
               - Видимость 
               - ...
            - Область просомотра

    - Приложение
        - "+" Добавился п. Меню Сервис "Сведения об Организации"
    - Конфигуратор
        - Группируем в одну группу оба Элемента
            - "+" Группа БЕЗ отображения 
            - Группировка: "Вертикальная"
            - Расположение: Ширина → 40 
##### 04.Открытие формы константы с использованием клиент-серверного механизма

- Имитация первого  запуска Системы:
    - Если "Название Организации" НЕ Заполнено → Форма открывается
    - [`Модуль_Приложения.bsl`](https://github.com/alex-dev-2020/Managed-Forms/commit/05794ee179b8bb94a58771f1f1e342ad59974924)
- Необходимость  создания Функции Серверного Общего Модуля
    - [√]  Сервер
    - [√]  Вызов сервера

    - [`ОБщий_Модуль_Сервер.bsl`](https://github.com/alex-dev-2020/Managed-Forms/commit/9efae0434078485c5899e70a9643a18bf04d60a9)

- убираем из интерфейса пункты:
        - "Адрес Организации"
        - "Название Организации"
    - Сойства Константы 
        - Закладка "Представление"
        - чек-бокс  [ ]  Испаользовать стандартные  команды

##### 05.Стандартное поведение формы документа

- Конфигуратор
    - Создание  Документа "Продажи" с ТЧ "Список товаров"
        - Спр. "Товары"
            - доп. реквизит "Цена"
        - Реквизиты ТЧ Документа
            - Товар;
            - Цена;
            - Количество;
            - Сумма.

- Приложение / Конфигуратор:
    - Список задач :
        - Получение значений цены из Спр. "Товары"
        - Пересчет Сумм по ТЧ
        - Запрет НЕ Заполненных Значений для поля ТЧ "Товар"
            - Реквизит ТЧ Закладка "Представление" (в Окне Св-в Док. "Продажи")
                - проверка заполнения → выдавать ошибку
            - **аналогично  целиком дляч ТЧ !!!** 

##### 06.Чтение и запись данных в информационной базе

- прикладной Объект :
    - сериализация прикладного Объекта в Данные Формы
    - Сервер: Конструктор УФ → создание  Формы по описанию
    - Клиент: открытие Формы с Данными 
- Два Состояния формы:
    - проекция Формы (Сервер)
    - Форма На Клиенте
- Десериализация Формы в прикладной Объект при записи в ИБ 

##### 07.Директива компиляции НаКлиенте

- Пересчет Сумм по ТЧ
    - Создание Формы  Док. "Продажи"
        - Реквизиты дефолтные
    - Настройки отображения Формы:
        - Настройки в приложении "Еще → Изменить Форму";
        - Влияние ролей на отображение Реквизитов; 
        - Влияние Функциональных Опций.
    - Объект: 
        - Тип: (Объект.Документ.Продажи)
    - Элементы Формы:
        - поле ТЧ "Цена", Закладка "События"
            - Обработчик события При Изменении `&НаКлиенте`
        - Отладка:
            - При НЕ отображении на Форме данных (`Движения`) их В Объекте **НЕТ!!!** - *эконоимия трафика*
            - Элементы Формы:
                - `Элементы.СписокТоваров.ТекущиеДанные`  - 
                - `Элементы.СписокТоваров.ТекущаяСтрока` → **ИДЕНТИФИКАТОР** Строки !!!
        - поле ТЧ "Количество", Закладка "События"
            - Обработчик события При Изменении `&НаКлиенте`
            - создаем  Отдельный Обработчик
        - выносим расчет в Отдельную процедуру

       [Документ_Продажи_МодульФормы.bsl](https://github.com/alex-dev-2020/Managed-Forms/commit/acd54d679dd24f834b03dd742dd51d1105e75ffb)  

##### 08.Директива компиляции НаСервереБезКонтекста 

- Получение значений цены из Спр. "Товары"
    - Элементы Формы:
        - поле ТЧ "Товар", Закладка "События"
            - Контекст (ВСЕ Данные Формы)  **НЕ НУЖЕН**  →  `&НаСервереБезКонтекста`
            - НО при этом необходимо  передать Товар

    [Документ_Продажи_МодульФормы.bsl](https://github.com/alex-dev-2020/Managed-Forms/commit/d89ade7ae1ee7eff3956842cc46c0183d670d991) - *добавлен серверный  вызов  БЕЗ Контекста*

##### 09.Директивы компиляции НаСервере, НаКлиентеНаСервереБезКонтекста

- Необходимость Контекстного Серверного Вызова
    - Печать Формы: 
        - нужен  Макет;
        - все  строки  ТЧ все равно  нужны.
    - Изменение БОЛЬШЕЙ части (или ВСЕХ) Данных Формы:
        - скидка по всем строкам ТЧ; 
        - получение Данных из ИБ (Цена Товара п.8):
            - (считаем на сервере, а НЕ  построчно обходим на форме)
- Реализация функционала предоставления скидки по нажатию кнопки на Форме Док."Продажи" 
    - "+" Команда Формы  "Скидка" 
    - Действие Команды:
        - Клиент →  вызов проыедуры на Сервере
        - Сервер → Обхоим ТЧ  переопределяем Поле "Цена" 
    
    `СтрокаТЧ.Цена = СтрокаТЧ.Цена * 0.9;` 

    - Выносим Кнопку на Форму 
    - Тестим в Приложении  

- Сумма не пересчитывается:
    - со стороны Сервера **НЕВОЗМОЖНО** вызвать Клиентскую процедуру для Пересчета в текущем виде
    - Директива `&НаКлиентеНаСервереБезКонтекста` :
        - при Компиляции будет создано ДВЕ процедуры с ОДИНАКОВЫМ кодом:
            - `&НаКлиенте`
            - `&НаСервереБезКонтекста`
        - можно вызвать со стороны Сервера
    - Ограничения:
        - **КОНТЕКСТ должен быть УНИВЕРСАЛЬНЫЙ**:
            - добавление (передача с Клиента) необходимых параметров(аргументов)
    - Передаем в процедуру Текущцую Строку ТЧ из ВСЕХ точек вызова 
    - Вызываем в цикле обхода ТЧ после расчета Скидки 
                
        [Документ_Продажи_МодульФормы.bsl](https://github.com/alex-dev-2020/Managed-Forms/commit/f16a491634c96d5ef2364b5e3e572ce9423fd9c7) - *расчет скидки по  кнопке на форме*

##### 10.Общие команды, параметризуемые команды

- Команды
    - Команда Формы 
        - в свойствах Кнопки указано Имя Команды → соотв. Действие
- Общие Команды
    - ранее созданная Форма Констант: снимаем Признак использования стандартных Команд 
        - Группа Команд: → упорядочивание Интерфейса
    - создаем Общую Команду "Настройка Сведений"
        - Группа Команд → "Сервис"
        - [Модуль команды initial commit](https://github.com/alex-dev-2020/Managed-Forms/commit/3ea00d40160c9ad2105392b43bcf5b6e94963eb8) 

    - Подставляем название Формы, вызываем  Команду в Приложении:

     - [Модуль команды + "Имя Формы"](https://github.com/alex-dev-2020/Managed-Forms/commit/7025d1a77b128da8c65b623c0521edbfe4fbe27f) 

- Параметризуемые Команды
    - Необходимость:  создадим Команду печати для: 
        - пакетной  печати докуметов "Продажи"
        - возможности вызова НЕ из Формы  Документа 
        - будет  Отображаться ВЕЗДЕ, где её ПАРАМЕТР  будет отображаться 
    - Создание команды Печать НЕ используя Конструктор Печати
        - Окно Св-в Объекта Док."Продажи", закладака "Команды"
            - Имя:  Печать   
            - Группа: Командная панель формы.Важное
            - Тип Параметра Команды: ДокументСсылка.Продажи
                - ВЕЗДЕ,где будет присутствовать такой ТИП → будет доступна эта команда
            - Режим использования параметра: Множественный (будет  доступна пакетная печать)
            - чек-бокс [ ] Изменяет данные  (признак модифицированности Объекта) 
- Приложение
    - в Формах Списка и Документа "Продажи" появилась кнопка "Печать"

- Формирование Печатной Формы
    - Получаем  Макет
        - Серверная процедура `ПечатьНасервере` Модуля Команды 
        - создаем простой Макет
            - Дата Документа
            - № Документа   
    - С Клиента Передаем в  `ПечатьНасервере`
        - ТабДок
        - ПараметрКоманды → Массив Ссылок на Документы
        - Обходим в Цикле Массив: 
            - заполняем Параметры Область
            - выводим область  
    - возвращаемся на Клиент
    - Показываем ТабДок 

- [Документ_Продажи_МодульКоманды_Печать.bsl](https://github.com/alex-dev-2020/Managed-Forms/commit/d3ee74daecc3da44f65495c4bc76174b1e609ea5) 


##### 11.Конструктор печати, модуль менеджера

- Конструктор Печати 
    - Закладка "Макеты"
        - Создание НОВОЙ Команды (Печати) → `Печать2` 
        - Выбор Реквизитов  Док. "Продажи
            - Дата
            - Номер 
        - Выбор Реквизитов ТЧ
            - ВСЕ 
        - Подвал Документа → нет реквизитов
        - Группа Команды: Командная панель формы.Важное
            - чек боксы
                - [ ]  Печатать БЕЗ предв. просмотра
                - [√]  Таблица "только просомтр"
                - [√]  Защита таблицы 
        - ОК
    - Созданы
        - Макет ПФ Док. "Продажи" → `Макет2` 
        - Команда "Печать 2"
            - свойства Команды (Настройки) - аналогичны ранее созданной
            - [Модуль Команды:](https://github.com/alex-dev-2020/Managed-Forms/commit/420803ff427242fe6f5ed14dd0dabcd60d85548b)
                - Настройки отображения ПФ Документа:
                    - сетка;
                    - защита;
                    - просмотр
                - вызов Экспортной  процедуры `Печать2(ТабДок, Ссылка)`  из  [Модуля Менеджера](https://github.com/alex-dev-2020/Managed-Forms/commit/d00aa02b59663b3bd83759be58289da0f7d2b959) Док. "Продажи"  
                - возвращаемся на Клиент;
                - Показываем ТабДок.
- Модуль Менеджера Документа позволяет
    - увеличить кол-во Методов Класса Документа;
    - структурировать Методы Класса Документа:
        - Работа с Представлениями;
        - Работа с Формой;
        - получение Даных Выбора.
    - переопределять вышеуказанные Методы (Процедуры)        
##### 12.Глобальные параметризуемые команды, связи параметров выбора

- Добавляем два Спр. :
    - "Контрагенты"
    - "Договоры"  → подчинены Спр. "Контрагенты"
        - по сути это Параметр, значением которого будет являться `Контрагнет`
        - при этом в Системе появляется Глобальная Параметризуемая Команда  
- Добавляем  в Док. "Продажи"  новые  реквизиты 
- Выносим на Форму  Документа
- В Глобальных  Командах Формы добавилась Параметризуемая Команда `Договоры (Объект.Контрагент)`
    - дает возможность **открыть Форму Спр. "Договоры" с Отбором по Контрагенту**
    - выносим  Команду на форму 
- В Приложении:
    - Вводим НСИ; 
        -  на форме  Элемента Спр. "Контрагенты" появилась г/ссылка "Договоры"
    - моделируем ситуацию:
    - Контрагент введен, вызываем Команду  "Договоры" 
        - открывается  форма списка Спр."Договоры"  с Отбором  по Контрагенту
    - таким образом везде, где будет доступпен Контрагент, будет Команда "Договоры"с параметром (Контрагент)
    - аналогичная ситуация будет с Регистрами: Отбор по Регистратору (надо выносить ее явно на форму !!!)
- Удаляем Кнопку с Формы 
    - форма списка Спр."Договоры" открывается  теперь  БЕЗ Параметра (Отбора)
- реализуем отбор через Параметры Выбора  
    - форма  НЕ нужна, Св-во Реквзита "Договор" 
    - Закладка "Представление"
        - Связи Параметров Выбора: → 
            - Отбор.Владелец = Контрагент	
            - Режим Изменения Связанного Значения → Очищать
- Использование Команд в Командном Интерфейсе Формы
    - В Форму в Командный Интерфейс в Группу "Перейти" добаляем Команду `Договоры (Объект.Контрагент)`из Глобальных 
        - устанавливаем [√] Видимость   

##### 13.Динамический список

- для учета остатков создаем Регистр Накопления
    - Остатки Товаров
        - Измерения:
            - Товар  [√] запрет НЕ заполненых  
        - Ресурс: 
            - Количество
        - Регистраторы
            - Док. "Продажи " → движения в "-"
            - Док. "Покупка" → движения в "+" (создаем  копированием  Док."Продажи" )
- Док. "Покупка" → создаем  копированием  Док."Продажи" 
    - Форму Документа **УДАЛЯЕМ** в Окне Св-в Объекта (*для чистоты  эксперимента*)
    - Конструктором Джвежиений Форомируем Движения в "+" по РН "Остатки Товаров"
- Создаем  Отчет "Остатки"
    - [СКД Запрос](https://github.com/alex-dev-2020/Managed-Forms/commit/c7c62bd9ee2d779df3116db1c304e7abfaa62fd3)
    - Одна группировка: детальные записи
- Постановка:
    - при создания Док. "Продажи " небходимо: 
        - дать возможность Пользователю видеть остатки в Форме выбора  Спр. "Товары" 
- Реализация:
    - Спр. "Товры" добавяляем НЕ ОСНОВНУЮ Форму Выбора Справочника `ФормаВыбораСОстатком` 
        - [ ] Назначить Фору основной
        - Элементы Формы
            - [√] Наименование
            - [√] Код
            - [√] Цена
    - Конструктор Формы
        - Добавляем Поле "Остаток"
            - Тип Данных Реквизита Формы "Список":
                - почти СКД (кроме Сортировок & Итогов)
            - Св-ва Объекта
            - **[√]  ← чек-бокс**  Произвольный запрос 
                ↓↓↓
            - Настройки списка:
                -  Основная Таблица:  определяет Вид & Команды Формы 
                - [√] Динамическое Считываание Данных (по мере скролла)
                - [√] Автозаполнение доступных Полей (СКД)
            - Конструктор Запроса 
                - [`Форма_Выбора_С_Остатком_СКД_Запрос`](https://github.com/alex-dev-2020/Managed-Forms/commit/4461e058a0a0ca502e13fef1d72c556b15f26f59)
                - **Основная Таблица:** Спр. "Товары"
        - в составе реквизитов появилось Поле `КоличествоОстаток`
            - выносим на Форму в последнюю колонку
                - Закладка "Расположение"
                    - ширина 6 символов 
- Привязываем Форму к Док. "Продажи"  к реквизиту "Товар"
    - Закладка "представление"
        - Форма Выбора :`ФормаВыбораСОстатком`
            - Форма, которая открывается  по команде "Показать все"
    - ИЗ форм Выбора (Списка) НЕ стоит делать  ОТЧЕТ
        - Форма  "ловит" события измененния Объектов (только по кнопке "Обновить)
        - если будет много соединений таблиц →  НЕ оптимальная работа системы


##### 14.Интерактивная передача параметров

######

##### 15.Программная передача параметров, механизм подбора

######

##### 16.Перенос данных между формами с использованием хранилища значений

######

##### 17.Работа с файлами и картинками. Выбор файла

######

##### 18.Сохранение картинки. Конвертация данных формы в прикладной объект

######

##### 19.Асинхронные вызовы (платформа 8.3.18 и выше)

######

##### 20.Функциональные опции

######

##### 21.Адаптивный интерфейс. Параметры функциональных опций