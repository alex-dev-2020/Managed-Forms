
// ПараметрКоманды
//  ПараметрыВыполненияКоманды
// 	Источник → ОкноКлиентскогоПриложения
// 	Уникальность  → Ложь 




&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	     
	
	ПараметрыФормы = Новый Структура("", );
	ОткрытьФорму("ОбщаяФорма.ФормаКонстант", 
			ПараметрыФормы, 
			ПараметрыВыполненияКоманды.Источник, 
			ПараметрыВыполненияКоманды.Уникальность, 
			ПараметрыВыполненияКоманды.Окно, 
			ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
КонецПроцедуры    
		
		
		
		

