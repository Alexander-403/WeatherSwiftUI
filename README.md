# WeatherSwiftUI

Простое iOS-приложение с использованием SwiftUI, показывающее погоду по выбранному городу.

## Функции
- Выбор города из списка (Локации России, Украины, Белоруссии, США, Франции и др.)
- Получение текущей погоды через API (OpenWeatherMap или аналог)
- Отображение температуры, описания, иконки погоды
- Русская локализация дат (день недели, месяц)

## Технологии
- SwiftUI
- Async/Await для сетевых запросов
- ObservableObject / @Published для ViewModel
- DateFormatter с русской локалью (ru_RU)

## Как запустить
1. Клонируй репозиторий: `git clone https://github.com/твой_логин/WeatherSwiftUI.git`
2. Открой в Xcode: WeatherSwiftUI.xcodeproj
3. Добавь свой API-ключ в WeatherService.swift (если используешь реальный API)
4. Запусти на симуляторе или устройстве

## Скриншоты
![0D417548-7AF0-448E-94BF-237FA8919A5D_4_5005_c](https://github.com/user-attachments/assets/b64542ab-27a9-4370-ab95-38fef9f16641)
