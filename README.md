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

######

##### 10.Общие команды, параметризуемые команды

######

##### 11.Конструктор печати, модуль менеджера

######

##### 12.Глобальные параметризуемые команды, связи параметров выбора

######

##### 13.Динамический список

######

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