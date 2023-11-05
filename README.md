# Part-Time-Jobs
![iOS](https://img.shields.io/badge/iOS-15%20-white?logo=Apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-5.8.1-red?logo=Swift&logoColor=red)
![Xcode](https://img.shields.io/badge/Xcode-14.3.1%20-00B2FF?logo=Xcode&logoColor=00B2FF)

Тестовое задание на стажировку @NDA

Приложение показывает список подработок с возможностью выбора для дальнейшего бронирования.

## Preview
<details>
<summary>Экран списка подработок</summary>
 
![JobListScreen](https://github.com/2late2bad/PartTimeJobs/assets/121951550/73e95086-f234-49dc-9e94-77afb91fe13b) |

</details>

## Tech stack
* UIKit
* GCD
* URLSession
* async/await
* UserDefaults
* MVP + Coordinator

## Highlights
* Верстка только кодом
* Для моделей данных использованы только структуры
* Поиск фильтрует содержание списка по двум параметрам
* Поиск не сбрасывает состояние выбранных подработок
* Список создан с использованием UICollectionViewCompositionalLayout и UICollectionViewDiffableDataSource
* Реализовано восстановление состояния выбранных подработок после перезапуска приложения
* Универсальный дженерик NetworkService на async/await
* Кэширование загруженных изображений
* UI адаптирован под любой iPhone
* Без использования сторонних библиотек
