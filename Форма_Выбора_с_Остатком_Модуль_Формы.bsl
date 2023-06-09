

// При открытии Формы из Док. "Продажи" ловим СКЛАД	  
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Список.Параметры.УстановитьЗначениеПараметра("Склад", Параметры.Склад);	
	
КонецПроцедуры

// отладка
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	//Вставить содержимое обработчика
КонецПроцедуры


&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	// Отключаем, чтобы не закрывалась 	
	СтандартнаяОбработка = Ложь ;
	
	// Выбранную Строку добавляем в табл. Выбранные Товары
	НоваяСтрока = ВыбранныеТовары.Добавить(); 	
	НоваяСтрока.Товар = ВыбраннаяСтрока;
	//хардкодим одну штуку 
	НоваяСтрока.Количество = 1;
	
КонецПроцедуры


&НаКлиенте
Процедура ВыбранныеТоварыПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	Для каждого СтрокаМассива Из ПараметрыПеретаскивания.Значение Цикл
		
		НоваяСтрока = ВыбранныеТовары.Добавить(); 	
		НоваяСтрока.Товар = СтрокаМассива;
		//хардкодим одну штуку 
		НоваяСтрока.Количество = 1
		
		
	КонецЦикла;
	
КонецПроцедуры


&НаКлиенте
Процедура ЗавершитьПодбор(Команда)
	
	Адрес = ЗавершитьПодборНаСервере();
	// возвращаем Владельцу "ссылку" во Вр.Хр. выбранные товары
	ВладелецФормы.ОбработатьПодбор(Адрес);	
	Закрыть();
	
КонецПроцедуры          

&НаСервере
Функция ЗавершитьПодборНаСервере()
	
	Адрес = ПоместитьВоВременноеХранилище(ВыбранныеТовары.Выгрузить());
	Возврат Адрес;
	
КонецФункции



