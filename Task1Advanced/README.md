# Terraform VM Module

Модуль для развёртывания ВМ в Yandex Cloud: `dev`, `stage`, `prod`.

## ⚙️ Переменные модуля (`modules/vm/variables.tf`)
| Переменная       | Тип         | Описание                          |
| ---------------- | ----------- | --------------------------------- |
| `vm_name`        | string      | Имя ВМ                            |
| `cores`          | number      | Ядра CPU                          |
| `memory`         | number      | RAM (ГБ)                          |
| `disk_size`      | number      | Размер диска                      |
| `disk_type`      | string      | Тип: `network-ssd`, `network-hdd` |
| `zone`           | string      | Зона, например `ru-central1-a`    |
| `image_family`   | string      | ОС: `ubuntu-2004-lts`             |
| `subnet_id`      | string      | ID подсети                        |
| `ssh_public_key` | string      | SSH-ключ (`ssh-rsa ...`)          |
| `environment`    | string      | `dev`/`stage`/`prod`              |
| `labels`         | map(string) | Метки, например `{"env": "dev"}`  |

---

## 📤 Выходы
| Выход           | Описание      |
| --------------- | ------------- |
| `instance_id`   | ID ВМ         |
| `instance_name` | Имя ВМ        |
| `internal_ip`   | Внутренний IP |
| `external_ip`   | Публичный IP  |
| `disk_id`       | ID диска      |

---

## 🌍 Как использовать (пример для `dev`)
Dev зона уже настроена и содержит все нужные переменные и ключи,
переменные не хардкод, а указаны в переменных окружения.

Последовательность событий по развертыванию виртуальной машины в dev зоны представлено следующими слайдами в директории Images:
  Предварительные шаги по настройке развертывания VM (настройка провайдеров terraform и yandex cloud)
  1. [Установка terraform](/images/dev/версия%20terraform.png)
  2. [Информация об облаке](/images/dev/информация%20об%20облаке.png)
  3. [Создание бакета в яндекс клауд](/images/dev/бакет%20для%20dev.png)
  4. [Получение авторизованного ключа](/images/dev/авторизованный%20ключ.png)
  5. [Выдача права доступа `editor`](/images/dev/выдаем%20права%20доступа%20(editor)%20для%20yandex-practicum.png)
  6. [Просмотр подсетей дабы установить переменную subnet_id](/images/dev/просмотр%20подсетей.png)
  7. [Установка провайдеров terraform локально (так как не было доступа к registry)](/images/dev/настройка%20провайдеров%20локально%20(установка%20для%20активного%20пользователя).png)

  Развертывание VM с использованием terraform (после прохождения всех предварительных шагов)
  1. [Init](/images/dev/terraform%20init%20-%20успех.png)
  2. [Plan](/images/dev/terraform%20plan%20-%20успех.png)
  3. [Apply](/images/dev/terraform%20apply%20-%20успех.png)
  4. [Show](/images/dev/terraform%20show%20и%20внешний%20ip%20адрес%20(проверка).png)
  5. [Destroy](/images/dev/terraform%20destroy%20-%20успех.png)


```bash
cd envs/dev
Задайте переменные в terraform.tfvars:
hcl
vm_name        = "dev-vm"
cores          = 2
memory         = 4
disk_size      = 20
subnet_id      = "e9bnko718dlfitt039sq"
ssh_public_key = "ssh-rsa AAA..."
environment    = "dev"
labels         = { env = "dev" }
```

Запуск:
```bash
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars

-- просмотреть результаты
terraform show 
```

