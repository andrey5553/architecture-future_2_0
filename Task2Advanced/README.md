# 🚀 Задание 2: Настройка CI/CD и Remote State

В этом задании реализована автоматизированная система развёртывания инфраструктуры с использованием:
- **GitHub Actions** — для CI/CD;
- **Yandex Object Storage (S3)** — для хранения удалённого состояния Terraform;
- **Безопасной передачи секретов**;
- **Защиты от разрушительных изменений**.
---

# Terraform CI/CD Pipeline для Yandex Cloud
  ## Архитектура
  - S3 backend для хранения state (Yandex Object Storage)
  - GitHub Actions для CI/CD
  - Модульная структура (modules/vm)
  ## Security
  - Все credentials в GitHub Secrets
  - Разные окружения (dev/stage/prod) с разными переменными
  - State не хранится локально
  ## Процесс
  1. Pull Request → Terraform Plan
  2. Push в dev/stage → Auto-apply
  3. Manual trigger для prod

## ☁️ Remote State: S3 (Yandex Object Storage)

Состояние Terraform хранится в **удалённом бакете**, чтобы:
- Избежать потери состояния;
- Обеспечить совместную работу;
- Предотвратить конфликты.

### 🔧 Настройка бэкенда

Файл: `envs/dev/backend.tf`
```hcl
terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket     = "mihailenko.a1-backet"
    region     = "ru-central1"
    key        = "dev/vm.tfstate"
    
    # Обязательные параметры для Yandex S3
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
    
    use_path_style              = true
    # disable_compute_service_status = true
  }
}
```

Аналогично для stage и prod (разные key).

🔐 Бакет mihailenko.a1-backet должен быть создан вручную.

## 🔐 Аутентификация
В CI/CD используются:
| Переменная                         | Назначение                               |
| ---------------------------------- | ---------------------------------------- |
| YC_TOKEN                           | OAuth-токен для Yandex Cloud (провайдер) |
| YC_ACCESS_KEY / YC_SECRET_KEY      | Ключи доступа к S3 (Object Storage)      |
| YC_SUBNET_ID, SSH_PUBLIC_KEY и др. | Параметры инфраструктуры                 |

Передаются через GitHub Secrets.

## 🔄 CI/CD: GitHub Actions
Файл: [.github/workflows/terraform.yml](../.github/workflows/terraform.yml)

## ✅ Триггеры

- При PR в ветки: main, master, dev, stage, prod → запускается plan.
- При пуше в ветку dev (делал для тестирования развертывания в этом окружении)
- Ручной запуск (workflow_dispatch) → apply.

## 🛠 Этапы пайплайна (для каждого окружения)

- Checkout → клонирование репозитория;
- Setup Terraform → установка нужной версии;
- Cache → кеширование .terraform/ для ускорения init;
- Init → загрузка бэкенда и провайдеров;
- Validate → проверка синтаксиса;
- Plan → вывод изменений (сохраняется в tfplan);
- Check for Destructive Changes → анализ tfplan на удаление ресурсов;
- Apply → ручное применение (только при workflow_dispatch).

## 🔒 Безопасность

- Секреты не хранятся в коде — используются secrets GitHub;
- Все переменные передаются через TF_VAR_* в env;
- Проверка на разрушительные изменения (delete) перед apply;
- Только workflow_dispatch может запустить apply — нельзя автоматически уничтожить prod.

## Используемые инструменты
| Инструмент                | Назначение                              |
| ------------------------- | --------------------------------------- |
| terraform                 | Управление инфраструктурой              |
| jq                        | Анализ JSON-вывода terraform show -json |
| actions/checkout          | Клонирование репозитория                |
| hashicorp/setup-terraform | Установка Terraform                     |
| actions/cache             | Кеширование init                        |

## 🛡 Проверка на разрушительные изменения
После terraform plan -out=tfplan, анализируется файл:

```bash
terraform show -json tfplan | jq -e '.resource_changes[] | select(.change.actions[] == "delete")'
```

Если найдены удаления — пайплайн падает, и применение останавливается.
Это предотвращает случайное удаление ВМ, дисков, бакетов и т.д.

## ✅ Как использовать

### 1. Настройка GitHub Secrets
Добавьте в Settings → Secrets and variables → Actions:
```
YC_TOKEN
YC_CLOUD_ID
YC_FOLDER_ID
YC_ACCESS_KEY
YC_SECRET_KEY
YC_SUBNET_ID
SSH_PUBLIC_KEY
```
### 2. Создание бакета
В Yandex Cloud → Object Storage:

* Имя: mihailenko.a1-backet
* Регион: ru-central1
* Роли: storage.admin для сервисного аккаунта

### 3. Запуск
Откройте PR → увидите plan.
Вручную запустите Apply через "Run workflow".

### 4. Примеры работ по настройке и получению переменных:
[Установка публичных переменных](/images/публичные%20переменные.png)
[yc client получение списка приватных переменных 1](/images/yc%20получение%20списка%20параметров%20и%20переменных.png)
[yc client получение списка приватных переменных 2](/images/yc%20получение%20списка%20параметров%20и%20переменных%20-%20продолжение.png)
[CI CD terraform 1 - успех](/images/terraform%20CI_CD%20-%20успех%20.png)
[CI CD terraform 2 - успех](/images/terraform%20CI_CD%20-%20успех%202.png)
[план развертывания VM](/images/terraform%20plan%20result.png)
[параметры созданной VM](/images/параметры%20созданной%20VM.png)
[список моих VM](/images/Список%20VM%20в%20folder.png)
[публичные переменные](/images/публичные%20переменные.png)
[состояние инфраструктуры](/images/состояние%20инфраструктуры%20VM.png)
Файл dev/vm.tfstate (8 КБ) — это состояние инфраструктуры. 
Этот файл — "источник истины" для Terraform. В нём в формате JSON хранится вся информация о созданных ресурсах: 
ID виртуальной машины, её сетевые настройки, диски, метаданные и т.д. Размер в 8 КБ для одной VM — это нормально.

Проверка созданной VM
# Проверьте список VM в вашем folder
yc compute instance list

# Детальная информация о VM (используйте имя из workflow)
yc compute instance get mikhailenko-vm-dev-7627ce52

# Проверьте параметры созданной VM
yc compute instance get mikhailenko-vm-dev-7627ce52 --full

