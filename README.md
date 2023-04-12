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
    - Закладка "Представление"
        - Форма Выбора :`ФормаВыбораСОстатком`
            - Форма, которая открывается  по команде "Показать все"
    - ИЗ форм Выбора (Списка) **НЕ** стоит делать **ОТЧЕТ ! ! !** 
        - Форма  "ловит" события измененния Объектов *(только по кнопке "Обновить")*
        - если будет много соединений таблиц →  НЕ оптимальная работа системы


##### 14.Интерактивная передача параметров

- Добавляем в систему Спр. "Склады"
    - в РН "Остатки Товаров"  добавляем  Измерение
    - добавляе реквизит в Документы
        - "Покупка";
        - "Продажи"
            - необходимо  добавить реквизит  на Форму Документа
- Постановка
    - необходимо, чтобы при выборе Товара Пользователь видел остатки ТОЛЬКО по Складу, выбранному в Шапке Документа:
        - т.е. передать Значение `Склад` в открываемую Форму (Форма Выбора с Остатками  Спр. "Товары")
        - Реквизит "Товар"  ТЧ "Список Товаров" :
            - Св-во "Связи Параметров Выбора" = ` Склад(Склад)`: 
                - Имя : Склад → *как передадим - можно изменить*
                - Реквизит : Склад → как *поймаепт Форма при открытии*
                - Режим изменения связанного значения  → Очищать  
        - Настройки Формы Выбора с Отстатками (Динамичский список)
            - необходимо в [Запрос](https://github.com/alex-dev-2020/Managed-Forms/commit/5f1ed09f1db6c038c0b1ea55db49daf2a38aaaca)  добавить Парметр
                - `Склад = &Склад` 
            - "слетела"  основная таблица, возвращаем  Значение: Спр. "Товары"
- Форма Выбора с Остатками  Спр. "Товары" 
    - [`ПриСозданииНаСервере`](https://github.com/alex-dev-2020/Managed-Forms/commit/39200f0df177160f11196d5da44e2f1ba442392b)
        - Устанавливаем переданное Значение Параметра  (*СКД* `Склад`)  из  Реквизита `Склад` Док. "Продажи"
    - для отладки Создаем Процедуру `ПриОткрытии`
- Смотрим в Приложении поведение
    - Параметры : → `ДанныеФормыСтруктура`:
        - → Сервер много парметров
        -  →  Клиент : Событие `ПриОткрытии`:        
        - остались ТОЛЬКО ключевые:
            - `КлючНазначенияИспользования	"" Строка` 
            - `РежимВыбора	Истина	Булево` 	
- Генерим недостающие НСИ
- [Корректируем](https://github.com/alex-dev-2020/Managed-Forms/commit/136d9bb1358c0c32c6433bd38664c207e69c3be1) Отчет с учетом поля  Склад


##### 15.Программная передача параметров, механизм подбора

- программное откртытие Формы
    - Док. "Продажи":
        - создаем Команду "Подбор" 
            - выносим на форму
            - Действие Команды
            - Клиент: 
                - описываем Параметры открытия Формы : 
    `ПараметрыОткрытияФормы.Вставить("Склад", Объект.Склад)`
                - [открываем Форму](https://github.com/alex-dev-2020/Managed-Forms/commit/e43abead893499da74fe8bf97bb11c59589d965a)      
- Данный механизм можно использовать вместо команды "Показать все"  
- Постановка:
    - реализовать Форму подбора в ТЧ  Док. "Продажи" (в т.ч. с возможностью перетаскивания)
    - ДВЕ Таблицы на  Форме  Подбора :
        - Копия ТЧ Док. "Продажи" *(необходиммо с Клиента на Клиент  передатьТЧ)*
        - Таблица остатков с Отбором по Складу   
    - Временное Хранилице и приемы работы с ним
- Реализация:
    - Добавлям на Форму `ФормаВыбораСОстатком` Реквизит с типом ТЗ: "Выбранные Товары"
        - т.к. Клиент , тип данных `(ТаблицаЗначений)` → проекция ТЗ на форму 
        - добавляем колонки Реквизитов
            - `Товар`  → Спр. "Товары" 
            - `Количество`  → Число  
    - выносим на Форму НИЖЕ Списка Товаров 
    - изменяем высоту о Обеих таблиц (5 строк -?)
    - События
        - Выбора
            - двойной клик по строке → обрабатываем Событие "Выбор" 
            - [Клиент](https://github.com/alex-dev-2020/Managed-Forms/commit/1ad16abbf982ed5a50bfd9cc15ba875905273251) 
        - Перетаскивания   
            - Событие Таблицы ПРИЕМНИКА "Перетаскивание"
            - [Клиент](https://github.com/alex-dev-2020/Managed-Forms/commit/8064290cfc02679d1bcc43c3d55de1c6bcabb58c)
                - Параметры перетаскивания:
                    - ПараметрыПеретаскивания.Значение = Массив Ссылок на Товары в ТЧ 
                - Обходим Массив 
                    Создаем столько записей, сколько элементов в Массиве
- Приложение
    - тестим ТОЛЬКО перенос между таблицами Формы Подбора

##### 16.Перенос данных между формами с использованием хранилища значений

- Передать при закрытии Формы Подбора все, что выбрали 
    - Реквизиты
        - Товар;
        - Количество.
- При Закрытии Формы
    - на Формах  "Выбора с Остатком"  & Док."Продажи" данные не ВСЕ
- В форме Док."Продажи" при открытии Формы Подбора 
    - третьим параметром укажем **ВЛАДЕЛЬЦА** `ЭтаФорма`

 `ОткрытьФорму("Справочник.Товары.Форма.ФормаВыбораСОстатком",ПараметрыОткрытияФормы, ЭтаФорма); `  

- Создаем Команду `ЗавершитьПодбор`
    - выносим  на Форму выбора 
        - действие Команды
            - `Процедура ЗавершитьПодбор(Команда)`
            - вызываем Экспортную процедуру `ОбработатьПодбор()` Формы Док."Продажи" 
    - Это даст возможность из Формы Выбора "попасть" в Форму Док."Продажи" 
- далее необходимо:
    - таблицу с выбранными товарами нужно временно сохранить
        - Временное  Хранилище
            - ВСЕГДА Сервер (**реальная** таблица ИБ)
            - Время жизни :
                - пока существует форма
                - пока существует сеанс
                - до  первого К-С вызова (нужно  указать параметры)
        - Создаем Функцию  ` `:
            - пишем во Временное Хранилище выбранные товары 
            - вернем Адрес во  Временном  Хранилище
            - на стороне Сервера (С Контекстом)
                - необхоимо синхронизировать Данные Формы с Серверм (гарантировано)
            - Закрываем Форму Подбора
            - получаем из Временного Хранилища ТЗ
            - Грузим ТЗ в ТЧ Владельца  (Док."Продажи") 
    - при повторном открытии → данные ТЧ  обновяться !!!
- по сути :
    - формы меняются данными на стороне Сервера
        - Клиент 
            - выбираем Товары
        - Сервер
            - [сохраняем во Временное Хранилище](https://github.com/alex-dev-2020/Managed-Forms/commit/7aa8814edf217c3b410facee2dc7dfc8c1d692e8)  (Форма подбора)
            - [получаем из Временного Хранилища](https://github.com/alex-dev-2020/Managed-Forms/commit/c55c3a60292bfbdbab36cc8ab49b09ff031dde51)  (Форма Документа)
        - Клиент
            - показываем выбранные
     
##### 17.Работа с файлами и картинками. Выбор файла

- Постановка:
    - Загрузка картинки в Справочник
    - Диалог Открытия & Сохранения Файла
    - работа с Временным Хранилищем
        -  до момента загрузки картинки в Элемент Справочника его необходимо хранить 
- Реализация
    - создание реквизита в Спр. "Товары" `ДанныеКартинки`
        - релизация спорная, можно хранить в:
            - РС, 
            - подчиненном Спр.
        - Тип Данных: `ХранилищеЗначения` 
    - создаем Форму Элемента Спр."Товары"
        - дефолтная  
        - ДанныеКартинки → **НЕ доступен** в данных формы
    - для отображения Картинки создаем Новый Реквизит (Формы) `АдресКартинки`
        - Тип Данных: `Строка`
        - выносим на  Форму
        - Вид: `Поле Картинки`
    - реализация Загрузки файла изображения (два варианта)
        - Команды:
            - ВыбратьФайл1
            - ВыбратьФайл2
        - выносим на Форму 

 - Конфигурация
    - Совместимость
        - Режим использования Модальности : НЕ использовать (дефолтно)
        - блокировка интерактивной работы до выбора в Модальном Окне 
        - в большинстве браузеров (моб. клиентов) модальные окна **отключены**
    - необходимо:
        - Открыть оконо Выбора файла, при этом НЕ открывать его МОДАЛЬНО 

- Команда `ВыбратьФайл1`
    - Действие
        - Клиент
            - создаем Описание  о завершении
                - `ЭтотОбъект`
            - показываем  на Форме `Если НЕ ОписаниеФайла.ПомещениеФайлаОтменено`
                - `АдресКартинки = ОписаниеФайла.Адрес;` 
 
##### 18.Сохранение картинки. Конвертация данных формы в прикладной объект

- Событие сохранения данных может отличаться
    - как для Формы
        - отдельное событие, далее включаемое в событие самого Объекта
    - так и для Объекта
        - событие самого Объекта (запись данных)
- сейчас событие связано с Формой (`УникальныйИдентификатор`)
- Выбираем  событие `ПередЗаписьюНаСервере` :
    - еще не записали и Данные Формы нужны
- необходим признак модифицированности Формы
    - привязать к  Команде
        - **[]  ← чек-бокс**  Изменяет сохраняемые данные 
    - после проверки : `Если НЕ ОписаниеФайла.ПомещениеФайлаОтменено`
        - `Модифицированность = Истина;`
 - форму  НЕ Закроем, НЕ выбрав, что делвать с изменениями !!!

##### 19.Асинхронные вызовы (платформа 8.3.18 и выше)

- Второй Способ работы с НЕ Модальными окнами (появился с  8.3.18)
    - реализуем  Командой `ВыбратьФайл2` 
    - выносим на Форму 
        - Группа 
    - Действие Команды
        - Клиентская 
        - Обработчик загрузки данных на сервер, с диалогом выбора файла
            - [`Асинх Процедура ВыбратьФайл2(Команда)`](https://github.com/alex-dev-2020/Managed-Forms/commit/284fb9b4ef29a0f95bfb9eb64108fceb2f3616bc)
    - при успешном завершении выбора  файла  Картинки : в поле Формы передается Адрес (Картинки)    

##### 20.Функциональные опции

- Предлагается дать возможность Пользователю отображать Складской Учет
- Реализация:
    - создаем Костанту `УчетПоСкладам` 
        - Тип `Булево`
        - добавляем в Форму `ФормаКонстант`
        - снимаем чек-бокс [ ]  Использовать стандартные  команды (Закладка "Представление")
            - не отображается в Меню "Сервис"
    - создаем Функциональную Опцию: `УчетПоСкладам`
        - Хранилище: `Константа.УчетПоСкладам` 
        - чек-бокс [√] Привелигированный режим пр получении
            - т.е. даже  если у Пользователя НЕТ Прав на чтение Значения Команды 
             - значение будет  ПРОЧИТАНО
        - Закладка "Состав":
            - ТОЛЬКО Спр. "Склады"  
- Приложение:
    - поскольку дефолтное знаение Константы при создании `Ложь`
        -  →  в интерфейсе отсутствуют Склады (**ПОЛНОСТЬЮ**) 
- Обновление Интерфейса после установки значения Константы → Клиент Событие: `ПослеЗаписи`
    - [Форма Констант Модуль Формы](https://github.com/alex-dev-2020/Managed-Forms/commit/0aad6539091a2d3f51cbf1f1124996c0b2cc9631)  → **ОЧЕНЬ ресурсоёмкий метод ! ! !** 

##### 21.Адаптивный интерфейс. Параметры функциональных опций

- Вариативность интерфейса
    - доступность Команды "Скидка" в Док. "Продажи":
        - по ДАТЕ продажи
- Реализация:
    - создаем Периодический РС `СкидкуДавать`
        - Период : День
        - Данные: 
            - Измерение: `Контрагент` → Спр. Ссылка
            - Ресурс: `СкидкуДавать`  → Булево
    - Создаем Функциональную Опцию `СкидкуДавать` 
        - Хранение: `РегистрСведений.СкидкуДавать.Ресурс.СкидкуДавать`
        - в составе недоступны Команды Формы
        - Далее необходимы отборы:
            - Дата → изначально  стояла задача
            - Контрагент  → Измерение вообще  **НЕ** охвачено 
    - Параметры Функциональных Опций
        - Имя: `Контрагент`
        - Использование: `РегистрСведений.СкидкуДавать.Измерение.Контрагент`
     - В Документе необходимо указать
        - Связь КОМАНДЫ с Функциональной Опцией
            - Интерактивно: Поле  Функциональные опции
                - чек-бокс [√] `СкидкуДавать`
        - Устанавливаем Параметры Опции (Модуль Формы)
            - При Открытии формы
                - `ПриСозданииНаСервере`
            - При Смене Контрагента
                - Контрагент `ПриИзменениии`
            - При  Изменении Даты
                -Дата  `ПриИзменениии`
        - Везде одинаковый код:

```

	ПараметрыСкидкуДавать = Новый Структура;  
	
	// предопределенный для ФО связанных с РС
	ПараметрыСкидкуДавать.Вставить("Период",Объект.Дата);
	ПараметрыСкидкуДавать.Вставить("Контрагент",Объект.Контрагент); 
	
	// рисуем / перерисовываем Форму
	УстановитьПараметрыФункциональныхОпцийФормы(ПараметрыСкидкуДавать);


```
- Приложение
    - Устанавливаем "параметры" Скдки
        - Контрагент: "Мир"
        - Дата : 1-е число  текущего месяца
    - создаем Док. "Продажи":
        - В зависимости от Контрагента & Даты Документа, кнопка "Скидка" появляется / исчезает

- Постановка
    - НЕ по всем Контрагентам ведется  Договорной Учет
        - если Договорной Учет НЕ ведется: → Поле "Договор" в Форме НЕ показываем
- Реализация
    - Спр. "Контрагенты"
        - добавляем Реквизит:`УчетПоДоговорам` → Булево
    - Создаем Функциональную Опцию:
        - Имя: `УчетПоДоговорам`
        - Хранилище: `Справочник.Контрагенты.Реквизит.УчетПоДоговорам`
        - Состав: Спр. "Договоры"
    - Параметры Функциональных Опций
        - Использование
            - устанавливаем чек-бокс [√]  Спр "Контрагенты"

- Приложение:
    - Контрагент: "Свет" → Учет по Договорам ведется → 
    - Контрагент: "Мир"  → Учет по Договорам НЕ ведется
    - Создаем  Док. "Продажи":
        - Контрагент НЕ  заполнен:  Поля  "Договор" НЕТ
        - меняем  "Контрагента" → "Свет"
            - → Поле  "Договор"  есть / появляется
        - → меняем "Контрагента" → "Мир"
        


1. Функциональные Опциии
2. Настройка ролей Пользователя
3. Настройки Формы : "Еще" → "Изменить Форму"


       
            
        

