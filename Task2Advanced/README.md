# 🚀 Задание 2: Настройка CI/CD и Remote State

В этом задании реализована автоматизированная система развёртывания инфраструктуры с использованием:
- **GitHub Actions** — для CI/CD;
- **Yandex Object Storage (S3)** — для хранения удалённого состояния Terraform;
- **Безопасной передачи секретов**;
- **Защиты от разрушительных изменений**.


---

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
    endpoint   = "https://storage.yandexcloud.net"
    bucket     = "tf-state-future2"
    region     = "ru-central1"
    key        = "dev/vm.tfstate"
    force_path_style = true
    skip_region_validation = true
  }
}
```

Аналогично для stage и prod (разные key).

🔐 Бакет tf-state-future2 должен быть создан вручную.

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
- terraform.tfvars не коммитится в репозиторий;
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

* Имя: tf-state-future2
* Регион: ru-central1
* Роли: storage.admin для сервисного аккаунта

### 3. Запуск
Откройте PR → увидите plan.
Вручную запустите Apply через "Run workflow".

Примеры работ по настройке и получению переменных:
[Установка публичных переменных](/images/публичные%20переменные.png)
[yc client получение списка приватных переменных 1](/images/yc%20получение%20списка%20параметров%20и%20переменных.png)
[yc client получение списка приватных переменных 2](/images/yc%20получение%20списка%20параметров%20и%20переменных%20-%20продолжение.png)