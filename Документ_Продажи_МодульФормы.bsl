
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПараметрыСкидкуДавать = Новый Структура;  
	
	// предопределенный для ФО связанных с РС
	ПараметрыСкидкуДавать.Вставить("Период",Объект.Дата);
	ПараметрыСкидкуДавать.Вставить("Контрагент",Объект.Контрагент); 
	
	// рисуем /перерисовываем Форму
	УстановитьПараметрыФункциональныхОпцийФормы(ПараметрыСкидкуДавать);
	
КонецПроцедуры



&НаКлиенте
Процедура СписокТоваровЦенаПриИзменении(Элемент)
	
	// Для  расчета скидки  
	ТекСтрока = Элементы.СписокТоваров.ТекущиеДанные;
	РассчитатьСумму(ТекСтрока);
	
КонецПроцедуры


&НаКлиенте
Процедура СписокТоваровКоличествоПриИзменении(Элемент)
	
	// Для  расчета скидки  
	ТекСтрока = Элементы.СписокТоваров.ТекущиеДанные;
	РассчитатьСумму(ТекСтрока);
	
КонецПроцедуры


//&НаКлиенте
&НаКлиентеНаСервереБезКонтекста
Процедура РассчитатьСумму(ТекСтрока)	
	
	// передается Параметром
	// получение текущих Данных Формы	
	// ТекСтрока = Элементы.СписокТоваров.ТекущиеДанные;	
	ТекСтрока.Сумма = ТекСтрока.Цена * ТекСтрока.Количество;
	
КонецПроцедуры


// получение Цены из Спр. Товары
&НаКлиенте
Процедура СписокТоваровТоварПриИзменении(Элемент) 
	
	ТекСтрока = Элементы.СписокТоваров.ТекущиеДанные;
	ТекСтрока.Цена = СписокТоваровТоварПриИзмененииНаСервере(ТекСтрока.Товар); 
	// пересчитываем сумму при изменении Цены
	РассчитатьСумму(ТекСтрока);
	
КонецПроцедуры


&НаСервереБезКонтекста
Функция  СписокТоваровТоварПриИзмененииНаСервере(Товар)
	
	Возврат Товар.Цена;
	
КонецФункции

&НаКлиенте
Процедура Скидка(Команда)
	СкидкаНаСервере();
КонецПроцедуры  


&НаСервере
Процедура СкидкаНаСервере()
	
	// Обход ТЧ Скидка 10 %   	
	Для каждого СтрокаТЧ Из Объект.СписокТоваров Цикл
		
		СтрокаТЧ.Цена = СтрокаТЧ.Цена * 0.9;			
		РассчитатьСумму(СтрокаТЧ);  
		
	КонецЦикла;	
	
КонецПроцедуры

&НаКлиенте
Процедура Подбор(Команда)
	
	ПараметрыОткрытияФормы = Новый Структура();
	
	ПараметрыОткрытияФормы.Вставить("Склад", Объект.Склад);
	
	ОткрытьФорму("Справочник.Товары.Форма.ФормаВыбораСОстатком",ПараметрыОткрытияФормы, ЭтаФорма); 
	
КонецПроцедуры   


// получаем из Формы подбора "ссылку" во Вр.Хр. на выбранные товары
&НаКлиенте
Процедура ОбработатьПодбор(Адрес) Экспорт 
	
	ОбработатьПодборНаСервере(Адрес);
	
КонецПроцедуры 

// Сервер + Контекст
&НаСервере
Процедура ОбработатьПодборНаСервере(Адрес) Экспорт 
	
	СписокТоваровВоВремХранилище = ПолучитьИзВременногоХранилища(Адрес); 
	
	Объект.СписокТоваров.Загрузить(СписокТоваровВоВремХранилище);
	
КонецПроцедуры 



&НаКлиенте
Процедура КонтрагентПриИзменении(Элемент)
	
	ПараметрыСкидкуДавать = Новый Структура;  
	ПараметрыСкидкуДавать.Вставить("Период",Объект.Дата);
	ПараметрыСкидкуДавать.Вставить("Контрагент",Объект.Контрагент); 
	
	УстановитьПараметрыФункциональныхОпцийФормы(ПараметрыСкидкуДавать);
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	ПараметрыСкидкуДавать = Новый Структура;  
	ПараметрыСкидкуДавать.Вставить("Период",Объект.Дата);
	ПараметрыСкидкуДавать.Вставить("Контрагент",Объект.Контрагент); 
	
	УстановитьПараметрыФункциональныхОпцийФормы(ПараметрыСкидкуДавать);
	
КонецПроцедуры
