# Спринт 11. Выполнение заданий

## Задание 1. Модульная инфраструктура для нескольких сред
  Развертывание VM с использованием terraform, который настроен локально. 
  Описание шагов по развертыванию и результаты в виде скринов описаны в файле: [Описание](/Task1Advanced/README.md)

  [Результат задания](/Task1Advanced/)

  Важный момент registry для terraform был настроен локально с использованием переменной окружения (TF_CLI_CONFIG_FILE) и настроек пользователя

## Задание 2. Интеграция с CI/CD и удалённым хранением состояния
  Автоматизация развёртывания инфраструктуры через CI/CD, используя удалённое состояние (S3/Minio + backend)
  [Результат задания](/Task2Advanced/) - смотрите описание [README](/Task2Advanced/README.md)

## Задание 3. Проектирование целевой архитектуры и оценка рисков внедрения
  Проектирование целевой архитектуры системы «Будущего 2.0» в горизонте трёх лет, с использованием C4-модель на уровне контейнеров и компонентов.  
  [схема контейнеров C4](/Task3Advanced/c4/context.puml)
  [схема контейнеров PNG](/Task3Advanced/images/context.png)

  [компоненты системы C4](/Task3Advanced/c4/components/)
  [компоненты системы PNG](/Task3Advanced/images/components/)

  [Карта рисков трансформации и план управления рисками](/Task3Advanced/README.md)

## Задание 4. Моделирование домена и интеграций
  
  [Схема bounded contexts](/Task4Advanced/bounded-contexts.puml)
  [Схема bounded contexts PNG](/Task4Advanced/images/bounded-contexts.png)
  
  [Event Storming (событийная схема)](/Task4Advanced/event-storming.puml)
  [Event Storming (событийная схема) PNG](/Task4Advanced/images/event-storming.png)
  
  [Описание агрегатов (границы, инварианты, ключи)](/Task4Advanced/aggregates.md)
  
  [Каталог доменных событий (название, контекст-источник, семантика, минимальный контракт)](/Task4Advanced/events.md)
  
  [Обоснование событийного подхода vs Camel/DWH](/Task4Advanced/justification.md)


